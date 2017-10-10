
public class Circle {
	private double radius = 1.0;

	private void setRadius(double radius) {
		if (radius > 0) {
			this.radius = radius;
		}
	}

	public double getRadius() {
		return this.radius;
	}

	public void resize(double newRadius) {
		setRadius(newRadius);
	}

	@Override
	public Circle clone() {
		Circle clone = new Circle();
		clone.setRadius(this.getRadius());
		return clone;
	}

	public boolean equals(Circle guest) {
		return guest.getRadius() == this.getRadius();
	}

	public void print() {
		System.out.format("This circle's radius is %.1f.", getRadius());
	}
}
