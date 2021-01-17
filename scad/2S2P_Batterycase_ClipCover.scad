//use the followoing modules to import Battery and Electronics Covers/Lids:
//batteriesCover();
//electronicsCover();


//Other OpenSCAD Products
use <Battery_Inlay.scad>
use <Belt_Clip.scad>

//Global Variables
$fa = 3;
$fs = 1;



//Battery Meas
batDia = 18.6; //add tolerances!
addBatSpace = 1.5;
addOutsideBatSpace = 1.5;
batLength = 65; //add tolerances!

smoothEdges = 2;

//Electronic Components Meas:
electronicsAngle = 31.5;
ledHTransOnCover = 4.4;
buttonHTransOnCover = 3;

    //Button
buttonDia = 9; 
zButtPos = 22;

    //Taster
tasterDia = 12.5;
tasterHeight = 3.8;
tasterElectrodes = 7;
tasterInset = 1; 
tasterCase = 1;

tasterOffset = 3.8;
tasterClipAngle = 40;

    //LED Voltage Indicator
ledWidth = 31.6;
ledHeight = 20.2;
ledDepth = 5.5;
zLedPos = -11;

ledPcbWidth = 44;
ledPcbHeight = 7;
ledPcbDepth = 8;
ledPcbStr = 1.4;

ledClipOffset = 18.8;
ledClipAngle = 45;


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

module batteriesCover() difference(){
    difference(){
        minkowski(){
            hulledBatteries();
            cylinder(.001, smoothEdges, smoothEdges, center=true);
        }
        minkowski(){
            hulledBatteries();
            cylinder(.1, .1, .1, center=true);
        }
    }
    
    union(){
        translate([-14.5,38,-2]) rotate([0,0,28]) cube([30,40,100], center=true);
        translate([-27,20,-2]) rotate([0,0,-30]) cube([10,10,100], center=true);
    }
}

module electronicsCover() intersection(){
    difference(){
        minkowski(){
            hulledBatteries();
            cylinder(.001, smoothEdges, smoothEdges, center=true);
        }
        minkowski(){
            hulledBatteries();
            cylinder(.1, .1, .1, center=true);
        }
    }
    
    union(){
        translate([-15,38,-2]) rotate([0,0,28]) cube([30,40,100], center=true);
        translate([-26,20,-2]) rotate([0,0,-30]) cube([10,10,100], center=true);
    }
}

module tasterBay() translate([-21,27,0]) rotate([electronicsAngle,90,0]) translate([zButtPos,buttonHTransOnCover,0]){
    
        translate([0, 0, tasterHeight/2+smoothEdges/2-.2+tasterInset]) difference(){
            translate([0,0,-tasterInset/2]) cube([tasterDia+tasterCase*2, tasterDia+tasterCase*2, tasterHeight+tasterInset], center=true);
            cube([tasterDia, tasterDia, tasterHeight], center=true);
            
            translate([0,0,-tasterInset/2]) cylinder(tasterHeight+tasterInset, buttonDia/2+tasterCase, buttonDia/2+tasterCase, center=true);
            
            cube([tasterDia+tasterCase*2, tasterElectrodes, tasterHeight], center=true);
            cube([tasterDia, tasterDia+tasterCase*2, tasterHeight], center=true);
    }
    
    difference(){
        translate([0, 0, tasterHeight/2+smoothEdges/2-.2+tasterInset+tasterCase/2]) cube([tasterDia/2, tasterDia+tasterCase*2, tasterHeight+tasterCase], center=true);
        
        translate([0, 0, tasterHeight/2+smoothEdges/2-.2+tasterInset]) cube([tasterDia/2, tasterDia, tasterHeight], center=true);
        
        translate([0, 0, tasterHeight/2+smoothEdges/2-.2+tasterInset+tasterCase/2]) cube([tasterDia/2, tasterDia-tasterCase*2, tasterHeight+tasterCase], center=true);
        
        translate([0, tasterOffset, tasterHeight/2+smoothEdges/2-.2+tasterInset+tasterHeight]) rotate([tasterClipAngle,0,0]) cube([tasterDia/2, tasterDia-tasterCase*2, tasterHeight+tasterCase], center=true);
        
        translate([0, -tasterOffset, tasterHeight/2+smoothEdges/2-.2+tasterInset+tasterHeight]) rotate([-tasterClipAngle,0,0]) cube([tasterDia/2, tasterDia-tasterCase*2, tasterHeight+tasterCase], center=true);
    }
}

