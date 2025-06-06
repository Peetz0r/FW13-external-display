module wavey(width, height, length, amplitude, periods, dl) {
    top_coords=[ for (l = [0:dl:length]) [l, height + amplitude*sin((l/length)*(periods*360.0))] ];
    bottom_coords=[ for (l = [length:-dl:0]) [l, amplitude*sin((l/length)*(periods*360.0))] ];
    coords = concat(top_coords, bottom_coords);
    linear_extrude(width) {
        polygon(coords);
    }
}

wavey(0.4, 200, 150, 5, 2.25, 0.1);