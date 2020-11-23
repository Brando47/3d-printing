
generate_lid=true;
generate_box=true;

width=139;
length=249;
height=139;

wall_thickness=1.27;
cutout_size=30;
clearance=0.3;
fillet_size=5;

i_width=width-2*wall_thickness-2*clearance;
i_length=length-2*wall_thickness-2*clearance;
cutout_fillet=cutout_size/6;
lid_height=cutout_size+5;
lid_cutout_depth=lid_height/2;

$fn=50;
// inside box
if(generate_box) {
    difference()
    {
        // generate basic shape
        base_box(i_width, i_length, height);
        
        // subtracting main cutout
        translate([i_width/2, i_length+0.01, height]) rotate(a=90, v=[1,0,0]) cylinder(r=cutout_size, h=i_length+0.02);
        
        // subtracting cutout fillets
        difference()
        {
            translate([i_width/2-cutout_size-cutout_fillet+0.01, 0,  height-cutout_fillet+0.01]) cube([2*(cutout_fillet+cutout_size), i_length+0.02, cutout_fillet]);
            translate([i_width/2-sqrt(cutout_size*cutout_size-cutout_fillet*cutout_fillet)-cutout_fillet+0.01, i_length+0.01, height-cutout_fillet+0.01]) rotate(a=90, v=[1,0,0]) cylinder(r=cutout_fillet, h=i_length+0.02);
            translate([i_width/2+sqrt(cutout_size*cutout_size-cutout_fillet*cutout_fillet)+cutout_fillet-0.01, i_length+0.01, height-cutout_fillet+0.01]) rotate(a=90, v=[1,0,0]) cylinder(r=cutout_fillet, h=i_length+0.02);
        }
    }
}

// lid
if(generate_lid) {
    translate([generate_box ? width+10 : 0,0,0])
    {
        
        difference()
        {
            base_box(width, length, lid_height);
            
            //remove side cutouts
            translate([-0.01,length/2,length+lid_height-lid_cutout_depth]) rotate(a=90, v=[0,1,0]) cylinder(r=length, h=width+0.02, $fn=200);
        }
        
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

