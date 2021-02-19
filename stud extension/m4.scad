//M4 Stud Extension
// use brass inserts either end

$fn=100;

d=11;
l=15;
insert_d=5.6;
//insert_t=6.6;

wrench=d-0.5;
wrench_t=l+2;

difference() {
    cylinder(d=d, h=l);
    
    translate([0,0,-1])
    cylinder(d=insert_d, h=l+2);
    
    for (i = [-wrench, wrench], j = [0,60,120])
        rotate([0,0,j])
        translate([i, 0, l/2])
        cube([d,d,wrench_t], center=true);
}
