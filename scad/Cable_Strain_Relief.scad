
//Global Variables
$fa = 3;
$fs = .5;

//Cable Strain
rightPocket = 1;
cableDia = 4.5;
cableLength = 10;

curveRad = 10;
curveAngle = 80;

//Cable Relief

    //M3 Screw insert
m3InnerDia = 4.6;
m3OuterDia = m3InnerDia +4;
m3Height = 4;

m3Base = 0;

m3Offset = 3;

//cable Outlet
cableOutletDia = 12;
cableOutletDiff = 0;
cableOutletCutoff = 2;

module cableStrain(){
    cylinder(cableLength, cableDia/2, cableDia/2, center=false);

    translate([-curveRad,0,0]) rotate([-90,0,0]){
        rotate_extrude(angle = curveAngle, convexity = 10)
        translate([curveRad, 0, 0]) circle(cableDia/2);
    }
}

module cableRelief(m3Base){
    
    translate([0,0,m3InnerDia/2+m3Offset]) rotate([0,90,0]){
        if(m3Base == 1) difference(){
            hull(){
                cylinder(m3Height, m3OuterDia/2, m3OuterDia/2, center=true);
                translate([-m3OuterDia/2,0,0]) cube([1, m3OuterDia, m3Height], center=true);
            }
            cylinder(m3Height, m3InnerDia/2, m3InnerDia/2, center=true);
        }
        if(m3Base == 0) cylinder(m3Height*2, m3InnerDia/2, m3InnerDia/2, center=true);
    }
}

module cableOutlet(cableOutletDiff) translate([0,0,cableLength]) {
    
    if(cableOutletDiff == 0) rotate_extrude(convexity = 10)
    translate([cableOutletDia/2+cableDia/2,0,0]) difference(){
        circle(cableOutletDia/2);
        translate([cableOutletDia/2-cableOutletCutoff,0]) square(cableOutletDia, center=true);
        translate([0,-cableOutletDia/2]) square(cableOutletDia, center=true);
    }
    
    if(cableOutletDiff == 1) difference(){
        cylinder(cableOutletDia/2,cableOutletDia/2+cableDia/2-cableOutletCutoff, cableOutletDia/2+cableDia/2-cableOutletCutoff, center=false);
        rotate_extrude(convexity = 10)
        translate([cableOutletDia/2+cableDia/2,0,0]) difference(){
            circle(cableOutletDia/2);
            translate([cableOutletDia/2-cableOutletCutoff,0]) square(cableOutletDia, center=true);
            translate([0,-cableOutletDia/2]) square(cableOutletDia, center=true);
        }
    }
}


//surface Cube
//translate([-5+cableDia/2,0,-15+cableLength]) cube([10,10,30], center=true);

cableStrain();

cableRelief(1);
cableOutlet(1);
