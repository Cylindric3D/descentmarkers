$fs=0.4;

translate([0,10,10]) rotate([90,0,0]) difference() {

union()
{

translate([0,0.0,15]) cube([50,20,2], center=true);
translate([0,-0.5,14]) cube([48,19,2], center=true);

translate([-20,-1,7.5]) cube([3,18,15], center=true);
translate([20,-1,7.5]) cube([3,18,15], center=true);

translate([0,2,11]) cube([40,10,5], center=true);

translate([0,7,11]) cube([10,1,4], center=true);
translate([12,7,11]) cube([10,1,4], center=true);
translate([-12,7,11]) cube([10,1,4], center=true);

translate([0,7,11]) cube([3,2,1], center=true);
translate([12,7,11]) cube([3,2,1], center=true);
translate([-12,7,11]) cube([3,2,1], center=true);

	translate([0,-5,16]) rotate([0,-90,0]) linear_extrude(height=50, center=true) {
		intersection() {
			circle(r=5);
			square([10,10]);
		}
		translate([0,-5]) square([5,5]);
	}
}

	translate([0,5,18]) cube([46,28,4], center=true);
}