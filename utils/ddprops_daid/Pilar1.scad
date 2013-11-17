module support() {
	union() {
		translate([0,0, 2]) rotate([0,-90,45]) linear_extrude(height=3,center=true){
		polygon(points=[[0,-12.5],[15,0],[0,12.5]], paths=[[0,1,2]]);
		}
		translate([0,0, 2]) rotate([-90,-90,45]) linear_extrude(height=3,center=true){
		polygon(points=[[0,-12.5],[15,0],[0,12.5]], paths=[[0,1,2]]);
		}
		difference() {
			cube([20,20,5], center=true);
//			translate([0,10,0]) cube([18,2,2], center=true);
//			translate([0,-10,0]) cube([18,2,2], center=true);
//			translate([10,0,0]) cube([2,18,2], center=true);
//			translate([-10,0,0]) cube([2,18,2], center=true);
		}
	}
}

union() {

linear_extrude(height=60, center=false, convexity=10, twist=360)
	union(){
		translate([0,0,0]) circle(r=3);
		translate([4,0,0]) circle(r=3);
		translate([-4,0,0]) circle(r=3);
		translate([0,4,0]) circle(r=3);
		translate([0,-4,0]) circle(r=3);
	}
support();
translate([0,0,60]) rotate([-180,0,0]) support();
}