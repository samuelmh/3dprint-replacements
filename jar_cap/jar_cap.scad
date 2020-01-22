$fn=100;

difference(){
    union(){
        //base
        cylinder(d1=28, d2=31.5, h=7);
        //top
        translate([0,0,6.9])cylinder(d1=40, d2=40, h=3.1);
    }// Engrave a name
    translate([-35/2, -12/2+2, 10-1])
    resize(newsize=[35,12,2])
    linear_extrude(height=2) import ("asun.dxf");
}