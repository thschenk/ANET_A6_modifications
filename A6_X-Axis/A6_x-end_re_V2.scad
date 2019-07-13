// Anet A6 X-End
//
// GNU GPL v3
// R.E. 2017.06

use <pushfit_hole_re.scad>
use <polyhole_re.scad>
use <wing.scad>


module rod_hole(){
  union(){
    translate([0,0,8.5])
      polyhole(64-8.5+1+5, 4, center = false);
    translate([0,0,-1])
      cylinder(10.5, r=1.6, center=false, $fn=30);  
    translate([0,0,8.5])
      cylinder(4, r=5.5, center=false, $fn=30);
    translate([0,0,12.5])
      cylinder(2.5, 5.5, 4, center=false, $fn=30);
  }
}

module rod_screw(){
//rod screw nuts
  translate([0,-10+3.3,1.6+4])
    rotate([90,0,0])
      cube([5.8,3.2,20],center=true);
  translate([0,0,1.6+4])
    rotate([90,0,0])
      cylinder(30,r=.9, $fn=30, center=true);
}


// Bearing LMH8LUU (A6 default)
module bearing_LMH8(thickness=15){
    flange_height=5;
    shaft_height = 45;
    
    difference() {
      union() {
          
          // flange
          translate([0,0,flange_height/2]) intersection() {
            cube([32,20,flange_height], center=true);
            cylinder(flange_height,r=32/2, center=true, $fn=30);
          }
          
          // shaft
          translate([0,0, -shaft_height]) cylinder(shaft_height, d=15+.1, center=false);
      }
      
          //screwholes
          translate([12,0,flange_height-0.5])
            cylinder(2, d=5, center=false, $fn=15);
          
          translate([-12,0,flange_height-0.5]) 
            cylinder(2, d=5, center=false, $fn=15);
       
          translate([0,0,-50]) cylinder(60, d=8,  $fn=15);
      }
      

      
    // screws
    for (i=[0:1])
      rotate([0,0,90+i*180]){
        translate([0,12,-20])
          cylinder(20, r=1.6, center = false, $fn=15); // all the way through
        translate([0,12,-thickness-3]) // hex nut
          cylinder(3, r=5.8/2/cos(30), center=false, $fn=6);
      }
    
}

module bearing_LMH8_hole(thickness=15, rotation=0){
  flange_height=5;
  shaft_height=45;
  
  nut_hole_height = 40;
  d = 0.5;  
    
  rotate([0,0,rotation]) union(){
    // flange
    translate([0,0,flange_height/2])
      intersection() {
        cube([32,20+0.5, flange_height], center=true);
        cylinder(flange_height, d=32+0.5, center=true, $fn=30);
      }
    // shaft
    translate([0,0,-shaft_height])
      rotate([0,0,-rotation]) 
        pushfit_hole(shaft_height+d,15+.1,60,0.3);
      
    // screws
    for (i=[0:1])
      rotate([0,0,90+i*180]){
        translate([0,12,-shaft_height])
          rotate([0,0,-rotation]) polyhole(shaft_height+d, 1.6, center = false); // all the way through
        //translate([0,12,thickness]) // hex nut
        //  cylinder(40-thickness, r=5.8/2/cos(30), center=false, $fn=6);
        translate([0,12,-(thickness+nut_hole_height)])
          rotate([0,0,-rotation]) cylinder(nut_hole_height, r=7/2, center=false, $fn=6);
      }
    }
}



module lead_screw_nut(thickness){
  bolt_length=20;
  height=14;
  
  union(){
    
    cylinder(4, d=22, center=false, $fn=30);
      
    translate([0,0,-height])
      cylinder(height,d=10.2);
      
    
    for (i=[0:3])
      rotate([0,0,45+i*90]){
        translate([0,8,4])
          cylinder(4, d=5,  center=false, $fn=15);
          
        translate([0,8,-bolt_length])
          cylinder(bolt_length, r=1.6, center = false, $fn=15);
          
        translate([0,8,-thickness-3])
          // Hex Nut 5.5mm
          cylinder(3, r=5.8/2/cos(30), center=false, $fn=6);
        
      }
    }
}

module lead_screw_nut_hole(thickness){
  linear_axis_hole_diameter = 11;
  shaft_length=50;
  d=0.5;
    
  union(){
    
    cylinder(12, d=23, center=false, $fn=30);
    
