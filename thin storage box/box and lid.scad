
generate_lid=true;
generate_box=true;

length=249;
width=139;
height=139;
wall_thickness=1.37;
cutout_size=30;
clearance=1;


//inside box
if(generate_box) {
    inside_box_length=length-2*clearance;
    inside_box_width=width-2*clearance;
    inside_box_height=height-wall_thickness;
    difference() {
        difference() {
            cube([inside_box_width,inside_box_length,inside_box_height]);
            translate(wall_thickness*[1,1,1]) cube([inside_box_width,inside_box_length,inside_box_height+wall_thickness] - 2*wall_thickness*[1,1,1]);
        }
        translate([inside_box_width/2,inside_box_length+1,inside_box_height])  rotate(a=90, v=[1,0,0]) cylinder(r1=cutout_size,r2=cutout_size,h=inside_box_length+2);
    }
}

//lid
if(generate_lid) {
    translate([generate_box ? width+10 : 0,0,0]){
        difference() {
            difference() {
                cube([width,length,height]);
                translate(wall_thickness*[1,1,1]) cube([width,length,height+wall_thickness] - 2*wall_thickness*[1,1,1]);
            }
            translate([-1,length/2,height])  rotate(a=90, v=[0,1,0]) cylinder(r1=cutout_size,r2=cutout_size,h=width+2);
        }
    }
}