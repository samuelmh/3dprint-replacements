// AUTHOR: Samuel M.H. <samuel.mh@gmail.com>
// VERSION: 2020-JAN-02
// DESCRIPTION: wardrobe door stopper.

difference(){
    cylinder(h=7.5, d1=17, d2=14, $fn=40); //Base cone
    union(){  // Hole for the bolt
        translate([0,0,7.5-2.6+0.1]) cylinder(h=2.6, d1=2.5, d2=5.5, $fn=40);
        translate([0,0,-0.1]) cylinder(h=7.8,d=2.5, $fn=40);
    } //Flat cut to stop the door
    translate([0,-17-4.5,0]) cube(17*2, center=true);
}