/*
AUTHOR: Samuel M.H. <samuel.mh@gmail.com>
DESCRIPTION:
  This is a basic support for the electric motor I got from an old cassette player.
*/ 

BOLT_D=5.2;  //Bolt diameter
BOLT_SEP=13;  //Bolt separation
BOLT_RAIL=4;  //Bolt rail for installing the rubber dampers 
MOTOR_D=11;  //Motor (rotor) diameter
SUPPORT_SIZE=[40,40]; //Perimeter for the support
SUPPORT_DEPTH=3.24;  //Depth of the support

$fn=40;

linear_extrude(height=SUPPORT_DEPTH)
difference(){
    square(SUPPORT_SIZE, center=true);
    union(){
        circle(d=MOTOR_D);
        translate([-BOLT_SEP,0,0]) circle(d=BOLT_D);
        translate([BOLT_SEP,0,0]) circle(d=BOLT_D);
        square([2*BOLT_SEP, BOLT_RAIL], center=true);
    }
}
