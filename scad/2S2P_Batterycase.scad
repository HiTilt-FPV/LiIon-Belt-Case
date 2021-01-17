
//to use this, call

//projection(cut=true) translate([0,0,26]) batterycase();
//intersection(){
    batterycase();
    //translate([-10,20,-35]) cube([50,70,30], center=true);
//}
    
    

//module strainRelief() 


/*
//simulate batteries in the trays
%union(){ 
battery(0,0,0);
translate([0,batDia + addBatSpace,0]) battery(0,0,0);
translate([0,batDia*2 + addBatSpace*2,0]) battery(0,0,0);
translate([-batDia + addBatSpace/2,batDia/2 + addBatSpace/2,0]) battery(0,0,0);
}
*/

//Other OpenSCAD Products
use <Battery_Inlay.scad>
use <Cable_Strain_Relief.scad>


//Global Variables
$fa = 3;
$fs = 1;


//Battery Meas
batDia = 18.6; //add tolerances!
addBatSpace = 1.5;
addOutsideBatSpace = 1.5;
batLength = 65; //add tolerances!

    //measures of a single Pole mount
poleThickness = .6;
poleMountThickness = 1.2;

    //total length of electrical poles
posPoleLength = poleThickness + poleMountThickness + 1;
negPoleLength = poleThickness + poleMountThickness + 8;

smoothEdges = 2;

//Electronics Bay
xElectronicsBay = 20;
yElectronicsBay = 23;
zElectronicsBay = batLength + 30;

    //Electronics Bay offset
xtransElectronicsBay = -20;
ytransElectronicsBay = 31.5;
ztransElectronicsBay = -1.5;

//Cable Outlet
rightPocket = 1;
cableDia = 4;
cableLength = 10;
cableStrainInset = 2.5;


//MODULES

module hulledBatteries() hull(){
    minkowski(){
        hull(){
            battery(1,1,0);
            translate([0,batDia + addBatSpace,0]) battery(1,1,0);
            translate([0,batDia*2 + addBatSpace*2,0]) battery(1,1,0);
        }
        cube([.1,addOutsideBatSpace*2,.1], center=true);
    }
    minkowski(){
        translate([-batDia + addBatSpace/2,batDia/2 + addBatSpace/2,0]) battery(1,1,0);
        cube([addOutsideBatSpace*2,.1,.1], center=true);
    }
}


/* OLD AND CLUMSY BATTERY HULLING (added way to much volume to the pack and made it hard to take batteries out of the pack)
module hulledBatteries() minkowski(){
    hull(){
        battery(1,1,0);
        translate([0,batDia + addBatSpace,0]) battery(1,1,0);
        translate([0,batDia*2 + addBatSpace*2,0]) battery(1,1,0);
        translate([-batDia + addBatSpace/2,batDia/2 + addBatSpace/2,0]) battery(1,1,0);
    }
    //cylinder(.1, addBatSpace, addBatSpace, center=true);
}
*/

//MAIN

