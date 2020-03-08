/*
AUTHOR: Samuel M.H. <samuel.mh@gmail.com>
DESCRIPTION:
  A short knob.
*/ 

PIVOT_H = 11;
PIVOT_V_CUT = 6.7;
PIVOT_R = 5.9/2;


KNOB_R = 32/2;
KNOB_H = PIVOT_H-4;


THICKNESS = 2;

$fn=40;


module brand(){
    translate([-9,3,-0.1])
    linear_extrude(0.6)
    mirror([0,1,0])
    text("SMH", size=6);
}


module knob(){
    difference(){
        hull(){
            cylinder(r=KNOB_R, h=KNOB_H, $fn=8); 
            translate([25,-1,])
            cube([1,2,KNOB_H]);
            }
         translate([0,0,THICKNESS])
            cylinder(r=KNOB_R-THICKNESS, h=KNOB_H, $fn=8);
        }    
}


module pivot(){
    difference(){
        cylinder(r=PIVOT_R+THICKNESS, h=PIVOT_H);
        translate([0,0,1.5])
        difference(){  // Half circle cut
            cylinder(r=PIVOT_R, h=PIVOT_H+2);
            translate([-10,1,-0.1])
            cube([20,20,PIVOT_V_CUT],center=false);
        }       
        translate([-10,-1,PIVOT_V_CUT-1])
        cube([20,2,30]);
        
        translate([0,0,15+THICKNESS])
        cube([1, PIVOT_R*2+2,30], center=true);
    }
}





// PIECE
difference(){
    union(){
        knob();
        pivot();
    }
    brand();
}