$fs = 0.4;

module pilar()
{
	linear_extrude(height=24, twist=180, slices=120) {
		rotate(45) square([4,4], center=true);
	}
	translate([0,0,24]) cylinder(r1=2.85,r2=0,h=5,$fn=4);
}

module altar() {
	translate([0,0,10]) union() {
		render() difference() {
			cube([20,20,20],center=true);
			translate([0,0,15]) sphere(r=10,$fn=100);
		}
		for(i=[0:3]) {
			rotate([0,0,90*i]) translate([-10,-10,-10]) pilar();
		}
	}
}

module pentagram(radius, lineWidth, height) {
	linear_extrude(height=height, center=true) union() {
		difference() {
			circle(r=radius);
			circle(r=radius-lineWidth);
		}
		intersection() {
			union() {
				translate([0,0.3*radius]) rotate(18)
					square([radius*2,lineWidth], center=true);
				translate([0,-0.3*radius]) rotate(-18)
					square([radius*2,lineWidth], center=true);
				translate([0.26*radius,-0.2*radius]) rotate(18+36)
					square([radius*2,lineWidth], center=true);
				translate([0.26*radius, 0.2*radius]) rotate(-18-36)
					square([radius*2,lineWidth], center=true);
				translate([-0.28*radius,0]) rotate(90)
					square([radius*2,lineWidth], center=true);
			}
			circle(r=radius);
		}
	}
}
difference() {
	altar();
	for(i=[0:3]) rotate([0,0,90*i])
		translate([10,0,10]) rotate([0,-90,0]) pentagram(7.5, 1.2, 2);
}