    translate([0,0,-shaft_length]) rotate([0,0,-90]) pushfit_hole(shaft_length+d,10.2, 60,0.3);
    
    for (i=[0:3]) {
        rotation = 45+i*90;
        rotate([0,0,rotation]){
            translate([0,8,-shaft_length])
                rotate([0,0,-rotation]) // make sure the hexagon-shape prints nicely
                    polyhole(shaft_length+d, 1.6, center = false);
            
            translate([0,8,-shaft_length])
                rotate([0,0,-rotation])
                    cylinder(shaft_length-thickness, r=7/2,  center=false, $fn=6);
        }
     }
  }
}
  
module material_saving(depth=6){      
  difference(){
   translate([0,0-10-0.5,12])
      cube([29,depth+0.5,46]);   
    translate([0,0,0])
      cylinder(64, r=10, center=false, $fn=100);
    rotate([0,0,-45])
      cube([10,20,64]);
    translate([29,-10,12])
      rotate([0,0,45])
        cube([10,20,64]);  
     translate([0,-10,12])
      rotate([45,0,0])
        translate([0,0,-10])
          cube([40,20,10]);
     translate([0,-10,12+46])
      rotate([-45,0,0])
        cube([40,20,10]);
    translate([41.5,0,27.5+3])
      rotate([90,0,0])
        cylinder(15.0, r1=25, r2=10, center=false, $fn=100);
  }
}






module A6_X_end_basic_left()
{    
    width = 67;


    //main
    rotate([90,0,90]) translate([0,0,0])
      cylinder(width, r=10, center=false, $fn=100);
    
    rotate([90,0,90]) translate([80,0,0])
      cylinder(width , r=10, center=false, $fn=100);
    
    rotate([90,0,90]) translate([0,-10,0])
      cube([80,20,width],center=false);
    
    //bearing top level
    rotate([90,0,90])
        translate([41.5,10,27.5+3])
          rotate([-90,0,0])
          cylinder(9, r1=24, r2=18, center=false, $fn=100);
    
    //bearing bottom level
    rotate([90,0,90])
      translate([41.5,-10,27.5+3])
        rotate([90,0,0])
          cylinder(5.0, r1=15, r2=10, center=false, $fn=100);

    // wing front
    translate([width,-8,-4])
        rotate([0,0,90])
            wing(r=10, length=30, height=8);
    
    // wing back
    translate([width,88,-4])
        rotate([0,0,-90])
            mirror([0,1,0])
                wing(r=10, length=30, height=8);
}



module A6_X_end_basic_left_cutout()
{    

    // rod holes
    rotate([90,0,90]) {
        rod_hole();
        rod_screw();
        translate([80,0,0]) {
            rod_hole();
            rod_screw();
        }
    }
        
    //bearing hole
    //translate([41.5,16,27.5])
    translate([27.5+3,41.5,16])
        rotate([0,0,-90])
            bearing_LMH8_hole(rotation=-50);

    //lead_screw_nut hole
    translate([27.5+3+23, 41.5, 8])
        rotate([0,0,0])
            lead_screw_nut_hole(14);

    rotate([90,0,90]) material_saving();


    // cut wing front
    translate([36,-20,-0.75])
        cube([40, 20, 1.5]);

    // cut wing back
    translate([36,80,-0.75])
        cube([40, 20, 1.5]);
        
    *translate([-50,-100,-30]) cube([100,100,100]);
}



module A6_X_end_basic_right() {
    translate([0,0,0]) rotate([0,0,-180]) mirror([1,0,0]) A6_X_end_basic_left();
}

module A6_X_end_basic_right_cutout() {
    translate([0,0,0]) rotate([0,0,-180]) mirror([1,0,0]) A6_X_end_basic_left_cutout();
}

 
//test:
//translate([-80,0,0])   bearing_LMH8();
//translate([-40,0,0])   bearing_LMH8_hole(rotation=45);

// translate([-80,0,0])   lead_screw_nut(10);
// translate([-40,0,0])   lead_screw_nut_hole(10);


difference() {  
  A6_X_end_basic_left();
  A6_X_end_basic_left_cutout();
}

  * translate([27.5+3,41.5,16])
    rotate([0,0,40])
      bearing_LMH8();
      
  *translate([27.5+3+23, 41.5, 8])
      lead_screw_nut(14);
      
      
  *translate([200,0,0]) A6_X_end_basic_right();


