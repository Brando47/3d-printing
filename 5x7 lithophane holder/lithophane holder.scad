

frame=true;
back=false;

frame_text="Sample Text";
frame_font="osifont";
frame_rear_text="~ 22/11/20 ~";
frame_text_size=10;
frame_rear_text_size=6;
frame_text_depth=0.6;
litho_width=5*25.4;
litho_length=7*25.4;
litho_border_width=5;
litho_border_depth=1.85;
litho_press_fit=0.5;
frame_width=15;
frame_depth=5.5;
litho_tolerance=0.8;
screw_head_depth=3.1;
screw_head_diameter=5.5;
screw_diameter=3.2;
thread_diameter=4;
thread_length=15.5;

back_frame_depth=4.5;
frame_angle_from_vertical=11;
proportion_for_base=0.75;
arm_thickness=12;
light_ring_thickness=8;
light_mount_distance=150;
light_mount_diameter=28.5;

nothing=0.01;
cutout_depth=litho_border_depth+litho_press_fit;


//front half of frame
if(frame) {
    translate([0,0,frame_depth/2])
    rotate([0,180,0]) {
        difference()
        {
            
            //main frame
            cube([litho_width+2*frame_width,litho_length+2*frame_width,frame_depth], center=true);
            cube([litho_width+2*litho_tolerance,litho_length+2*litho_tolerance,frame_depth+nothing], center=true);
            
            //cutout for litho
            difference()
            {
                translate([0,0,-(frame_depth-cutout_depth)/2-nothing])
                cube([litho_width+2*litho_border_width+2*litho_tolerance,litho_length+2*litho_border_width+2*litho_tolerance,cutout_depth+nothing], center=true);
                
                //press fit
                for(i=(litho_width/2+litho_tolerance+2*litho_press_fit)*[-1,1])
                {
            
                    translate([i,0,-(frame_depth/2-cutout_depth)])
                    rotate([90,0,0]) cylinder(r=2*litho_press_fit, h=litho_length/4, center=true, $fn=100);
                    
                }
                for(i=(litho_length/2+litho_tolerance+2*litho_press_fit)*[-1,1])
                {
            
                    translate([0,i,-(frame_depth/2-cutout_depth)])
                    rotate([0,90,0]) cylinder(r=2*litho_press_fit, h=litho_width/4, center=true, $fn=100);
                    
                }
            }
                        
            //bolt holes
            for(i=(litho_width/2+frame_width/2)*[-1,1])
            {
                for(j=(litho_length+frame_width)/2*[-1,1])
                {
                    
                    translate([i,j,frame_depth/2-screw_head_depth])
                    cylinder(h=screw_head_depth+nothing, r=screw_head_diameter/2, $fn=50);
                    
                    translate([i,j,-frame_depth/2-nothing])
                    cylinder(h=frame_depth+2*nothing, r=screw_diameter/2, $fn=50);
                    
                }
            }
            
            //text
			translate([0,-(litho_length/2 + frame_width - frame_width/9), frame_depth/2 - frame_text_depth])
			linear_extrude(height=frame_text_depth+nothing)
            text(frame_text, font=frame_font, halign="center", size=frame_text_size, spacing=0.9, $fn=100);
			
            //text on rear
			translate([0,-(litho_length/2 + frame_width - frame_width/9), -frame_depth/2 + frame_text_depth])
			rotate([0,180,0])
			linear_extrude(height=frame_text_depth+nothing)
            text(frame_rear_text, font=frame_font, halign="center", size=frame_rear_text_size, $fn=100);
            
        }
    }
}


//back half of frame
if(back)
{
	difference()
	{
		union()
		{
			
			translate([frame ? (litho_width+3*frame_width) : 0,0,back_frame_depth/2])
			rotate([0,180,0]) {
				difference()
				{
					
					//main frame
					cube([litho_width+2*frame_width,litho_length+2*frame_width,back_frame_depth], center=true);
					cube([litho_width+2*litho_tolerance,litho_length+2*litho_tolerance,back_frame_depth+nothing], center=true);
					
				}
			}
			
			base_dist=(proportion_for_base*light_mount_distance)/tan(90 - frame_angle_from_vertical);
			for(i=(litho_width/2 + frame_width - arm_thickness/2)*[-1,1])
			{
				for(j=(litho_length/2 + frame_width - arm_thickness/2)*[-1,1])
				{
					//base arms
					hull()
					{
					
						translate([i,j,back_frame_depth-nothing/2])
						cube([arm_thickness, arm_thickness, nothing], center=true);
						
						translate([sign(i)*(litho_width/2+frame_width-base_dist), sign(j)*(litho_length/2+frame_width-base_dist), light_mount_distance + back_frame_depth + light_ring_thickness/2])
						cube([arm_thickness, arm_thickness, light_ring_thickness], center=true);
						
					}
					
					//arms to light mount //REDACTED
					//hull()
					//{
					
					//	translate([sign(i)*(litho_width/2+frame_width-base_dist), sign(j)*(litho_length/2+frame_width-base_dist), proportion_for_base*light_mount_distance])
					//	cube([arm_thickness, arm_thickness, arm_thickness], center=true);
						
					//	translate([sign(i)*light_mount_diameter, sign(j)*light_mount_diameter, light_mount_distance + back_frame_depth - light_ring_thickness/2])
					//	cube([arm_thickness, arm_thickness, light_ring_thickness], center=true);
						
					//}
					
					//"chamfer" to arms to light ring
					//hull()
					//{
						
					//	translate([sign(i)*light_mount_diameter, sign(j)*light_mount_diameter, light_mount_distance + back_frame_depth - light_ring_thickness/2])
					//	cube([arm_thickness, arm_thickness, light_ring_thickness], center=true);
						
					//	translate([sign(i)*((sqrt(2)/2)*(light_mount_diameter/2 + arm_thickness) + arm_thickness/2), sign(j)*((sqrt(2)/2)*(light_mount_diameter/2 + arm_thickness) + arm_thickness/2), light_mount_distance + back_frame_depth + light_ring_thickness/2])
					//	cube([arm_thickness, arm_thickness, light_ring_thickness], center=true);
						
					//}
					
					//arms to light ring
					hull()
					{
						
						translate([sign(i)*(litho_width/2+frame_width-base_dist), sign(j)*(litho_length/2+frame_width-base_dist), light_mount_distance + back_frame_depth + light_ring_thickness/2])
						cube([arm_thickness, arm_thickness, light_ring_thickness], center=true);
						
						translate([sign(i)*((sqrt(2)/2)*(light_mount_diameter/2) + arm_thickness/2), sign(j)*((sqrt(2)/2)*(light_mount_diameter/2) + arm_thickness/2), light_mount_distance + back_frame_depth + light_ring_thickness/2]) cube([arm_thickness, arm_thickness, light_ring_thickness], center=true);
						
					}
					
				}
			}
			
			//ring for light mount
			translate([0,0,light_mount_distance + back_frame_depth]) rotate_extrude($fn=200)
			{
				translate([light_mount_diameter/2,0,0]) square([arm_thickness, light_ring_thickness]);
			}
		}
		
		//thread holes
		hole_depth=thread_length-(frame_depth-screw_head_depth);
		for(i=(litho_width/2+frame_width/2)*[-1,1])
		{
			for(j=(litho_length+frame_width)/2*[-1,1])
			{
				
				translate([i,j,-nothing])
				cylinder(h=hole_depth+nothing, r=thread_diameter/2, $fn=50);
				
			}
		}
		
	}
}
