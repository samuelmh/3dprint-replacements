// Get the lib from: https://github.com/samuelmh/3dprint-lib_pocs
use <smh_lib/construct/bolt.scad>


$fn=80;

// Base piece
WIDTH = 30;
LENGTH = 70;
HEIGHT = 5;


//Hole right
HR_R = 4;
HR_X = 12.3;
HR_RECT_H = 3; // Rectangle height
HR_RECT_W = 1.4; // Rectangle width

// Hole left
HL_R = 4.5;
HL_X = -13;

// Central nut
NUT_H = 6.5;
NUT_EXTERNAL_R = 6.9;


// Bolt
BOLT_R = 4.5;
BOLT_H = 25;
BOLT_HEAD_R = 8;
BOLT_HEAD_H = 3;





module base_piece(){    
    linear_extrude(height=HEIGHT)
    difference(){
        intersection(){  // Base shape is like a truncated circle
            circle(d=LENGTH);
            square([LENGTH, WIDTH], center=true);
        }
        // Hole right
        translate([HR_X,0,0]) union(){
            circle(r=HR_R);
            translate([-HR_RECT_W-HR_R, -HR_RECT_H/2])
            square([HR_R, HR_RECT_H]);
        }
        // Hole left        
        translate([HL_X,0,0])circle(r=HL_R);
        // Hole nut
        circle(r=NUT_EXTERNAL_R-0.1);
    }
}


module arrow(){
    translate([-(LENGTH/2)+6,0,HEIGHT])
    union(){
        rotate([0,0,180])
        cylinder(d=5,h=2,$fn=3, center=true);
        translate([(8/2),0,0]) 
        cube([8,2,2], center=true);
    }
    
}


module branding(){
    translate([30,-11,HEIGHT-.5])
    rotate([0,0,90])
    resize(newsize=[WIDTH*0.75, WIDTH*0.75/3, 1])
    linear_extrude(height=2) import ("smh.dxf");
}



// BOLT
module my_bolt(){
    translate([0,WIDTH,BOLT_H])
    rotate([180,0,0])
    difference(){
    union(){
        translate([0,0,BOLT_H-3]) cylinder(r=BOLT_HEAD_R,h=BOLT_HEAD_H);
        bolt(
            bolt_r=BOLT_R, bolt_h=BOLT_H-1,
            cutter_shape=CUTTER_V90(), depth=1.1, step=2, spins=11
        );
    }
    // Cut in the head
    translate([0,0,BOLT_H])
    cube([20,1.5,3], center=true);
}
}


module my_nut(){
    difference(){
        cylinder(r=NUT_EXTERNAL_R,h=NUT_H);
        translate([0,0,-1])
        bolt(
            bolt_r=BOLT_R+0.4, bolt_h=2*HEIGHT,
            cutter_shape=CUTTER_V90(), depth=1.1, step=2, spins=7
        );
    }
}




difference(){
    union(){
        base_piece();
        arrow();
        my_nut();
    }
    branding();
}

my_bolt();
