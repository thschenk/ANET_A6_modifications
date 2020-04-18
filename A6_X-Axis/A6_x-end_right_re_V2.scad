// Anet A6 X-End RIGHT
//
// GNU GPL v3
// R.E. 2017.06

use <oshw-logo.scad>
use <pushfit_hole_re.scad>
use <polyhole_re.scad>
use <A6_x-end_re_V2.scad>
use <A6_x-end_right_belt_tensioner_V2.scad>
/*
module belt_hole(){  
  translate([-8.5/2,-16.5/2,0]){
    cube([8.5,16.5,80], center=false);
    translate([0,0,-1])
      belt_hole_bevel();
    translate([08.5,0,64.5])
      rotate([0,180,0])
        translate([0,0,0])
          belt_hole_bevel();
  }    
}
*/

module belt_hole_bevel(){
  polyhedron(
    points = [       
      [-5.25,-10,0 ],  
      [ 5.25,-10,0 ], 
      [ 5.25, 10,0 ], 
      [-5.25, 10,0 ],
      [-8.25,-13,3 ],  
      [ 8.25,-13,3 ], 
      [ 8.25, 13,3 ],
      [-8.25, 13,3 ]],
     
    faces = [
      [0,1,2,3],  
      [4,5,1,0],  
      [7,6,5,4], 
      [5,6,2,1],  
      [6,7,3,2],  
      [7,4,0,3]] 
  );
}

module belt_hole_bevel2(){
  polyhedron(
    points = [       
      [-10.2,-6.2,0 ],  
      [ 10.2,-6.2,0 ], 
      [ 10.2, 6.2,0 ], 
      [-10.2, 6.2,0 ],
      [-13.2,-9.2,3 ],  
      [ 13.2,-9.2,3 ], 
      [ 13.2, 9.2,3 ],
      [-13.2, 9.2,3 ]],
     
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
  union(){
    translate([0,0,40]){
      cube([10.5,20,80],center=true); 
      translate([0,0.635,0])
        cube([20.4,12.4,80],center=true);
       
      difference(){
        translate([0,0.635,0])
          cube([11.5,13.4,80],center=true);
        translate([11.5/2,13.4/2+.635,0])
          cylinder(81,r=.5,center=true,$fn=50);
        translate([-11.5/2,13.4/2+.635,0])
          cylinder(81,r=.5,center=true,$fn=50);
        translate([11.5/2,-13.4/2+.635,0])
          cylinder(81,r=.5,center=true,$fn=50);
        translate([-11.5/2,-13.4/2+.635,0])
          cylinder(81,r=.5,center=true,$fn=50);
      }
    }
    translate([0,0.635,0])
      cylinder(20,d=4.5,center=true,$fn=50);
    translate([0,-0.635,0])
      cylinder(20,d=4.5,center=true,$fn=50);
    translate([0,0.635,1])
      cylinder(2.6*2,d=7,center=true,$fn=50);
    translate([0,-0.635,1])
      cylinder(2.6*2,d=7,center=true,$fn=50);
    //translate([0,0.635,-6])
     // cylinder(2,d=9.5,center=true,$fn=50);
    //translate([0,-0.635,-6])
      //cylinder(2,d=9.5,center=true,$fn=50);
  }
}
    

module belthole_reinforcement(){
  translate([-56.75,-10,0]){
    cylinder(67,r=6.5, $fn=50, center=false);
    translate([-12,0,0])
      cylinder(67,r=6.5, $fn=50, center=false);
    translate([-12,-6.5,0])
      cube([12,13,67], center=false);
  }
}

module belthole_reinforcement_top(){
  translate([-52.25,10,0]){
    cylinder(67,r=2, $fn=50, center=false);
    translate([-21,0,0])
      cylinder(67,r=2, $fn=50, center=false);
    translate([-21,-2,0])
      cube([21,4,67], center=false);
  }
}


module A6_X_end_right() {
    difference(){
        union() {
            A6_X_end_basic_right();
            rotate([90,0,90]) belthole_reinforcement();
            rotate([90,0,90]) belthole_reinforcement_top();
        }

        A6_X_end_basic_right_cutout();  

      //belt hole  
      rotate([90,0,90]) translate([-62.75,-2.236,6])
        belt_hole();
      rotate([90,0,90]) translate([-62.75,-2.236,61.5+3])
        belt_hole_bevel();
      rotate([90,0,90]) translate([-62.75,-2.236+0.635,63+3])
        belt_hole_bevel2();

        
      //translate([-10,-90,0]) cube([100,100,100]); //horizontal cut
    }
    
}


A6_X_end_right();

% rotate([90,0,90]) translate([-62.5,-2,60]) rotate([0,90,0]) belt_tensioner();


% translate([27.5+3,-41.5,16])
    rotate([0,0,-40])
        bearing_LMH8();
  
% translate([27.5+3+23, -41.5, 8])
    lead_screw_nut(14);

