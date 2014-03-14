/* [Basic Settings] */

// Which part do you want to render?
part=0; // [0:Everything,1:Top,2:Bottom,3:Assembly]


// Major diameter (mm) of the tracker
Token_Size = 20;

// Major thickness (mm) of the tracker
Token_Thickness = 3;

// How many numbers on the wheel?
Hole_Count = 15;

/* [Advanced] */

// How much to explode the assembled diagram
Explode = 4;

// Thickness of the walls
Thickness = 1;


/* [Hidden] */
// Circle resolution
Resolution = 100;

// Size of the registration-pegs
Registration = 0.3;

// Jitter is used to prevent coincident-surface problems with CSG. Should be set to something small.
j=0.05;

// Default Circle Resolution
$fn = 20;


module MarkerFormer()
{
	r3 = (Token_Size/2)*0.7;
	r4 = ((Token_Size-Thickness)/2)*0.96;
	max_hole_size = ((2 * PI * r3)/Hole_Count)*0.45;
	
	rhole1 = min(2, max_hole_size);
	rhole2 = 0.1;

	hull()
	{
		translate([r3, 0, 0]) cylinder(r=rhole1, h=Thickness+j*2, $fn=Resolution);
		translate([r4, 0, 0]) cylinder(r=rhole2, h=Thickness+j*2, $fn=Resolution);
	}
}

module Top()
{
	r1 = Token_Size/2;
	r2 = (Token_Size-Thickness)/2;
	
	union()
	{
		difference()
		{
			union()
			{
				// The main body
				cylinder(r=r1, h=Token_Thickness, $fn=Resolution);
				
				// Decoration
				translate([0, 0, Token_Thickness-j])
				difference()
				{
					cylinder(r=r2, h=Registration, $fn=Resolution);
					translate([0,0,-j]) cylinder(r=r2-Registration, h=Registration+j*2, $fn=Resolution);
				}
				
				// Decoration
				translate([0, 0, Token_Thickness-j])
				difference()
				{
					cylinder(r=r2/5, h=Registration, $fn=Resolution);
					translate([0,0,-j]) cylinder(r=r2/5-Registration, h=Registration+j*2, $fn=Resolution);
				}
			}

			// Hollow out the main cavity
			translate([0, 0, -j]) cylinder(r=r2, h=Token_Thickness-Thickness+j, $fn=Resolution);

			// Carve out the main marker-hole
			translate([0, 0, Token_Thickness-Thickness-j])
			MarkerFormer();
		}

		// The registration-pegs
		translate([0, 0, -Registration/2])
		union()
		{
			for(i = [0 : Hole_Count])
			{
				rotate([0, 0, (360/Hole_Count)/2+((360/Hole_Count)*i)])
				translate([r2, 0, Token_Thickness-Thickness+j]) 
				union()
				{	
					sphere(r=Registration, $fn=21);
					cylinder(r=Registration, h=Registration, $fn=21);
				}
			}
		}
	}
}

module Bottom()
{
	r0 = Token_Size/2;
	r1 = (Token_Size-Thickness)/2;
	r2 = (Token_Size-Thickness*2)/2;
	
	t = 0.2;
	
	translate([0, 0, Thickness])
	union()
	{
		translate([0, 0, -Thickness]) cylinder(r=r0, h=Thickness+j, $fn=16);
		difference()
		{
			cylinder(r=r1, h=Token_Thickness-Thickness, $fn=Resolution);

			// The registration-pegs
			for(i = [0 : Hole_Count])
			{
				rotate([0, 0, (360/Hole_Count)/2+((360/Hole_Count)*i)])
				translate([r1, 0, Token_Thickness-Thickness]) sphere(r=Registration*1.2);
			}
		}
			
		// The registration pegs for the paper insert
		for(i = [0 : 4])
		{
			rotate([0, 0, (360/4)*i])
			translate([-r2, -t/2, Token_Thickness-Thickness-j]) cube([r2/3, t, Registration/2+j]);
		}
	}
}


if(part == 0)
{
	translate([-Token_Size/2-Thickness, 0, Token_Thickness]) rotate([180, 0, 0]) Top();
	translate([Token_Size/2+Thickness, 0, 0]) Bottom();
}
if(part == 1)
{
	Top();
}
if(part == 2)
{
	Bottom();
}
if(part == 3)
{
	Bottom();
	translate([0, 0, Token_Thickness+Thickness]*Explode) rotate([180, 0, 0]) Top();
	
}
