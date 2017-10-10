public class Circle {
	private static int instanceCount = 0;
	private double radius;

	public Circle() {
		this(1.0);
	}

	public Circle(double radius) {
		this.setRadius(radius);
		setInstanceCount(getInstanceCount() + 1);
	}

	public Circle(Circle circle) {
		this(circle.getRadius());
	}

	public double getRadius() {
		return this.radius;
	}

	public static int getInstanceCount() {
		return instanceCount;
	}

	public static void setInstanceCount(int count) {
		instanceCount = count;
	}

	private void setRadius(double radius) {
		if (radius >= 0)
			this.radius = radius;
		else
			this.radius = 0;
	}

	public void resize(double newRadius) {
		this.setRadius(newRadius);
	}

	@Override
	public Circle clone() {
		return new Circle(this);
	}

	public boolean equals(Circle guest) {
		return guest.getRadius() == this.getRadius();
	}

	public void print() {
		System.out.print("The circle\'s radius is " + this.getRadius());
	}
}
