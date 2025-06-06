$fn=64;

hoekje_r = 6;

pcb1_w = 83.2;
pcb1_h = 60.5;
pcb1_d =  4.0;

pcb2_w = 29.2;
pcb2_h = 52.0;
pcb2_d =  4.2;

// connector overhang is 1.5mm
w = 1.5;

buiten_w = 296.0;
buiten_h = 226.0;
buiten_d =   6.0;

lcd_w = 290.6;
lcd_h = 204.0;
lcd_d =   2.6;

bezel_edge_w = 293.0;
bezel_edge_h = 215.0;
bezel_edge_d =   1.5;

mag_w = 6.4;
mag_h = 4.4;
mag_d = 2.2;

stiffener_w = 200.0;
stiffener_h =  30.2;
stiffener_d =   3.2;

bottom_opening_w = 258.0;
bottom_opening_h =   6.0;
bottom_opening_d =   5.7;

bottom_bump_d = 2.7;

module m() {
    translate([buiten_w-w-1, 147.8, 4]) #cube([1+w+1, 1.4, 1.4]); // knopje

    difference() {
        union() {
            hull() {
                for(x=[hoekje_r, buiten_w-hoekje_r]) {
                    for(y=[hoekje_r, buiten_h-hoekje_r]) {
                        translate([x, y, 0]) cylinder(r=hoekje_r, h=buiten_d);
                        translate([x, y, 0]) cylinder(r=hoekje_r-1.6, h=buiten_d+1.6);
                    }
                }
            }

            translate([0, 0, -bottom_bump_d-w]) hull() {
                intersection() {
                    cube([buiten_w, hoekje_r, buiten_d]);
                    for(x=[hoekje_r, buiten_w-hoekje_r]) {
                        translate([x, hoekje_r, 0]) cylinder(r=hoekje_r, h=buiten_d);
                    }
                }
            translate([0, 8.5, 0]) cube([buiten_w, 1, buiten_d]);
            }
            
        }
        
        translate([(buiten_w-bottom_opening_w)/2, 3.0, -bottom_bump_d]) cube([bottom_opening_w, 20, bottom_bump_d+lcd_d]);
            
        translate([0.75, buiten_h-bezel_edge_h-5, 0]) {
            cube([1.0, bezel_edge_h, bezel_edge_d]);
            translate([2, 0, 0]) cube([2.0, bezel_edge_h, 0.4]);
        }
        translate([buiten_w-1.75, buiten_h-bezel_edge_h-5, 0]) {
            cube([1.0, bezel_edge_h, bezel_edge_d]);
            translate([-2, 0, 0]) cube([2.0, bezel_edge_h, 0.4]);
        }

        intersection() {
            translate([buiten_w-hoekje_r-.2, buiten_h-hoekje_r-.25, 0]) cylinder(r=hoekje_r-.5, h=bezel_edge_d);
            translate([buiten_w-hoekje_r-1, buiten_h-5.5-1, 0]) cube([hoekje_r+1, hoekje_r+1, bezel_edge_d]);
        }

        intersection() {
            translate([hoekje_r+.2, buiten_h-hoekje_r-.25, 0]) cylinder(r=hoekje_r-.5, h=bezel_edge_d);
            translate([0, buiten_h-5.5-1, 0]) cube([hoekje_r+1, hoekje_r+1, bezel_edge_d]);
        }
        
        translate([1, 10, 0]) cube([2, 4.5, bezel_edge_d]);
        translate([buiten_w-3, 10, 0]) cube([2, 4.5, bezel_edge_d]);

        translate([(buiten_w-bezel_edge_w+8)/2, buiten_h-1.75, 0]) cube([bezel_edge_w-8, 1.0, bezel_edge_d]);
        
        translate([(buiten_w-80)/2, buiten_h-6.75, 0]) cube([80, 6, 3]);
        
        translate([(buiten_w-lcd_w)/2, 22-6, -2]) {
           cube([lcd_w, lcd_h, lcd_d+2.01]);
        }
        

        
        translate([0, 1.8, lcd_d]) {

            translate([(buiten_w-stiffener_w)/2+10, 80, 0]) {
                cube([stiffener_w, stiffener_h, stiffener_d+1]);
            }

            translate([(buiten_w-stiffener_w)/2+10, 160, 0]) {
                cube([stiffener_w, stiffener_h, stiffener_d]);
            }

            translate([10, 16, 0]) {
                cube([stiffener_h, stiffener_w, stiffener_d]);
            }

            translate([buiten_w-pcb1_w-w+0.01, 15, 0]) {
                translate([0, 0, 0]) cube([pcb1_w, pcb1_h, pcb1_d]);

                translate([-2.5, 18, -1]) cube([2.5, 10, pcb1_d+1]);

                hull() { // mini-hdmi
                    translate([pcb1_w, 42.5, 0.2]) {
                        cube([w, 12, 2.6]);
                    }
                    translate([pcb1_w, 44.0, 0.6]) {
                        cube([w, 9, 3.6]);
                    }
                }

                for(i=[0, 14.4]) { // usb-c
                    hull() {
                        for(j=[0, 9.4-3.3]) {
                            translate([pcb1_w, 16.1+i+j, 4.0-1.5]) {
                                rotate([0, 90, 0]) cylinder(h=2, d=3.4);
                            }
                        }
                    }
                }

                translate([pcb1_w, 26.35, 4.0-1.5]) { // leds
                    rotate([0, 90, 0]) cylinder(h=2, d=2);
                }


                hull() { // usb-micro
                    translate([pcb1_w, 3.6, 0.0]) {
                        cube([w, 7.5, 2.0]);
                    }
                    translate([pcb1_w, 3.6+0.75, 0.0]) {
                        cube([w, 6, 2.8]);
                    }
                }

                translate([-100, pcb1_h-30, 0]) { // flatcable 1
                    cube([100, 25, 1.5]);
                }

                translate([-105.31, 0, 0]) { // flatcable 2
                    cube([110, 15, 1.5]);
                }
            }

            translate([buiten_w-115, 5, -0.01]) { // flatcable 1
                cube([25, 100, 1.5]);
            }

            translate([buiten_w-190, 20, 0]) { // flatcable 2
                cube([30, 97, 1.5]);
            }

            translate([buiten_w-pcb2_w-w+0.01, 100, 0]) {
                translate([0, 0, 0]) cube([pcb2_w, pcb2_h, pcb2_d]);
                
                translate([-2.5, 4, -1]) cube([2.5, 10, pcb2_d+1]);

                translate([pcb2_w-2, 3.9+2.8, 1.8]) { // headphone jack
                    rotate([0, 90, 0]) cylinder(h=4, d=5.6);
                }
                translate([pcb2_w-2, 3, pcb2_d-5]) { // headphone jack
                    cube([2, 7.2, 5]);
                }

                hull() { // usb-micro
                    translate([pcb2_w, 15.0, 1.0]) {
                        cube([w, 9.0, 2.0]);
                    }
                    translate([pcb2_w, 15.0+0.75, 1.0]) {
                        cube([w, 7.5, 3.0]);
                    }
                }

                translate([pcb2_w, 27.0, 0.4]) hull() { // rocker
                    translate([-w, 0, 0]) cube([w, 12.5, 3.2]);
                    translate([0, 1.25, 0]) cube([w, 10, 3.2]);
                }

                translate([pcb2_w-0.01, pcb2_h, 0]) { // knopje
                    translate([0, -6, 0.4]) {
                        cube([w+0.01, 6, 1.0]);
                    }
                    translate([0, -6, 2.8]) {
                        cube([w+0.01, 6, 1.0]);
                    }
                    translate([0, -7.0, 0.4]) {
                        cube([w+0.01, 1.0, 3.4]);
                    }
                }
                
                translate([-159.31, pcb2_h-35, 0]) { // flatcable 2
                    cube([150, 15, 2]);
                }
            }

        }
        
        for(x=[8, 50, 90]) {
            translate([x, buiten_h-mag_d-w, 0]) #cube([mag_w, mag_d, mag_h]);
            translate([buiten_w-mag_w-x, buiten_h-mag_d-w, 0]) #cube([mag_w, mag_d, mag_h]);
        }

        translate([0, buiten_h-211-mag_d, 0]) {
            translate([4, 0, 0]) #cube([mag_w, mag_d, mag_h]);
            translate([buiten_w-mag_w-4, 0, 0]) #cube([mag_w, mag_d, mag_h]);
        }

        translate([0, buiten_h-211-mag_d, 1.5]) {
            translate([25, 0, 0]) #cube([mag_w, mag_d, mag_h]);
            translate([buiten_w-mag_w-25, 0, 0]) #cube([mag_w, mag_d, mag_h]);
        }

        for(y=[34,66,100,150,186]) {
            translate([buiten_w-mag_d-0.75, buiten_h-mag_h-y, 0]) #cube([mag_d, mag_w, mag_h]);
        }

        for(y=[37,75,112,150,186]) {
            translate([0.75, buiten_h-mag_h-y, 0]) #cube([mag_d, mag_w, mag_h]);
        }

        translate([19.5, buiten_h-4.0, 0]) cylinder(d=2, h=4);
        translate([buiten_w-19.5, buiten_h-4.0, 0]) cylinder(d=2, h=4);

        translate([15.5, 13.5, 0]) cylinder(d=2, h=4);
        translate([buiten_w-15.5, 13.5, 0]) cylinder(d=2, h=4);

    }
}

if(false) { // test
    intersection() {
        rotate([0, 180, 0]) m();
        translate([-buiten_w-5, 0, -20]) cube([15, buiten_h, 40]);
    }
} else if(false) { // deel A
    intersection() {
        rotate([0, 180, 0]) m();
        translate([-buiten_w-5, 0, -20]) cube([buiten_w/2+5, buiten_h, 40]);
    }
} else { // part B
    intersection() {
        rotate([0, 180, 0]) m();
        translate([-buiten_w/2, 0, -20]) cube([buiten_w/2, buiten_h, 40]);
    }
}