module ledBay(){
        translate([-21,27,0]) rotate([electronicsAngle,90,0]) translate([zLedPos,ledHTransOnCover,ledDepth/2-.4-smoothEdges/2]) difference(){
        translate([0,0,addOutsideBatSpace-.4]) cube([ledWidth+addOutsideBatSpace*2, ledHeight, ledDepth-smoothEdges], center=true);
            
        translate([0,0,addOutsideBatSpace-.4]) cube([ledWidth, ledHeight, ledDepth-smoothEdges], center=true); 
        }
    
        
    translate([-21,27,0]) rotate([electronicsAngle,90,0]) translate([zLedPos,ledHTransOnCover,ledDepth/2-.4-smoothEdges/2+.9]) difference(){
        translate([0,0,addOutsideBatSpace-.4]) cube([ledPcbWidth+ledPcbStr*2, ledPcbHeight, ledPcbDepth+ledPcbStr-smoothEdges], center=true);
        
        translate([0,0,addOutsideBatSpace-.4-ledPcbStr/2]) cube([ledPcbWidth, ledPcbHeight, ledPcbDepth-smoothEdges], center=true);
        
        translate([0,0,addOutsideBatSpace-.4]) cube([ledPcbWidth-ledPcbStr*2, ledPcbHeight, ledPcbDepth+ledPcbStr-smoothEdges], center=true);
        
        translate([-ledClipOffset,0,addOutsideBatSpace-.4+ledPcbHeight-ledPcbStr]) rotate([0,ledClipAngle,0]) cube([ledPcbWidth/4, ledPcbHeight, ledPcbDepth+ledPcbStr-smoothEdges], center=true);
        
        translate([ledClipOffset,0,addOutsideBatSpace-.4+ledPcbHeight-ledPcbStr]) rotate([0,-ledClipAngle,0]) cube([ledPcbWidth/4, ledPcbHeight, ledPcbDepth+ledPcbStr-smoothEdges], center=true);
    }
}

module coverWithElectronics() difference(){
    electronicsCover();
    translate([-21,27,0]) rotate([electronicsAngle,90,0]) {
        translate([zLedPos,ledHTransOnCover,0]) cube([ledWidth, ledHeight, ledDepth], center=true);
        translate([zButtPos,buttonHTransOnCover,0]) cylinder(3, buttonDia/2, buttonDia/2, center=true);
    }
}

module printedButton(){
   translate([0,0,tasterInset+smoothEdges/2-buttonTol+smoothEdges/8]) intersection(){
       cylinder(smoothEdges+smoothEdges/4, buttonDia/2-buttonTol/2, buttonDia/2-buttonTol/2, center=true);
       translate([0,0,-buttonCurveDia+smoothEdges/8*5])sphere(buttonCurveDia);
   }
   translate([0,0,tasterInset/2-buttonTol/2]) cylinder(tasterInset-buttonTol, buttonDia/2-buttonTol+tasterCase, buttonDia/2-buttonTol+tasterCase, center=true);
} 


/*MAIN
Uncomment the stuff you want to render and print.
*/

//color("cyan") import("2S2P_Batterycase.stl");

%intersection(){
    union(){
        %difference(){
        batteriesCover();
            //Only uncomment ONE of those if you want to use the belt clip!
            //translate([13.5,20.1,-3.5-32]) rotate([90,0,0]) M3Terminal(0); //Normal RIGHT SIDE Belt Clip Mount
            //translate([13.5,20.1,-3.5+32]) rotate([90,0,0]) M3Terminal(0); //Normal LEFT SIDE Belt Clip Mount
            translate([13.5,36.8,-3.5]) M3Terminal(0); //90 Deg turned Belt Clip Mount
        }
    //electronicsCover();

    coverWithElectronics();
    ledBay();
    tasterBay();
    }

translate([-9,20,-3.5]) cube([45,70,77.0], center=true); //this is needed for Z-Axis tolerances!
} //the 3.5 on Z-Axis actually is half of "Neg. Battery Pole" - "Pos. Battery Pole" from Battery_Inlay.scad


//Normal RIGHT SIDE Belt Clip Mount
%translate([13.5,20.1,-3.5-32]) rotate([90,0,0]) difference(){ //The 20.1 on Y Axis is the sum of "batDia + addBatSpace"
    %color("green") clipConnector(1);
    color("cyan") clipConnector(0);
    
    %M3Terminal(1);
    M3Terminal(0);
}

//Normal LEFT SIDE Belt Clip Mount
%translate([13.5,20.1,-3.5+32]) rotate([90,0,0]) difference(){ //The 20.1 on Y Axis is the sum of "batDia + addBatSpace"
    %color("green") clipConnector(1);
    color("cyan") clipConnector(0);
    
    %M3Terminal(1);
    M3Terminal(0);
}

//90 Deg turned Belt Clip Mount
%translate([13.5,36.8,-3.5]) difference(){ //the 3.5 on Z-Axis actually is half of "Neg. Battery Pole" - "Pos. Battery Pole" from Battery_Inlay.scad
    %color("green") clipConnector(1);
    color("cyan") clipConnector(0);
    
    %M3Terminal(1);
    M3Terminal(0);
}

//Printed Button
buttonTol = .6;
buttonCurveDia = 8;

//printedButton();
