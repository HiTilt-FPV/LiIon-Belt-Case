


//Global Variables
$fa = 3;
$fs = 1;

//Belt Clip
beltClipLength = 50;
beltClipWidth = 25;
beltClipStrength = 2;
beltClipEndAngle = 80;

//Connector Mechanism
clipConnectorMale = 1;
clipConnectorLength = 11.8;
clipConnectorHeight = 4;
clipConnectorTStr = 2;
clipConnectorInterlock = 3;
clipConnectorTol = .2;

//M3 Screw insert
m3InnerDia = 4.6;
m3OuterDia = m3InnerDia +4;
m3Height = 4;
m3Base = 0;
m3Offset = 3;

m3ScrewDia = 3;
m3Tol = .2;


//translate([-4.61,beltClipLength-31,0]) rotate([90,0,20]) cylinder(beltClipLength-30, beltClipStrength/2, beltClipStrength/2, center=false); 

module clipSide() union() rotate([0,0,2]){
    translate([30.85,10,0]) rotate([0,180,-10]) rotate_extrude(angle = -30,convexity = 10)
    translate([30, 0, 0])
    circle(.01);

    translate([0,-35/2-12,0])rotate([0,0,-30]){
        translate([-35,0,0]) rotate_extrude(angle = 50,convexity = 10)
        translate([35, 0, 0])
        circle(.01);

        translate([16,0,0]) rotate([0,180,0]) rotate_extrude(angle = -beltClipEndAngle,convexity = 10)
        translate([16, 0, 0])
        circle(.01);
    }
}

module fullClip() minkowski(){
    clipSide();
    cube([.1,.1,beltClipWidth-beltClipStrength/2], center=true);
}

module beltClip() minkowski(){
    intersection(){
        fullClip();
        union(){
            translate([0,-9,0]) cube([15, 48, beltClipWidth+beltClipStrength/2], center=true);
            translate([0,20.2-52,0]) rotate([0,90,0])cylinder(15, beltClipWidth/2+beltClipStrength/4, beltClipWidth/2+beltClipStrength/4, center=true);
        }
    }
    sphere(beltClipStrength/2);
}

/* Old "Double T" Clip Connector
module clipConnector(clipConnectorMale){
    if(clipConnectorMale==1){ //add tolerances!
        difference(){
            cube([4,clipConnectorLength,beltClipWidth], center=true);
            
            union(){
            translate([-clipConnectorTStr/2,0,beltClipWidth/4]) cube([clipConnectorHeight-clipConnectorTStr,clipConnectorLength,beltClipWidth/6+clipConnectorTol*2], center=true);
        translate([-clipConnectorTStr/2,0,-beltClipWidth/4]) cube([clipConnectorHeight-clipConnectorTStr,clipConnectorLength,beltClipWidth/6+clipConnectorTol*2], center=true);
        
        translate([clipConnectorTStr/2-clipConnectorTol,0,beltClipWidth/4]) cube([clipConnectorHeight-clipConnectorTStr+clipConnectorTol*2,clipConnectorLength,beltClipWidth/6+clipConnectorInterlock*2+clipConnectorTol*2], center=true);
        translate([clipConnectorTStr/2-clipConnectorTol,0,-beltClipWidth/4]) cube([clipConnectorHeight-clipConnectorTStr+clipConnectorTol*2,clipConnectorLength,beltClipWidth/6+clipConnectorInterlock*2+clipConnectorTol*2], center=true);
            }
        }
    }
    
    if(clipConnectorMale==0){ //add tolerances!
        translate([-clipConnectorTStr/2-clipConnectorTol/2,0,beltClipWidth/4]) cube([clipConnectorHeight-clipConnectorTStr+clipConnectorTol,clipConnectorLength-clipConnectorTol,beltClipWidth/6], center=true);
        translate([-clipConnectorTStr/2-clipConnectorTol/2,0,-beltClipWidth/4]) cube([clipConnectorHeight-clipConnectorTStr+clipConnectorTol,clipConnectorLength-clipConnectorTol,beltClipWidth/6], center=true);
        
        translate([clipConnectorTStr/2,0,beltClipWidth/4]) cube([clipConnectorHeight-clipConnectorTStr,clipConnectorLength-clipConnectorTol,beltClipWidth/6+clipConnectorInterlock*2-clipConnectorTol*2], center=true);
        translate([clipConnectorTStr/2,0,-beltClipWidth/4]) cube([clipConnectorHeight-clipConnectorTStr,clipConnectorLength-clipConnectorTol,beltClipWidth/6+clipConnectorInterlock*2-clipConnectorTol*2], center=true);
    }
}
*/

