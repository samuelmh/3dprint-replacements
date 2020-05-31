/*
AUTHOR: Samuel M.H. <samuel.mh@gmail.com>
DESCRIPTION:
  A hinge for the bar of a table tennis.
*/ 


THICKNESS = 3;
BAR_D = 19;
WIDTH = 16;
$fn = 120;

module half_profile(){  // 2D shape
    
    // Upper stopper
    translate([-6,21])
    square([12,7]);

    // Arc
    translate([0,11.5])
    difference(){
        circle (d=BAR_D+(2*THICKNESS));
        circle(d=BAR_D);
        translate([-20,-40])
        square([40,39.9]);
    }
    
    //L shape
    translate([BAR_D/2, 0]){
        square([3,11.5]);
        square([18,3]);
        translate([0.5,3.75])
        circle(d=2.5);
    }
}


module hole(){ // Bolt holes
    translate([0,0,WIDTH/2])
    rotate([90])
    translate([0,0,-THICKNESS+1])
    union(){
        cylinder(d=5, THICKNESS*2);
        translate([0, 0, -2])
        cylinder(d=7, 2);
    }
}


// Build the piece
difference(){ 
    linear_extrude(WIDTH){  // 3D piece

            union(){
                mirror([1,0])
                half_profile();
                half_profile();
            }
    }
    translate([(BAR_D+18)/2, 0, 0]) hole();
    translate([-(BAR_D+18)/2,0,0]) hole();
}

