//non-modular quick print

// whole vent 15-20 from horizontal
// individual vents 45-50 from horizontal

use <snap_fit.scad>
use <fillet.scad>
use <mirror_offset.scad>
use <wall_thickness.scad>

$fn=100;
//wall_thickness=1.26; //3 perims, 0.2lh, 0.45ew
wall_thickness=wt(0.2, 0.45, 3, rounding=false);
echo(wall_thickness);

clip=false;
duct=true;

////test
test=false;
if(test)
{
    difference() {
        translate([0, 15, 0])
        union() {
            translate([0,0,13+wall_thickness])
            rotate([0,180,0])
            catch();
            
            cube([wall_thickness, 9.7+2*wall_thickness, 13+wall_thickness]);
        }
        
        translate([-499,-499,-50])
        cube([999,999,50]);
    }

    clip();
}
////test

if(clip)
{
    clip();
}


if(duct)
{
    union()
    {
        difference()
        {
            translate([0,0,-20])
            difference()
            {
                
                rotate([0, 90, 0])
                cylinder(r=80, h=172);
                
                translate([wall_thickness, 0, 0])
                rotate([0, 90, 0])
                cylinder(r=80 - wall_thickness, h=172 - 2*wall_thickness);
                
                translate([-499, -80, -499])
                cube([999, 80, 999]);
                
                translate([-499, -499, -81])
                cube([999, 999, 81]);
                
            }
            translate([-499, -499, -21])
            cube([999, 999, 21]);
        }
        
        difference()
        {
            translate([0, -20, 0])
            cube([172, 20, 60]);
            
            translate([wall_thickness, -21, -1])
            cube([172 - 2*wall_thickness, 21 + 0.01, 60 - wall_thickness + 1]);
        }
        
        mirror_offset(v=[1,0,0], p=[172/2,0,0], duplicate=true)
        translate([wall_thickness,80-16 - 6*sin(45),(-9.2-2*wall_thickness)*sin(45)])
        rotate([45, 0, 0])
        catch();

        translate([wall_thickness,80-16 - 6*sin(45) + 1.5*wall_thickness,(-9.2-2*wall_thickness)*sin(45)])
        rotate([45,0,0])
        rotate([0,90,0])
        %clip();
                
    }
}


module catch()
{
    
    difference()
    {
        cube([2.5, 9.7, 13] + wall_thickness*[1,2,1]);
        
        translate([-1, wall_thickness, -1])
        cube([2.5 + wall_thickness + 2, 9.7, 13 + 1]);
    }
    
    translate([2.5, wall_thickness + (9.7 - 8.5)/2, 13])
    rotate([0,90,0])
    loop(c1=8.5, c2=5+2.8+1+0.5, c3=wall_thickness, c4=wall_thickness, d1=2, d2=3, d3=2, d4=1);
    
    chamfer(l=9.7+2*wall_thickness, d=2.5+wall_thickness, p=[0, 9.7/2 + wall_thickness, 13+wall_thickness], v=[1,0,1], edge=90);
    
    translate([-wall_thickness,0,0])
    cube([wall_thickness, 9.7+2*wall_thickness, 13+wall_thickness]);
    
}
//catch();

module clip()
{
    //rotate([0,-90,0])
    translate([13,0,0])
    union()
    {
        
        hook(a2=1.5, a3=4.5, b2=12, b1=3, b3=2.4, b4=2.5, b5=2.5);
        
        translate([0,9.2,0])
        mirror([0,1,0])
        hook(a2=1.5, a3=4.5, b2=12, b1=3, b3=2.4, b4=2.5, b5=2.5);
        
        translate([0,2.5,0])
        rotate([90,0,180])
        hook(b4=4.2, b1=2.5, b5=4.2, b3=2.5, a1=0, a4=90, a5=13.5, a2=0.8, a3=2.5);
        
        translate([-13,0,0])
        cube([5,9.2,2.5]);
        translate([-8,0,0])
        cube([8,2.5,2.5]);
        translate([-8,6.7,0])
        cube([8,2.5,2.5]);
        
        mirror_offset(v=[0,1,0], p=[0,9.2/2,0], duplicate=true)
        fillet(l=2.5, r=3.2/4, v=[1,1,0], p=[0,3,0], center=false);
        
    }
}
//clip();
