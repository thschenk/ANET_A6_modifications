use <polyhole_re.scad>



module wing(r=12, length=50, height=9, hole_offset=0.5) {
    a = sqrt(3)*r;
    
    hole_x = - r/2 - hole_offset;
    hole_y = (length - r - a)/2 + r;

    difference() {
        // basic wing shape
        union () {
            intersection() {
                translate([-r,0,0]) cube([r, length, height]);
                union() {
                    translate([0,r,0]) cylinder(r=r, h=height);
                    translate([0,length-a,0]) cylinder(r=r, h=height);
                    translate([-r,r,0]) cube([r, length-r-a, height]);
                }
            }
            
            difference() {
                translate([-r/2,length-a,0]) cube([r/2, a, height]);
                translate([-r,length,-1]) cylinder(r=r, h=height+2);
            }
            
            // right block
            //cube([spacer, length, height]);
        }
    

        // screw hole
        translate([hole_x, hole_y, 0]) {
            translate([0,0,height-1]) cylinder(h=2, d=6.5);
            translate([0,0,-1])
                rotate([0,0,90])
                    polyhole(height+2, 1.6, center = false);
            
            translate([0,0,-2.5])
                rotate([0,0,90])
                    cylinder(4, r=5.8/2*1.155, center=false, $fn=6);
        }
        
    }
}


wing();