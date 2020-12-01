//prusaslicer wall thickness function, optionally rounded to 2 decimal places (as given in the software)

function wt(layer_height, extrusion_width, perimeters=1, rounding=true) =
    rounding ?
        round( 100 * (
            (perimeters - 1)
            *(extrusion_width - layer_height * (1 - PI/4))
            + extrusion_width
            )) / 100
    :
        (perimeters - 1)
        *(extrusion_width - layer_height * (1 - PI/4))
        + extrusion_width
    ;

for (i = [1:8]) {
    echo(wt(0.2, 0.45, i, false));
}