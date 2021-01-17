//Battery Cover Clamp

//to use this, call:
//clampMechanism(); //Add
//clampMechanismCutout(); //use with difference()
//clampCutout(); //use with difference()


//Global Variables
$fa = 2;
$fs = .2;

//variables
clampWidth = 20;
clampDepth = 10;
clampThickness = 1;
clampTolerance = .5;



//MODULES

module clampMechanism(){
    translate([2.5,-1,0])cube([clampThickness, clampDepth, clampWidth/2-1.9], center=true);
    
    translate([1.8,0,0])minkowski(){
            difference(){
            translate([.85,0,0]) rotate([0,0,-30]) cube([1.5,3,8], center=true);
            cube([1.5,5,8], center=true);
            translate([.5,2.3,0]) rotate([0,0,70]) cube([1.5,5,8], center=true);
        }
        cylinder(.1,.5,.5, center=true);
    }
    
    hull(){
        translate([2.5,-4.5,4]) cube([clampThickness, 3 , .1], center=true);
        translate([2,-4.5,6]) rotate([0,0,15]) cube([clampThickness, 3 , .1], center=true);
    }
    
    hull(){
        translate([2.5,-4.5,-4]) cube([clampThickness, 3 , .1], center=true);
        translate([2,-4.5,-6]) rotate([0,0,15]) cube([clampThickness, 3 , .1], center=true);
    }
    
    translate([.97,-.64,7.5]) rotate([0,0,15]) cube([clampThickness, clampDepth+1, 3], center=true);
    translate([.97,-.64,-7.5]) rotate([0,0,15]) cube([clampThickness, clampDepth+1, 3], center=true);
    
    translate([2.13,5.3,0]) rotate([0,0,15]) cube([clampThickness, 3, clampWidth/2-1.9], center=true);
}


module clampCutout(){
    translate([1.3,-2,0]) cube([4, clampDepth, clampWidth+clampTolerance*2], center=true);
    
        translate([1.8+.1,0,0]) minkowski(){
            difference(){
            translate([.85,0,0]) rotate([0,0,-30]) cube([1.5,3,8], center=true);
            cube([1.5,5,8], center=true);
            translate([.5,2.3,0]) rotate([0,0,70]) cube([1.5,5,8], center=true);
        }
        //cylinder(.1,.8,.8, center=true);
        sphere(.8);
    }

}


module clampMechanismCutout(){
    translate([1.6,5,0]) rotate([0,0,15]) cube([clampThickness+3, 6, clampWidth/2], center=true);
}


//clampMechanism();

//clampMechanismCutout();

//clampCutout();