//quick and dirty
$fn=50;
difference()
{
    union()
    {

        render()
        translate([11,0,0])
        difference()
        {
            
            cylinder(r=12, h=8);
            
            cylinder(r=3.5, h=8);
            
            linear_extrude(8)
            polygon([ 3.5*[-1/2,sqrt(3)/2], 3.5*[0,sqrt(3)/2 + tan(30)/2], 3.5*[1/2, sqrt(3)/2] ]);
            
        }


        arm_width=8;

        translate([15,-85,0])
        cube([arm_width, 85, arm_width]);

        translate([15,-85,5])
        cube([arm_width,arm_width,120 - 5 - 25]);

        linear_extrude(8)
        polygon([[-12*sqrt(2)/2 + 11,-12*sqrt(2)/2],[20,0],[20,-2*12*sqrt(2)/2-12]]);

        translate([15-2, -85 + arm_width, 120 - 25 ])
        rotate([90,0,0])
        rotate_extrude(angle=45)
        translate([2,0,0])
        square(arm_width);

        translate([-5,-85,120 - 4.25])
        rotate([0,45,0])
        translate([-10,0,0])
        cube([20*sqrt(2) + 10, arm_width, arm_width]);

        translate([20 + 1.5, -85 + arm_width,8])
        rotate([0,-90,0])
        linear_extrude(5)
        polygon([[0,0],[25*sqrt(2),0],[0,25*sqrt(2)]]);

        translate([-9, -85 + arm_width, 122])
        rotate([0,45,0])
        linear_extrude(5)
        polygon([[0,0],[10*sqrt(2),0],[0,10*sqrt(2)]]);


        translate([-20, -85, 120])
        difference()
        {
            
            cube([15, 23, 20]);
            
            translate([4, (23 - 15)/2, -1])
            cube([2, 15, 20 + 2]);
            
        }
    }
    
    //translate([4,-9,8-0.8])
    //rotate([0,0,270 + 40])
    translate([16,-24,8-0.8])
    rotate([0,0,270])
    linear_extrude(1)
    #text("BC3D", font="osifont", size=6);
    
}
