/*
 * Author:  Mark Hanford
 * License: Creative Commons Attribution-ShareAlike 3.0 Unported License
 *          see http://creativecommons.org/licenses/by-sa/3.0/
 * URL:     http://www.thingiverse.com
 */

include <utils/build_plate.scad>;

 
/* [Common] */
part = "grave"; // [grave:Grave,all:All]

/* [Advanced] */

/* [Printer] */
build_plate_selector = 3; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 200; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 200; //[100:400]


/* [Hidden] */
// helper constants
x=0;y=1;z=2;
width=0;thickness=1;height=2;
t=25.4;

// Jitter
j = 0.01;

// Curve resolution
//$fn = 50;


module GameTile()
{
	color([0.3, 0.3, 0.3])
	translate([0, 0, -t]) 
	%cube([t, t, 2*t], center = true);
}

module Grave()
{
	GameTile();

	// Gravestone
	translate([0, 8, 0])
	union()
	{
		translate([0, 0, 10]) rotate([90, 0, 0]) cylinder(r = 6, h = 2, center = true, $fn=60);
		translate([0, 0, 5]) cube([12, 2, 10], center = true);
	}

	// Grave
	intersection()
	{
		union()
		{
			translate([0, 10, 0]) scale([1, 0.2, 0.2]) sphere(r = 8);
			scale([1, 1, 0.2]) rotate([90, 0, 0]) cylinder(r = 8, h = 20, center = true);
			translate([0, -10, 0]) scale([1, 0.2, 0.2]) sphere(r = 8);
		}
		translate([0, 0, t/2]) cube([t, t, t], center = true);
	}
}


module printPart()
{
	if (part == "grave")
	{
		Grave();
	}

	if (part == "all")
	{
		Grave();
	}
}

printPart();
%build_plate(build_plate_selector, build_plate_manual_x, build_plate_manual_y);
