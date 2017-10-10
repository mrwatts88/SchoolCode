public class Circle {
	public static final double PI = Math.PI;
	public final String units;
	private static int instanceCnt = 0;
	private double radius;

	public static int getInstanceCnt() {
		return Circle.instanceCnt;
	}

	private static void setInstanceCnt(int insCnt) {
		Circle.instanceCnt = insCnt;
	}

	public Circle() {
		this(1, "cm");
	}

	public Circle(double newRadius, String units) {
		Circle.setInstanceCnt(Circle.getInstanceCnt() + 1);
		this.units = units;
		this.setRadius(newRadius);
	}

	public Circle(Circle guest) {
		this(guest.getRadius(), guest.units);
	}

	public double getRadius() {
		return this.radius;
	}

	private void setRadius(double radius) {
		if (radius >= 0)
			this.radius = radius;
		else
			this.setRadius();
	}

	private void setRadius() {
		this.radius = 0;
	}

	public void resize(double newRadius) {
		this.setRadius(newRadius);
	}

	public double area() {
		return Circle.PI * Math.pow(this.radius, 2);
	}

	@Override
	public Circle clone() {
		return new Circle(this);
	}

	public boolean equals(Circle guest) {
		return guest.getRadius() == this.getRadius() && guest.units.equals(this.units);
	}

	public void print() {
		System.out.print("The circle\'s radius is " + this.getRadius() + this.units);
	}
}
