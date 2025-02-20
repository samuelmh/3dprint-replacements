/*
AUTHOR: Samuel M.H. <samuel.mh@gmail.com>
DESCRIPTION:
  A holder for the magnet of a cupboard door.
*/ 


$fn = 120;
CLEARANCE = 0.35;

//BOX
WIDTH = 44.76;
HEIGHT = 14.1;
DEPTH = 11.42;

//BOX - OTHER
THICKNESS = 2.5;
ROD_D = 3.8;

//HOLE - MAGNET
M_WIDTH = 25.75;


//HOLE - BOLT
BOLT_D = 3.4; //Diameter for the bolt hole
BOLT_SEP = 34; //separation between bolts, measured from the closests borders, not center. Easy for caliper measurement.

//LID  
L_HEIGHT = THICKNESS;
L_WIDTH = BOLT_SEP-THICKNESS;

    


//lid
module lid_tabs(clearance){
    translate([0,0,-THICKNESS/4])
    difference(){
        cube([L_WIDTH-clearance, DEPTH-THICKNESS-clearance, L_HEIGHT/2], center=true);
        //Holes of for the small tabs
        translate([(-M_WIDTH-(L_WIDTH-M_WIDTH)/4)/2, (DEPTH-THICKNESS)*0.75, 0])
        cube([(L_WIDTH-M_WIDTH)/4+clearance,DEPTH-THICKNESS+clearance, L_HEIGHT ],center=true);
        translate([(M_WIDTH+(L_WIDTH-M_WIDTH)/4)/2, (DEPTH-THICKNESS)*0.75, 0])
        cube([(L_WIDTH-M_WIDTH)/4+clearance,DEPTH-THICKNESS+clearance, L_HEIGHT ],center=true);
    }
}


module lid(){
    translate([0, 0, -(HEIGHT-L_HEIGHT)/2])
    difference(){   
        union(){
        cube([M_WIDTH-CLEARANCE, DEPTH, L_HEIGHT], center=true);   
        lid_tabs(CLEARANCE);
        // Vertical rod
        translate([0, 0, (HEIGHT-L_HEIGHT)/2])  
        cylinder(HEIGHT,ROD_D/2,ROD_D/2, center=true);           
        }
    }
}
    
  




//main piece
module box(){
    difference(){    

            // BOX
            cube([WIDTH, DEPTH, HEIGHT], center=true);
            
            // HOLE - Magnet
            translate([0,0,-THICKNESS])
            cube([M_WIDTH, DEPTH*2, HEIGHT], center=true);
            
            // HOLE - Sides (substraction) x2
            translate([
                WIDTH-((WIDTH-M_WIDTH)/2)+THICKNESS,
                -THICKNESS,
                THICKNESS
            ]) cube([WIDTH, DEPTH, HEIGHT], center=true);
            translate([
                -WIDTH+((WIDTH-M_WIDTH)/2)-+THICKNESS,
                -THICKNESS,
                THICKNESS
            ]) cube([WIDTH, DEPTH, HEIGHT], center=true);
            
            // HOLE - Bolts x4
            translate([(BOLT_SEP+BOLT_D)/2, -THICKNESS/2, 0])
                cylinder(HEIGHT*2,BOLT_D/2,BOLT_D/2, center=true);
            translate([-(BOLT_SEP+BOLT_D)/2, -THICKNESS/2, 0])
                cylinder(HEIGHT*2,BOLT_D/2,BOLT_D/2, center=true);
            translate([(BOLT_SEP+BOLT_D)/2, 0, THICKNESS/2])  
            rotate([90, 0, 0])
                cylinder(DEPTH*2,BOLT_D/2,BOLT_D/2, center=true);
            translate([-(BOLT_SEP+BOLT_D)/2, 0, THICKNESS/2])  
            rotate([90, 0, 0])
                cylinder(DEPTH*2,BOLT_D/2,BOLT_D/2, center=true);
                
            // HOLE - Lid tabs
            translate([0, 0, -(HEIGHT-L_HEIGHT)/2+CLEARANCE])
            lid_tabs(clearance=0);
            translate([0,0, -(HEIGHT-L_HEIGHT*0.5)/2]) lid_tabs(clearance=0);
            
            // HOLE - Vertical Rod
            l_rod_d = BOLT_D+(CLEARANCE*2);
            cylinder(HEIGHT*2,l_rod_d/2,l_rod_d/2, center=true);
            
          

        
    }
}



//
// VIEWS
//

module view_assembled(){
    // Final view
    box();
    lid();
}


module view_final(){
    // Ready to print
    translate([0,0,DEPTH/2]){
        rotate([-90,0,0])
        box();
        translate([0, -HEIGHT, THICKNESS/2])
        lid();
    }
}



//view_assembled();
view_final();
