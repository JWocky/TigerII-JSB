

#On verifie et on largue
var dropTanks = func(){
        for(var i = 2 ;i < 5 ; i = i + 1 ){
           var select = getprop("sim/weight["~ i ~"]/selected");
           if(select == "droptank"){ load.dropLoad(i);}

        }
}

var Clean = func(){

        
        setprop("sim/weight[0]/selected", "NONE");
        setprop("sim/weight[1]/selected", "NONE");
        setprop("sim/weight[2]/selected", "NONE");
        setprop("sim/weight[3]/selected", "NONE");
		setprop("sim/weight[4]/selected", "NONE");
		setprop("sim/weight[5]/selected", "NONE");
		setprop("sim/weight[6]/selected", "NONE");
        

}


var Ferry = func(){


         setprop("consumables/fuel/tank[3]/selected", 0);
        setprop("consumables/fuel/tank[3]/capacity-gal_us", 0);
        setprop("consumables/fuel/tank[3]/level-gal_us", 0);
		setprop("consumables/fuel/tank[4]/selected", 0);
        setprop("consumables/fuel/tank[4]/capacity-gal_us", 0);
        setprop("consumables/fuel/tank[4]/level-gal_us", 0);
		 setprop("consumables/fuel/tank[5]/selected", 0);
        setprop("consumables/fuel/tank[5]/capacity-gal_us", 0);
        setprop("consumables/fuel/tank[5]/level-gal_us", 0);
        
        setprop("sim/weight[0]/selected", "AIM-9");
        setprop("sim/weight[1]/selected", "NONE");
        setprop("sim/weight[2]/selected", "Ferrytank");
        setprop("sim/weight[3]/selected", "Ferrytank");
		setprop("sim/weight[4]/selected", "Ferrytank");
		setprop("sim/weight[5]/selected", "NONE");
		setprop("sim/weight[6]/selected", "AIM-9");
		setprop("consumables/fuel/tank[3]/selected", 1);
        setprop("consumables/fuel/tank[3]/capacity-gal_us", 275);
        setprop("consumables/fuel/tank[3]/level-gal_us", 275);
		setprop("consumables/fuel/tank[4]/selected", 1);
        setprop("consumables/fuel/tank[4]/capacity-gal_us", 275);
        setprop("consumables/fuel/tank[4]/level-gal_us", 275);
		setprop("consumables/fuel/tank[5]/selected", 1);
        setprop("consumables/fuel/tank[5]/capacity-gal_us", 275);
        setprop("consumables/fuel/tank[5]/level-gal_us", 275);
        

}


var CAP = func(){

 

        setprop("sim/weight[0]/selected", "AIM-9");
        setprop("sim/weight[1]/selected", "AIM-120");
        setprop("sim/weight[2]/selected", "AIM-120");
        setprop("sim/weight[3]/selected", "NONE");
		setprop("sim/weight[4]/selected", "AIM-120");
		setprop("sim/weight[5]/selected", "AIM-120");
        setprop("sim/weight[6]/selected", "AIM-9");
		

}


var CAPextended = func(){


        setprop("consumables/fuel/tank[4]/selected", 0);
        setprop("consumables/fuel/tank[4]/capacity-gal_us", 0);
        setprop("consumables/fuel/tank[4]/level-gal_us", 0);


        setprop("sim/weight[0]/selected", "AIM-9");
        setprop("sim/weight[1]/selected", "AIM-120");
        setprop("sim/weight[2]/selected", "AIM-120");
        setprop("sim/weight[3]/selected", "Ferrytank");
		setprop("sim/weight[4]/selected", "AIM-120");
		setprop("sim/weight[5]/selected", "AIM-120");
        setprop("sim/weight[6]/selected", "AIM-9");
		setprop("consumables/fuel/tank[4]/selected", 1);
        setprop("consumables/fuel/tank[4]/capacity-gal_us", 275);
        setprop("consumables/fuel/tank[4]/level-gal_us", 275);


}


var bombrun = func(){


        


        setprop("sim/weight[0]/selected", "AIM-9");
        setprop("sim/weight[1]/selected", "MK-82");
        setprop("sim/weight[2]/selected", "MK-82");
        setprop("sim/weight[3]/selected", "MK-82");
		setprop("sim/weight[4]/selected", "MK-82");
		setprop("sim/weight[5]/selected", "MK-82");
        setprop("sim/weight[6]/selected", "AIM-9");
		


}

var bombrunheavy = func(){


        


        setprop("sim/weight[0]/selected", "AIM-9");
        setprop("sim/weight[1]/selected", "MK-82");
        setprop("sim/weight[2]/selected", "MK-83");
        setprop("sim/weight[3]/selected", "MK-83");
		setprop("sim/weight[4]/selected", "MK-83");
		setprop("sim/weight[5]/selected", "MK-82");
        setprop("sim/weight[6]/selected", "AIM-9");
		


}

