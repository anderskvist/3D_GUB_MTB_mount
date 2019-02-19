$fn = 100;

$diameter = 35;
$length = 40;
$width = 5;

$cabletie = 5;
$border = 2;

$topwidth = 30;
$toplength = 25;
$topheight = 2;

$offset = 4;

difference () {
    union () {
        difference() {
            union () {
                // block
                translate([$length/2-$toplength/2,-$topwidth/2,0]) 
                    cube([$toplength,$topwidth,$diameter/2+$width+$topheight]);

                // guide cross
                translate ([0,$offset,0]) {
                    translate([$length/2-3/2,-6,$diameter/2+$width+2])
                        cube([3,12,2.5]);
                    translate([$length/2-6,0-3/2,$diameter/2+$width+2])
                        cube([12,3, 2.5]);
                }

                difference () {
                    union () {
                        // center cylinder
                        translate([$cabletie+$border,0,0]) 
                            rotate([0,90,0]) cylinder($length-($cabletie+$border)*2,$diameter/2+$width,$diameter/2+$width);
                        // end caps
                        translate([0,0,0]) 
                            rotate([0,90,0]) cylinder(2,$diameter/2+$width,$diameter/2+$width);
                        translate([$length-2,0,0]) 
                            rotate([0,90,0]) cylinder(2,$diameter/2+$width,$diameter/2+$width);
                        // main cylinder
                        rotate([0,90,0]) cylinder($length,$diameter/2+$width-1,$diameter/2+$width-1);
                    }

                    // cutoffs in the side #1
                    translate([0,$diameter/2+$width/2,0])
                    {
                        difference() {
                            rotate([0,90,0]) translate([0,0,-1]) cylinder($length+2,$diameter*2+$width-1,$diameter*2+$width-1);
                            rotate([0,90,0]) translate([0,0,-2]) cylinder($length+4,$diameter+$width-1,$diameter+$width-1);
                        }
                    }
                    // cutoffs in the side #2
                    translate([0,-$diameter/2-$width/2,0])
                    {
                        difference() {
                            rotate([0,90,0]) translate([0,0,-1]) cylinder($length+2,$diameter*2+$width-1,$diameter*2+$width-1);
                            rotate([0,90,0]) translate([0,0,-2]) cylinder($length+4,$diameter+$width-1,$diameter+$width-1);
                        }
                    }
                }
            }
            
            // mount cylinder
            translate([-1,0,0]) 
                rotate([0,90,0]) cylinder($length+2,$diameter/2,$diameter/2);

        }        
        // support cylinder
        rotate([0,90,0]) cylinder($length,$diameter/2-1,$diameter/2-1);
    }
    
    // hollow support cylinder
    translate ([1,0,0])
        rotate([0,90,0]) cylinder($length-2,$diameter/2-2,$diameter/2-2);
    
    // remove bottom
    translate([-25,-50,-100])
        cube([100,100,100]);
    
    // hole for screw and hex nut
    translate ([0,$offset,0]) {
        // hole for screw (m5)
        translate([$length/2,0,0])
            cylinder(100,2.6,2.6);
        // hole for nut (m5)
        translate([$length/2,0,0])
            cylinder($fn=6, $diameter/2+$width/2,4.5,4.5);
    }
}