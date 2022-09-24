/*
AUTHOR: Samuel M.H. <samuel.mh@gmail.com>
DESCRIPTION:
  Ring for a car door lock mechanism.
  Tested on a Volvo S60.
  
  Measurements in mm.
*/ 


$fn=200;

//Basic polygon shape
 POINTS = [
 [0,0],
 [1,0],
 [2,0.5],
 [1,1],
 [2,1.5],
 [1,2],
 [2,2.5],
 [1,3],
 [2,3.5],
 [1,4],
 [1,5],
 [4,5],
 [4,6],
 [3,6],
 [3,7],
 [0,7]
];

//Curved border
BORDER_R = 1;
BORDER_POS = [3,6];

//Inner hole
PIN_R = 5.5;


//Actual piece
rotate_extrude()
translate([PIN_R,0]){
    union(){  //Profile
        polygon(POINTS);
        translate(BORDER_POS){
            circle(r = BORDER_R);
        }
    }
}