use <mirror_offset.scad>;

height=25;
width=18.374;

thickness=10;

difference() {
    linear_extrude(thickness)
    import("astra bonnet stay clip.svg");
    
    
    mirror_offset(v=[0,0,1], p=[0,0,thickness/2], duplicate=true)
    translate([20,0,-0.01])
    #rotate([0,-90,0])
    linear_extrude(20)
    polygon([ [0,0],[2.5,0],[0,6.2] ]);
}


//chamfer_z=1;
//chamfer_reduction=0.4;
//step=0.2;
//
//mid_t=thickness-2*chamfer_z;
//
//
//mirror_offset(v=[0,0,1], duplicate=true)
//union() {
//    linear_extrude(mid_t/2)
//    clip();
//
//    for (z = [0:step:chamfer_z]) {
//        let (cf=chamfer_reduction*(z/chamfer_z)) {
//            
//            translate([0,0,mid_t/2+z])
//            linear_extrude(step)
//            offset(r=-cf)
//            clip();
//            
//        }
//    }
//}
//
//module clip() { import("astra bonnet stay clip.svg"); }