var bombrunlong = func(){

        setprop("consumables/fuel/tank[3]/selected", 0);
        setprop("consumables/fuel/tank[3]/capacity-gal_us", 0);
        setprop("consumables/fuel/tank[3]/level-gal_us", 0);
		setprop("consumables/fuel/tank[5]/selected", 0);
        setprop("consumables/fuel/tank[5]/capacity-gal_us", 0);
        setprop("consumables/fuel/tank[5]/level-gal_us", 0);
        


        setprop("sim/weight[0]/selected", "AIM-9");
        setprop("sim/weight[1]/selected", "MK-82");
        setprop("sim/weight[2]/selected", "Droptank");
        setprop("sim/weight[3]/selected", "MK-83");
		setprop("sim/weight[4]/selected", "Droptank");
		setprop("sim/weight[5]/selected", "MK-82");
        setprop("sim/weight[6]/selected", "AIM-9");
		setprop("consumables/fuel/tank[3]/selected", 1);
        setprop("consumables/fuel/tank[3]/capacity-gal_us", 150);
        setprop("consumables/fuel/tank[3]/level-gal_us", 150);
		setprop("consumables/fuel/tank[5]/selected", 1);
        setprop("consumables/fuel/tank[5]/capacity-gal_us", 150);
        setprop("consumables/fuel/tank[5]/level-gal_us", 150);
		
		


}


var GAmulti = func(){

       
        


        setprop("sim/weight[0]/selected", "AIM-9");
        setprop("sim/weight[1]/selected", "MK-82");
        setprop("sim/weight[2]/selected", "Matra");
        setprop("sim/weight[3]/selected", "MK-83");
		setprop("sim/weight[4]/selected", "Matra");
		setprop("sim/weight[5]/selected", "MK-82");
        setprop("sim/weight[6]/selected", "AIM-9");
		
		
		


}
var GAmultiextended = func(){


        setprop("consumables/fuel/tank[4]/selected", 0);
        setprop("consumables/fuel/tank[4]/capacity-gal_us", 0);
        setprop("consumables/fuel/tank[4]/level-gal_us", 0);


        setprop("sim/weight[0]/selected", "AIM-9");
        setprop("sim/weight[1]/selected", "MK-82");
        setprop("sim/weight[2]/selected", "Matra");
        setprop("sim/weight[3]/selected", "Droptank");
		setprop("sim/weight[4]/selected", "Matra");
		setprop("sim/weight[5]/selected", "MK-82");
        setprop("sim/weight[6]/selected", "AIM-9");
		setprop("consumables/fuel/tank[4]/selected", 1);
        setprop("consumables/fuel/tank[4]/capacity-gal_us", 150);
        setprop("consumables/fuel/tank[4]/level-gal_us", 150);


}







#La boite de dialogue
var ext_loads_dlg = gui.Dialog.new("dialog","Aircraft/F-5E/Dialogs/external-loads.xml");

#Begining of the dropable function.
#It has to be simplified and generic made
#Need to know how to make a table
dropLoad = func (number) {
          var select = getprop("sim/weight["~ number ~"]/selected");
          if(select != "none"){
                if(select == "Droptank"){
                     tank_submodel(number,select);
                     setprop("consumables/fuel/tank["~ number ~"]/selected", 0);
                     settimer(func load.dropLoad_stop(number),2);
                     setprop("controls/armament/station["~ number ~"]/release", 1);
                     setprop("sim/weight["~ number ~"]/selected", "none");
                     setprop("sim/weight["~ number ~"]/weight-lb", 0);
                }else{
                     load.dropMissile(number);
                     settimer(func load.dropLoad_stop(number),0.5);
                }


           }

           
}


#Need to be changed
dropLoad_stop = func(n) {     
         setprop("controls/armament/station["~ n ~"]/release", 0);
}





dropMissile = func (number) { 

  var target  = hud.closest_target();
  if(target == nil){ return;}

  
        #print(typeMissile);


          var typeMissile = getprop("sim/weight["~ number ~"]/selected");
          missile.Loading_missile(typeMissile);
          Current_missile = missile.MISSILE.new(number);
          Current_missile.status = 0;
          Current_missile.search(target);             
          Current_missile.release();
          setprop("controls/armament/station["~ number ~"]/release", 1);
          setprop("sim/weight["~ number ~"]/selected", "none");
          setprop("sim/weight["~ number ~"]/weight-lb", 0);
     

}

var tank_submodel = func (pylone, select){

        #Drop Tanks
        if(pylone == 2 and select == "Droptank"){ setprop("controls/armament/station[2]/release-droptank", 1);}
        if(pylone == 3 and select == "Droptank"){ setprop("controls/armament/station[3]/release-droptank", 1);}
        if(pylone == 4 and select == "Droptank"){ setprop("controls/armament/station[4]/release-droptank", 1);}


}




