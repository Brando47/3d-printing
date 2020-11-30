//prusaslicer wall thickness function, rounded to 2 decimal places

function wt(layer_height, extrusion_width, perimeters=1) = 
    round( 100 * (
        (perimeters - 1)
        *(extrusion_width - layer_height * (1 - PI/4))
        + extrusion_width
        )) / 100;

//for (i = [1:8]) {
//    echo(wt(0.2, 0.45, i));
//}