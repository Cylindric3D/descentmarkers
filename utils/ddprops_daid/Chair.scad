translate([0,0,7.5]) rotate([0,90,0]) difference()
{
	union()
	{
		translate([0,0,15]) cube([15,3,30], center=true);
		translate([0,7.5,10.5]) cube([15,15,3],center=true);
		translate([0,13.5,6]) cube([15,3,12], center=true);
	}
	translate([0, 1,20]) cube([12,1,16], center=true);
	translate([0,-1,20]) cube([12,1,16], center=true);

	translate([0,1,4.5]) cube([12,1,9], center=true);
	translate([0,-1,4.5]) cube([12,1,9], center=true);

	translate([0, 12.5,4.5]) cube([12,1,9], center=true);
	translate([0, 14.5,4.5]) cube([12,1,9], center=true);
}
