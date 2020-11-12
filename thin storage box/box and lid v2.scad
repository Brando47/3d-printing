
generate_lid=false;
generate_box=true;

width=139;
length=249;
height=139;

wall_thickness=1.27;
cutout_size=30;
clearance=0;
fillet_size=5;

i_width=width-clearance;
i_length=length-clearance;
cutout_fillet=cutout_size/6;

$fn=50;
// inside box
difference()
{
    // generate basic shape
    base_box(i_width, i_length, height);
    
    // subtracting main cutout
    translate([i_width/2, i_length+0.01, height]) rotate(a=90, v=[1,0,0]) cylinder(r1=cutout_size, r2=cutout_size, h=i_length+0.02);
    
    // subtracting cutout fillets
    difference()
    {
        translate([i_width/2-cutout_size-cutout_fillet+0.01, 0,  height-cutout_fillet+0.01]) cube([2*(cutout_fillet+cutout_size), i_length+0.02, cutout_fillet]);
        translate([i_width/2-sqrt(cutout_size*cutout_size-cutout_fillet*cutout_fillet)-cutout_fillet+0.01, i_length+0.01, height-cutout_fillet+0.01]) rotate(a=90, v=[1,0,0]) cylinder(r1=cutout_fillet, r2=cutout_fillet, h=i_length+0.02);
        translate([i_width/2+sqrt(cutout_size*cutout_size-cutout_fillet*cutout_fillet)+cutout_fillet-0.01, i_length+0.01, height-cutout_fillet+0.01]) rotate(a=90, v=[1,0,0]) cylinder(r1=cutout_fillet, r2=cutout_fillet, h=i_length+0.02);
    }
}

module base_box (width, length, height)
{
    translate(fillet_size*[1,1,0])
    {
        difference()
        {
            minkowski()
            {
                cube([width, length, height] - fillet_size*[2,2,1]);
                cylinder(r=fillet_size, h=fillet_size);
            }
            
            translate(wall_thickness*[0,0,1]) 
            {
                minkowski()
                {
                    cube([width,length,height+0.01] - fillet_size*[2,2,1]);
                    cylinder(r=fillet_size-wall_thickness, h=fillet_size);
                }
            }
        }
    }
}