module clipConnector(clipConnectorMale){
    if(clipConnectorMale==1){ //add tolerances!
        difference(){
            cube([4,clipConnectorLength,beltClipWidth], center=true);
            
            union(){
                translate([-clipConnectorTStr/2-clipConnectorTol/2,0,0]) cube([clipConnectorHeight-clipConnectorTStr+clipConnectorTol+clipConnectorTol,clipConnectorLength-clipConnectorTol+clipConnectorTol*2,beltClipWidth-clipConnectorInterlock*4], center=true);

                translate([clipConnectorTStr/2,0,0]) cube([clipConnectorHeight-clipConnectorTStr+clipConnectorTol,clipConnectorLength-clipConnectorTol+clipConnectorTol*2,beltClipWidth-clipConnectorInterlock*2], center=true);
            }
        }
    }
    
    if(clipConnectorMale==0){ //add tolerances!
        translate([-clipConnectorTStr/2-clipConnectorTol/2+clipConnectorTol/2,0,0]) cube([clipConnectorHeight-clipConnectorTStr+clipConnectorTol+clipConnectorTol,clipConnectorLength-clipConnectorTol,beltClipWidth-clipConnectorInterlock*4-clipConnectorTol*2], center=true);

        translate([clipConnectorTStr/2,0,0]) cube([clipConnectorHeight-clipConnectorTStr-clipConnectorTol,clipConnectorLength-clipConnectorTol,beltClipWidth-clipConnectorInterlock*2-clipConnectorTol*2], center=true);
    }
}



module M3Terminal(m3Base){
    rotate([0,90,0]) translate([0,0,-clipConnectorTol-2]){
        if(m3Base == 1) difference(){
            cylinder(m3Height, m3OuterDia/2, m3OuterDia/2, center=true);
            cylinder(m3Height, m3InnerDia/2, m3InnerDia/2, center=true);
        }
        if(m3Base == 0) translate([0,0,m3Tol]){
            cylinder(m3Height+m3Tol*2, m3InnerDia/2, m3InnerDia/2, center=true);
            translate([0,0,m3Height]) cylinder(m3Height+m3Tol*2, m3ScrewDia/2+m3Tol/2, m3ScrewDia/2+m3Tol/2, center=true);
        }
    }
}

//MAIN

/*
fullClip();

union(){
    translate([0,-9,0]) cube([15, 48, beltClipWidth+beltClipStrength/2], center=true);
    translate([0,20.2-52,0]) rotate([0,90,0])cylinder(15, beltClipWidth/2+beltClipStrength/4, beltClipWidth/2+beltClipStrength/4, center=true);
}
*/

color("green") clipConnector(1);
//color("cyan") clipConnector(0);

%M3Terminal(1);
%M3Terminal(0);


//translate([clipConnectorTStr/2-1.7,9.5,0])
//belt Clip
difference(){
    translate([1.5,-9.8,0]) rotate([0,0,-1]) beltClip();
    
    translate([clipConnectorTStr/2,-clipConnectorTol*2,0]) cube([clipConnectorHeight-clipConnectorTStr+clipConnectorTol,clipConnectorLength-clipConnectorTol+clipConnectorTol*6,beltClipWidth-clipConnectorInterlock*2], center=true);

    M3Terminal(0);
}