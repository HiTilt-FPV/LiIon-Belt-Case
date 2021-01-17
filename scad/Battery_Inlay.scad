
//Use this to cut the batteryout of your Pack:

//battery(1,1,1);

//poleElectrode(1,1,1,1);


//Global Variables
$fa = 3;
$fs = 1;

//Battery Measures
batDia = 18.6; //add tolerances!
batLength = 65; //add tolerances!

//Battery Pole Elektrodes (do not change)
addPosPole = 0;
addNegPole = 0;
Mount = 0;
Pole = 0;
    
    //measures of a single Pole mount
poleThickness = .6;
poleMountThickness = 1.2;

    //measures of an electrode
poleDia = 11;

    //measures of the Solderpad
padWidth = 4;
padLength = 8;

    //total length of electrical poles
posPoleLength = poleThickness + poleMountThickness + 1;
negPoleLength = poleThickness + poleMountThickness + 8;

addFullCutout = 0;

//MODULES
module battery(addPosPole, addNegPole, addFullCutout){
    if(addFullCutout == 0){
        cylinder(batLength, batDia/2, batDia/2, center=true);
        if(addPosPole == 1) translate([0,0,batLength/2+posPoleLength/2])
            color("green") cylinder(posPoleLength, batDia/2, batDia/2, center=true);
        if(addNegPole == 1) translate([0,0,-batLength/2-negPoleLength/2])
            color("red")cylinder(negPoleLength, batDia/2, batDia/2, center=true);
    }
    
    if(addFullCutout == 1){
        hull(){
            cylinder(batLength, batDia/2, batDia/2, center=true);
            translate([batDia/2,0,0]) cube([batDia/2, batDia, batLength], center=true);
        }
        if(addPosPole == 1) translate([0,0,batLength/2+posPoleLength/2]) hull(){
            cylinder(posPoleLength, batDia/2, batDia/2, center=true);
            translate([batDia/2,0,0]) cube([batDia/2, batDia, posPoleLength], center=true);
        }
        if(addNegPole == 1) translate([0,0,-batLength/2-negPoleLength/2]) hull(){
            cylinder(negPoleLength, batDia/2, batDia/2, center=true);
            translate([batDia/2,0,0]) cube([batDia/2, batDia, negPoleLength], center=true);
        }
    }
}

module electrode(Mount,Pole){
    if(Mount ==1) difference(){
        hull(){
            cylinder(poleMountThickness*2+poleThickness, batDia/2, batDia/2, center=true);
            translate([batDia/2,0,0]) cube([batDia/2, batDia, poleMountThickness*2+poleThickness], center=true);
        }
        hull(){
            cylinder(poleThickness, batDia/2, batDia/2, center=true);
            translate([batDia/2,0,0]) cube([batDia/2, batDia, poleThickness], center=true);
        }
        hull(){
            cylinder(poleMountThickness*2+poleThickness, poleDia/2, poleDia/2, center=true);
            translate([batDia,0,0]) cube([poleDia/2, poleDia, poleMountThickness*2+poleThickness], center=true);
        }
    }
    
    //Battery Pole
    if(Pole ==1) union(){
        hull(){
            cylinder(poleThickness, batDia/2, batDia/2, center=true);
            translate([batDia/4,0,0]) cube([batDia/2, batDia, poleThickness], center=true);
        }
        //Solder Contact
        translate([-batDia/2-padLength/2+1,0,0]) cube([padLength, padWidth, poleThickness], center=true);
    }
}

module poleElectrode(addPosPole, addNegPole, Mount, Pole){
    if(addPosPole == 1)intersection(){
        translate([0,0,batLength/2+posPoleLength-poleThickness/2]) electrode(Mount,Pole);
        translate([0,0,+batLength/2+posPoleLength/2]) cube([batDia+batDia/2+padLength, batDia, posPoleLength], center=true);
    }
    if(addNegPole == 1)intersection(){
        translate([0,0,-batLength/2-negPoleLength+poleThickness/2]) electrode(Mount,Pole);
        translate([0,0,-batLength/2-negPoleLength/2]) cube([batDia+batDia/2+padLength, batDia, negPoleLength], center=true);
    }
}

    

//MAIN


%battery(1,1,1);

%poleElectrode(1,1,1,0);
