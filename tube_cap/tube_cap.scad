/*
AUTHOR: Samuel M.H. <samuel.mh@gmail.com>
DESCRIPTION:
  A cap for rectangular section tubes.
*/ 


//PARAMETERS

$fn = 30;
NZ = 0.0000000001;  //So operations are NEVER ZERO

// Tube
T_WIDTH = 30; //Outer dimension of the tube
T_LENGTH = 20; //Outer dimension of the tube
T_THICK = 1.55; // Section of the tube


// Lid
L_MARGIN = 1;  //How much bigger is the lid with respect to the tube
L_THICK = 2;  //Thickness of the lid
L_RADIUS = 2;  //Smoothered corners
L_BRAND_DEPTH = 0.5; //Depth of the brand engravement
L_BRAND = "SMH";  //Will require manual tweaking


// Supports
S_DIM = [4, 2 , 10]; //Width, Length, Height of a single support
S_ROT = 5; //How much the support is rotated to make friction



// CONSTANTS (calculated from parameters)
L_WIDTH = T_WIDTH+2*L_MARGIN;
L_LENGTH = T_LENGTH+2*L_MARGIN;


//MODULES

module lid(){
    translate([L_RADIUS, L_RADIUS, 0])
    difference(){
        minkowski(){
            cube([
                L_WIDTH-2*L_RADIUS+NZ,
                L_LENGTH-2*L_RADIUS+NZ,
                L_THICK-L_RADIUS+NZ
            ]);
            difference(){
                sphere(r=L_RADIUS);
                translate([-L_RADIUS, -L_RADIUS, -L_RADIUS*2])
                cube(L_RADIUS*2);
            }
        }
        translate([2,5,L_THICK-L_BRAND_DEPTH+NZ])
        linear_extrude(L_BRAND_DEPTH)
        text(L_BRAND, size=8);
    }
}

module support(){
    translate([S_DIM[1], 0, 0])
    rotate([S_ROT,0,0])
    cube(S_DIM);
    rotate([0,-S_ROT,0])
    translate([S_DIM[1], S_DIM[1],0])
    rotate([0,0,90])
    cube(S_DIM);
}



// Model

translate([0,0,L_THICK])
union(){
    //Lid
    translate([L_WIDTH,0,0])
    rotate([0,180,0])
    lid();
    //4 Corner supports
    translate([0,0,-T_THICK+NZ])
    union(){
        translate([L_MARGIN+T_THICK, L_MARGIN+T_THICK,0])
        support();
        translate([L_MARGIN+T_THICK, L_LENGTH-L_MARGIN-T_THICK,0])
        rotate([0,0,-90])
        support();
        translate([L_WIDTH-L_MARGIN-T_THICK, L_MARGIN+T_THICK,0])
        rotate([0,0,90])
        support();
        translate([L_WIDTH-L_MARGIN-T_THICK, L_LENGTH-L_MARGIN-T_THICK ,0])
        rotate([0,0,180])
        support();
    }
}
