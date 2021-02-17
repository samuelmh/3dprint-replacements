/*
AUTHOR: Samuel M.H. <samuel.mh@gmail.com>
DESCRIPTION:
  A button for a WC.
*/ 


$fn=80;

//
//// PARAMS
//

HOLE_D = 35; //Hole diameter where the buttons should fit
MARGIN = 2;  //Width of the plastic section

ROD_D = 6;
ROD_H = 95; //From the WC button to the bottom of this button
ROD_POS = [
    (HOLE_D/2)-(ROD_D/2)-MARGIN,
    (HOLE_D/2),
    0
];


BUTTON_MINK = 5; // Will use minkowski
BUTTON = [
    HOLE_D-10-(2*BUTTON_MINK),
    HOLE_D-(2*BUTTON_MINK),
    0.001
];
BUTTON_POS = [0,0,ROD_H+0.001];


R_H = 25;


//
//// MODULES
//
module rod(){
    translate(ROD_POS)
    cylinder(h=ROD_H+MARGIN, d=ROD_D);
}



module button(){
    translate(BUTTON_POS) //Final position
    translate([BUTTON_MINK, BUTTON_MINK, BUTTON_MINK]) // Correct coordinates after minkowski
    difference(){
        minkowski(){
            cube(BUTTON, center=false);
            sphere(BUTTON_MINK);
        }
        translate([BUTTON[0]/2, BUTTON[1]/2.5, BUTTON_MINK-1]) //Depth of the mark
        linear_extrude(BUTTON_MINK){
            text("+", valign="center", halign="center", size=HOLE_D);
        }
    }
}


module reinforcement(){
    translate([
        0,
        HOLE_D/2,
        BUTTON_POS[2] - R_H + (BUTTON_MINK)
    ])
    difference(){
        cylinder(h=R_H, d=HOLE_D);
        translate([0,0,0])
        translate([-HOLE_D*2,-HOLE_D, -HOLE_D])
        cube(HOLE_D*2);
    }
}

//
//// PIECE
//
union(){
    rod();  
    button();
    reinforcement();
}


//
//// Checks
//

////Top movement
//translate([0,0,84])
//#cube([40,40,10]);
//
////Lower movement
//translate([0,0,64])
//#cube([40,40,10]);
