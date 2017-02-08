# Properties under /consumables/fuel/tank[n]:
# + level-gal_us    - Current fuel load.  Can be set by user code.
# + level-lbs       - OUTPUT ONLY property, do not try to set
# + selected        - boolean indicating tank selection.
# + density-ppg     - Fuel density, in lbs/gallon.
# + capacity-gal_us - Tank capacity
#
# Properties under /engines/engine[n]:
# + fuel-consumed-lbs - Output from the FDM, zeroed by this script
# + out-of-fuel       - boolean, set by this code.


var UPDATE_PERIOD = 0.3;

var enabled = nil;
var serviceable = nil;
var fuel_freeze = nil;
var ai_enabled = nil;
var engines = nil;
var tanks = [];
var refuelingN = nil;
var contactN = nil;
var aimodelsN = nil;
var types = {};

var update_loop = func {
	# check for contact with tanker aircraft
	var tankers = [];
	var activeTanker=-1;
	var activeDistance=456.25;
	var actualDistance=100000;
	if (ai_enabled) {
		var ac = getprop("ai/models/num-players");
		
		for (var i=0; i<ac; i=i+1) {
			var test="ai/models/multiplayer["~i~"]/tanker";
#print("pilot "~getprop("ai/models/multiplayer["~i~"]/callsign"));
			if (getprop(test)) {
#print("is tanker at "~getprop("ai/models/multiplayer["~i~"]/radar/range-nm"));
				actualDistance=getprop("ai/models/multiplayer["~i~"]/radar/range-nm");
				if (actualDistance==nil) {
					actualDistance=1000000;
#print("no distance received");
				}
				if (actualDistance*1825<activeDistance) {
#print("distance < activeDistance ("~activeDistance~")");
					append(tankers, i);				
					activeDistance=getprop("ai/models/multiplayer["~i~"]/radar/range-nm")*1825;
					activeTanker=i;
				}
			}
		}
	}

	var refueling = serviceable and activeTanker > -1;
#print("refueling ", refueling);
#print("serviceable ", serviceable);
#print("activeTanker ", activeTanker);
	
	if (refuelingN.getNode("report-contact", 1).getValue()) {
		if (refueling and !contactN.getValue()) {
			setprop("/sim/messages/copilot", "Engage");
		}
	  
		if (!refueling and contactN.getValue()) {
			setprop("/sim/messages/copilot", "Disengage");
		}
	}
	
	contactN.setBoolValue(refueling);
	if (fuel_freeze) return settimer(update_loop, UPDATE_PERIOD);

	# sum up consumed fuel
	var consumed = 0;
	foreach (var e; engines) {
		var fuel = e.getNode("fuel-consumed-lbs");
		consumed += fuel.getValue();
		fuel.setDoubleValue(0);
#print("consumed ", consumed);
	}

	# calculate fuel received
	if (refueling) {
		# Flow rate is the minimum of the tanker maxium rate
		# and the aircraft maximum rate.  Both are expressed
		# in lbs/min
		var fuel_rate = 6000;
		if (getprop("systems/refuel/max-fuel-transfer-lbs-min")<fuel_rate) {
			fuel_rate=getprop("systems/refuel/max-fuel-transfer-lbs-min");
		}

		var received =  UPDATE_PERIOD * fuel_rate / 60;
#print("fuel received "~received);
		consumed -= received;
	}


	# make list of selected tanks
	var selected_tanks = [];
	foreach (var t; tanks) {
		var cap = t.getNode("capacity-gal_us", 1).getValue();
		if (cap != nil and cap > 0.01 and t.getNode("selected", 1).getBoolValue())
			append(selected_tanks, t);
	}


	var out_of_fuel = 0;
	if (size(selected_tanks) == 0) {
		out_of_fuel = 1;

	} elsif (consumed >= 0) {
		var fuel_per_tank = consumed / size(selected_tanks);
		foreach (var t; selected_tanks) {
			var ppg = t.getNode("density-ppg").getValue();
			var lbs = t.getNode("level-gal_us").getValue() * ppg;
			lbs -= fuel_per_tank;

			if (lbs < 0) {
				lbs = 0;
				# Kill the engines if we're told to, otherwise simply
				# deselect the tank.
				if (t.getNode("kill-when-empty", 1).getBoolValue())
					out_of_fuel = 1;
				else
					t.getNode("selected", 1).setBoolValue(0);
			}

			var gals = lbs / ppg;
			t.getNode("level-gal_us").setDoubleValue(gals);
			t.getNode("level-lbs").setDoubleValue(lbs);
		}

	} else {
		#find the number of tanks which can accept fuel
		var available = 0;

		foreach (var t; selected_tanks) {
			var ppg = t.getNode("density-ppg").getValue();
			var capacity = t.getNode("capacity-gal_us").getValue() * ppg;
			var lbs = t.getNode("level-gal_us").getValue() * ppg;

			if (lbs < capacity) available += 1;
		}

		if (available > 0) {
			var fuel_per_tank = -consumed / available;

			# add fuel to each available tank
			foreach (var t; selected_tanks) {
				var ppg = t.getNode("density-ppg").getValue();
				var capacity = t.getNode("capacity-gal_us").getValue() * ppg;
				var lbs = t.getNode("level-gal_us").getValue() * ppg;

				lbs += fuel_per_tank;
				if (lbs > capacity)
					lbs = capacity;

				t.getNode("level-gal_us").setDoubleValue(lbs / ppg);
				t.getNode("level-lbs").setDoubleValue(lbs);
			}

			#print("available ", available , " fuel_per_tank " , fuel_per_tank);
		}
	}


	var gals = 0;
	var lbs = 0;
	var cap = 0;
	foreach (var t; tanks) {
		gals += t.getNode("level-gal_us", 1).getValue();
		lbs += t.getNode("level-lbs", 1).getValue();
		cap += t.getNode("capacity-gal_us", 1).getValue();
	}

	setprop("/consumables/fuel/total-fuel-gals", gals);
	setprop("/consumables/fuel/total-fuel-lbs", lbs);
	if (cap == 0)
		setprop("/consumables/fuel/total-fuel-norm", 0);
	else
		setprop("/consumables/fuel/total-fuel-norm", gals / cap);

	foreach (var e; engines)
		e.getNode("out-of-fuel", 1).setBoolValue(out_of_fuel);

	settimer(update_loop, UPDATE_PERIOD);
}


