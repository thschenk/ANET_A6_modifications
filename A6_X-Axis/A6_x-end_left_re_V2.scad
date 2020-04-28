// Anet A6 X-End LEFT
//
// GNU GPL v3
// R.E. 2017.06

use <oshw-logo.scad>
use <pushfit_hole_re.scad>
use <polyhole_re.scad>
use <A6_x-end_re_V2.scad>
use <A6 x-end_left_motor_mount_re_V2.scad>


module belt_hole_bevel(){
  polyhedron(
    points = [
      [-3  ,-3  ,0 ],  
      [11.5,-3  ,0 ], 
      [11.5,19.5,0 ],
      [-3  ,19.5,0 ], 
      [ 0  , 0  ,3 ],  
      [ 8.5, 0  ,3 ], 
      [ 8.5,16.5,3 ], 
      [ 0  ,16.5,3 ]],     
    faces = [
      [0,1,2,3],  
      [4,5,1,0],  
      [7,6,5,4], 
      [5,6,2,1],  
      [6,7,3,2],  
      [7,4,0,3]] 
  );
}

module belt_hole(){  
  translate([-8.5/2,-16.5/2,0]){
    cube([8.5,16.5,80], center=false);
    translate([0,0,-1])
      belt_hole_bevel();
    translate([08.5,0,64.5+3])
      rotate([0,180,0])
        translate([0,0,0])
          belt_hole_bevel();
  }    
}

module belthole_reinforcement(){
  translate([58,-10,0]){
    cylinder(67,r=5, $fn=50, center=false);
    translate([9.5,0,0])
      cylinder(67,r=5, $fn=50, center=false);
    translate([5,0,32+1.5])
      cube([9.5,10,67], center=true);
  }
}

module endstop_EE_SX670(){
  translate([0,0,41.7]){
    translate([-26/2,-7.5/2,0])
      cube([26,7.6,22.3+1],center=false);
    translate([-14/2,-7.5/2,-12])
      cube([14,6,12+1],center=false);
    translate([19/2,0,,-6.7])
      polyhole(10,r=1.2,center=false);
    translate([-19/2,0,,-6.7])
      polyhole(10,r=1.2,center=false);    
    //LED
    translate([1.5,7.5/2,6.05])
      rotate([-90, 0, 0])
        cylinder(h=1.5,r1=2,r2=1,$fn=30);    
    }
  translate([-10.8,-0.75,-.7]){
    x= 6.6; y = 0; z = 31.7; // endpoint
    length = norm([x,y,z]); 
    b = acos(z/length); // inclination angle
    c = atan2(y,x);     // azimuthal angle
    rotate([0, b, c]) 
        cylinder(h=length, r=2.5,$fn=30);
  }
}


module endstop_microswitch(){
  translate([0,0,-10+64])
    cube([18.4,7,20],center=true);
  translate([0,0,10+64-10.2])
    cube([20.4,7,20],center=true);
  
    //end-stop cable hole
   translate([6,0,0]) rotate([0,-6,0])
      union() {
          translate([-18.3+9.1,-1,38])
            cylinder(51-40,r=2, $fn=20, center=false);
          
          translate([-18.3+9.1,-21,38])
                rotate([0,90,0])
                    rotate_extrude(angle=90, $fn=60)
                        translate([20, 0, 0])
                            circle(r = 2, $fn=20);
      }
  //end-stop microswitch screws
  translate([-4.75,8-1.3,56.5])
    rotate([90,0,0]){
      cylinder(17,r=0.9, $fn=30, center=false);
      cylinder(2,r=2.6, $fn=30, center=false); 
    }
  translate([4.75,8-1.3,56.5])
    rotate([90,0,0]){
      cylinder(17,r=0.9, $fn=30, center=false);
      cylinder(2,r=2.6, $fn=30, center=false); 
    }
}


difference(){
  union(){
    A6_X_end_basic_left();
    rotate([90,0,90]) belthole_reinforcement();
  }


   // cut top
  //translate([-1,-30,3.5]) cube([100,140,100]);

   // cut left
   //translate([-1,-110.4,-50]) cube([100,140,100]);
  //translate([-1,-131,-50]) cube([100,140,100]);

  
  A6_X_end_basic_left_cutout();  

  //translate([-1,-1,0]) cube([100,100,100]);

  //belt hole  
  rotate([90,0,90]) translate([62.75,-2.236,0])
    belt_hole();
  
  //endStop microswitch 
  rotate([90,0,90]) translate([18.3,4,0]) endstop_microswitch();
  //endStop Omron EE-SX670
  //translate([19.8,3.75,0]) endstop_EE_SX670();
  
  
  rotate([90,0,90]) { 
      //motorholder_holes centering
      translate([16+27/2,0,-0.1]) {
        cylinder(5.1,r1=5.1, r2=0, $fn=30, center=false);
        //cylinder(8.1,r=2.6, $fn=30, center=true);
      }
      //motorholder_holes screws
      translate([16,0,-0.1])
        polyhole(15.1,1.6,center=false);
      translate([16+27,0,-0.1])
        polyhole(15.1,1.6,center=false);
      //motorholder_holes screw nuts
      translate([16,-10+3.3,1.6+7])
        rotate([90,0,0])
          cube([5.8,3.2,20],center=true);
      translate([16+27,-10+3.3,1.6+7])
        rotate([90,0,0])
          cube([5.8,3.2,20],center=true);
      translate([16,0,1.6+7])
        rotate([90,0,0])
          cylinder(30,r=.9, $fn=30, center=true);
      translate([16+27,0,1.6+7])
        rotate([90,0,0])
          cylinder(30,r=.9, $fn=30, center=true);
  }
  
  /* Disabled, I have a BLTouch
  //Z-end-stop screws
  translate([72,-6-10+3,44.5])
    rotate([-90,90,0]){
      polyhole(30,1.6,center=false, $fn=30);
      cylinder(6, r=5.8/2/cos(30), center=false, $fn=6);
    }
  translate([72,-6-10+3,44.5+10])
    rotate([-90,90,0]){
      polyhole(30,1.6,center=false, $fn=30);
      cylinder(6, r=5.8/2/cos(30), center=false, $fn=6);
    }
  */
    
}


%translate([0,52.7,-27.2])
    rotate([90,0,0]) rotate([0,0,90])
        motor_mount_total();
