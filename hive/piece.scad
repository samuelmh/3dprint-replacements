/*
AUTHOR: Samuel M.H. <samuel.mh@gmail.com>
DESCRIPTION:
  Base piece for Hive Game.
*/

/* Piece specifications

Standard piece
    Apothem: 38mm /2
    Height: 12mm
    
Pocket piece
    Apothem: 25mm /2
    Height: 10mm
    
NOTE: the apothem is half the width of the piece.
*/


// CONSTANTS
MARGIN = 0.1;
sides = 6;
$fn=100;



// USER_DEFINED PARAMETERS
IMG_PATH = "themes/epsmith/img/queen_bee_1.png";
IMG_SIZE = 286;
PIECE_ROTATION = 1;
// Not so important ;)
WIDTH = 38;
HEIGHT = 12;
ENGRAVEMENT = 1.5;  //Depth of the engravement


// FUNCTIONS
function apothem2radius(apothem, sides) = apothem/cos(360/(sides*2));


module BasePiece(radius, height, smooth=1.5){
    /*
    smooth: radius for the minkowsky
    */
    sides = 6;
    difference(){
        translate([0,0,smooth])
        minkowski(){
            cylinder(
                h = height-(smooth*2),
                r = radius-smooth,
                center = false,
                $fn=sides
            );
            sphere(r=smooth);
        }
        //Brand
        font_size=(radius*2)/4;
        mirror([1,0,0])
        translate([-3*font_size/2,-font_size/2, -MARGIN])
        linear_extrude((ENGRAVEMENT/2)+MARGIN)
        text("SMH", size=font_size);
    }
}


module Piece(apothem, height, img, img_size, piece_rotation=0, smooth=1.5){
    radius = apothem2radius(apothem, sides);
    rotation = (piece_rotation==1) ? 360/(sides*2) : 0;
    margin = smooth;
    
    // Build the piece
    difference(){
        rotate([0, 0, rotation])
        BasePiece(radius, height);
        //IMG
        intersection(){
            //Margin on the border
            rotate([0, 0, rotation])
            cylinder(
                h = height*2,
                r = radius-margin,
                center = false,
                $fn=sides
            );
            scale_factor = ((apothem-margin)*2)/img_size;
            translate([-apothem+margin, -apothem+margin, height+MARGIN-ENGRAVEMENT])
            scale([scale_factor, scale_factor, -(ENGRAVEMENT+MARGIN)/100])  // png depth values are scaled 0-100
            surface(file=img, center = false, invert = true);
        }
    }
}


Piece(WIDTH/2, HEIGHT, IMG_PATH, IMG_SIZE, PIECE_ROTATION);
