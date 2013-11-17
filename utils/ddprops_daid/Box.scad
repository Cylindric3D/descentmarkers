module wallInset()
{
	translate([-1, 0, 4]) cube([2  ,20,12]);
	translate([-1, 4, 4]) cube([2.5,12,12]);
	translate([0, 4, 7]) cube([1.8,12,3]);
	translate([0, 4, 13]) cube([1.8,12,3]);
}

module box()
{
	difference()
	{
		cube([20,20,20]);
		wallInset();
		translate([ 0,20, 0]) rotate([0,0,-90]) wallInset();
		translate([20, 0, 0]) rotate([0,0, 90]) wallInset();
		translate([20,20, 0]) rotate([0,0,180]) wallInset();
		translate([ 4, 0,19.5]) cube([4,20,1]);
		translate([12, 0,19.5]) cube([4,20,1]);
	}
}

translate([-15, 15, 0]) box();
//translate([-15,-15, 0]) box();
//translate([ 15,-15, 0]) box();
//translate([ 15, 15, 0]) box();
