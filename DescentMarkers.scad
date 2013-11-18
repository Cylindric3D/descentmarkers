/*
 * Author:  Mark Hanford
 * License: Creative Commons Attribution-ShareAlike 3.0 Unported License
 *          see http://creativecommons.org/licenses/by-sa/3.0/
 * URL:     http://www.thingiverse.com
 */

include <utils/build_plate.scad>;

 
/* [Common] */
part = "all"; // [altar:Altar,grave:Grave,all:All]

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


module RoundCube(size, radius = 1, $fn)
{
	hull()
	{
		translate([radius, radius, radius]) sphere(r = radius);
		translate([size[0]-radius, radius, radius]) sphere(r = radius);
		translate([radius, size[1]-radius, radius]) sphere(r = radius);
		translate([size[0]-radius, size[1]-radius, radius]) sphere(r = radius);

		translate([radius, radius, size[2]-radius]) sphere(r = radius);
		translate([size[0]-radius, radius, size[2]-radius]) sphere(r = radius);
		translate([radius, size[1]-radius, size[2]-radius]) sphere(r = radius);
		translate([size[0]-radius, size[1]-radius, size[2]-radius]) sphere(r = radius);
	}
}


module GraveStone()
{
	color([0.7, 0.7, 0.7])
	union()
	{
		difference()
		{
			// Main stone body
			union()
			{
				translate([0, 0, 10]) rotate([90, 0, 0]) cylinder(r = 6, h = 3, center = true, $fn=60);
				translate([0, 0, 5]) cube([12, 3, 10], center = true);	
			}
		
			// Subtract to create the border
			color([0.7, 0.7, 0.7])
			translate([0, -1.5-j, -j])
			scale([0.9, 1, 0.9])
			union()
			{
				translate([0, 0, 11+j]) rotate([90, 0, 0]) cylinder(r = 6, h = 0.5+j, center = true, $fn=60);
				translate([0, 0, 5]) cube([12, 0.5+j, 11+j], center = true);
			}
		}

		// Icon
		color([0.5, 0.5, 0.5])
		translate([0, 0, 7])
		union()
		{
			translate([-0.75, -1.5, 0]) cube([1.5, 0.5, 5]);
			translate([-1.75, -1.5, 2.5]) cube([3.5, 0.5, 1.5]);
		}
	}
}

module Grave()
{
	GameTile();

	// Gravestone
	translate([0, 8, 0]) GraveStone();

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


module Altar()
{
	GameTile();
	
	translate([-10, -5, 0])
	union()
	{
		// Foot
		translate([0, 0, 1])
		hull()
		{
			RoundCube([20, 10, j], radius = 0.5, $fn=16);
			translate([1, 1, 2]) RoundCube([18, 8, j], radius = 0.5, $fn=16);
		}

		// Pedestal
		translate([1, 1, 0.5]) RoundCube([18, 8, 9], radius = 0.5, $fn=16);
		translate([4, 0.5, 0.5]) cylinder(r = 0.4, h = 9, $fn = 20);
		translate([16, 0.5, 0.5]) cylinder(r = 0.4, h = 9, $fn = 20);
		translate([4, 9.5, 0.5]) cylinder(r = 0.4, h = 9, $fn = 20);
		translate([16, 9.5, 0.5]) cylinder(r = 0.4, h = 9, $fn = 20);

		
		// Top
		translate([0, 0, 8])
		union()
		{
			hull()
			{
				translate([1, 1, 0]) RoundCube([18, 8, j], radius = 0.5, $fn = 16);
				translate([0, 0, 1]) RoundCube([20, 10, j], radius = 0.5, $fn = 16);
			}
		}
	}
}


module printPart()
{
	if (part == "altar") {Altar();}
	if (part == "grave") {Grave();}

	if (part == "all")
	{
		translate([-t*0.5, 0, 0])
		union()
		{
			Grave();
			translate([t, 0, 0]) Altar();
		}
	}
}

printPart();
%build_plate(build_plate_selector, build_plate_manual_x, build_plate_manual_y);
