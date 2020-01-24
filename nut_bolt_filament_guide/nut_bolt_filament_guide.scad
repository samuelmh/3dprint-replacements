use <smh_lib/construct/bolt.scad>

$fn = 80; //Resolution


// BOLT
translate([0,0,19+1])
rotate([180,0,0])
difference(){
    union(){
        translate([0,0,19-1]) cylinder(r=3,h=2);
        bolt(
            bolt_r=1.6, bolt_h=19,
            cutter_shape=CUTTER_V90(), depth=0.3, step=0.5, spins=11
        );
    }
    translate([0,0,19+1.5]) cube([20,.7,3], center=true);
}


// NUT
translate([10,0,0])
difference(){
    cylinder(r=3.5,h=3, $fn=6);
    translate([0,0,-0.1])
    bolt(
        bolt_r=1.8, bolt_h=4, // Note the tolerance 0.4 mm. It worked for me
        cutter_shape=CUTTER_V90(), depth=0.3, step=0.5, spins=8
    );
}