module batterycase(){


//top and Bottom Coverplates
difference(){
    minkowski(){
        hulledBatteries();
        sphere(smoothEdges);
    }
    translate([0,0,-.1]) minkowski(){
        hulledBatteries();
        cylinder(.001, smoothEdges, smoothEdges, center=true);
    }
    
    //Cable Outlets for right Pocket or Left pocket
    if(rightPocket == 0) translate([-batDia/2+cableStrainInset, batDia + batDia/2 + addBatSpace + addBatSpace/2, batLength/2+posPoleLength-cableLength-.2]) cableOutlet(1);
    
    if(rightPocket == 1) translate([-batDia/2+cableStrainInset, batDia + batDia/2 + addBatSpace + addBatSpace/2, -batLength/2-negPoleLength+cableLength])rotate([0,180,0]) cableOutlet(1);
}

difference(){
    minkowski(){
        hulledBatteries();
        sphere(smoothEdges);
    }
    translate([0,0,+.1]){ minkowski(){
        hulledBatteries();
        cylinder(.001, smoothEdges, smoothEdges, center=true);
    }
    
    //Cable Outlets for right Pocket or Left pocket
    if(rightPocket == 0) translate([-batDia/2+cableStrainInset, batDia + batDia/2 + addBatSpace + addBatSpace/2, batLength/2+posPoleLength-cableLength-.2]) cableOutlet(1);
    
    if(rightPocket == 1) translate([-batDia/2+cableStrainInset, batDia + batDia/2 + addBatSpace + addBatSpace/2, -batLength/2-negPoleLength+cableLength])rotate([0,180,0]) cableOutlet(1);
    }
}


difference(){
    hulledBatteries();
    
//the battery Case Cutouts
    battery(1,1,1);
    translate([0,batDia + addBatSpace,0]) battery(1,1,1);
    translate([0,batDia*2 + addBatSpace*2,0]) battery(1,1,1);
    translate([-batDia + addBatSpace/2,batDia/2 + addBatSpace/2,0]) rotate([0,0,-120]) battery(1,1,1);

//the Pos. and Neg. Electrode Cutouts (with Solderflags)
    poleElectrode(0,0,0,1);
    translate([0,batDia + addBatSpace,0]) poleElectrode(1,1,0,1);
    translate([0,batDia*2 + addBatSpace*2,0]) poleElectrode(1,1,0,1);
    translate([-batDia + addBatSpace/2,batDia/2 + addBatSpace/2,0]) rotate([0,0,-120]) poleElectrode(1,1,0,1);
    
    translate([xtransElectronicsBay, ytransElectronicsBay, ztransElectronicsBay]) cube([xElectronicsBay, yElectronicsBay, zElectronicsBay], center=true);
    
    // 2S2P Pole Interconnections
    translate([7,10,-42+.6]) cube([5,10,.6+1.2], center=true);
    translate([7,10,35-.6]) cube([5,10,.6+1.2], center=true);
    
    //Cable Outlets for right Pocket or Left pocket
    if(rightPocket == 0) translate([-batDia/2+cableStrainInset, batDia + batDia/2 + addBatSpace + addBatSpace/2, batLength/2+posPoleLength-cableLength+.1]){
        rotate([0,0,45]) cableStrain();
        translate([-4.2,0,0]) cableRelief(0);
        //cylinder(cableLength, cableDia/2, cableDia/2, center=true);
    }
    
    if(rightPocket == 1) translate([-batDia/2+cableStrainInset, batDia + batDia/2 + addBatSpace + addBatSpace/2, -batLength/2-negPoleLength+cableLength-.1]){
        rotate([0,180,225]) cableStrain();
        translate([-4.2,0,0]) rotate([0,180,0]) cableRelief(0);
        //cylinder(cableLength, cableDia/2, cableDia/2, center=true);
    }
}

    //Cable Outlets for right Pocket or Left pocket
    if(rightPocket == 0) translate([-batDia/2+cableStrainInset, batDia + batDia/2 + addBatSpace + addBatSpace/2, batLength/2+posPoleLength-cableLength+.1]){
        translate([-5.2,0,0]) cableRelief(1);
        cableOutlet(0);
        //cylinder(cableLength, cableDia/2, cableDia/2, center=true);
    }

    if(rightPocket == 1) translate([-batDia/2+cableStrainInset, batDia + batDia/2 + addBatSpace + addBatSpace/2, -batLength/2-negPoleLength+cableLength-.1]) rotate([0,180,0]){
        translate([5.2,0,0]) cableRelief(1);
        cableOutlet(0);
        //cylinder(cableLength, cableDia/2, cableDia/2, center=true);
    }


/*
posPoleLength
negPoleLength
*/

//Electrode Mounts
intersection(){
    difference(){
        union(){
            poleElectrode(1,1,1,0);
            translate([0,batDia + addBatSpace,0]) poleElectrode(1,1,1,0);
            translate([0,batDia*2 + addBatSpace*2,0]) poleElectrode(1,1,1,0);
            translate([-batDia + addBatSpace/2,batDia/2 + addBatSpace/2,0]) rotate([0,0,-120]) poleElectrode(1,1,1,0);
        }
    //2S2P Pole Interconnections
    translate([7,10,-42+.6]) cube([5,10,.6+1.2], center=true);
    translate([7,10,35-.6]) cube([5,10,.6+1.2], center=true);
    }
    
    hulledBatteries();
}

}