#print("AAR initializing ");

setlistener("/sim/signals/fdm-initialized", func {
	if (contains(globals, "fuel") and typeof(fuel) == "hash") fuel.loop = func nil;       # kill $FG_ROOT/Nasal/fuel.nas' loop

	contactN = props.globals.initNode("/systems/refuel/contact", 0, "BOOL");
#print("contactN ", contactN);
	refuelingN = props.globals.getNode("/systems/refuel", 1);
#print("refuelingN ", refuelingN);
	aimodelsN = props.globals.getNode("ai/models", 1);
#print("aimodelsN ", aimodelsN);
	engines = props.globals.getNode("engines", 1).getChildren("engine");
#print("engines ", engines);

	foreach (var e; engines) {
		e.getNode("fuel-consumed-lbs", 1).setDoubleValue(0);
		e.getNode("out-of-fuel", 1).setBoolValue(0);
	}

	foreach (var t; props.globals.getNode("consumables/fuel", 1).getChildren("tank")) {
		if (!t.getAttribute("children")) continue;           # skip native_fdm.cxx generated zombie tanks
		append(tanks, t);
		t.initNode("level-gal_us", 0.0);
		t.initNode("level-lbs", 0.0);
		t.initNode("capacity-gal_us", 0.01); # not zero (div/zero issue)
		t.initNode("density-ppg", 6.0);      # gasoline
		t.initNode("selected", 1, "BOOL");
	}

	foreach (var t; props.globals.getNode("systems/refuel", 1).getChildren("type")) types[t.getValue()] = 1;

	setlistener("sim/freeze/fuel", func(n) fuel_freeze = n.getBoolValue(), 1);
	setlistener("sim/ai/enabled", func(n) ai_enabled = n.getBoolValue(), 1);
	setlistener("systems/refuel/serviceable", func(n) serviceable = n.getBoolValue(), 1);
	update_loop();

});


