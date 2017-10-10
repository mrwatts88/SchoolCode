
public class CircleDriver {

	public static void main(String[] args) {

		System.out.println(Circle.getInstanceCnt() + " circles");
		Circle c1 = new Circle();
		System.out.println(Circle.getInstanceCnt() + " circles");
		Circle c2 = new Circle(c1);
		System.out.println(Circle.getInstanceCnt() + " circles");
		Circle c3 = new Circle(2, "in");
		System.out.println(Circle.getInstanceCnt() + " circles");
		Circle c4 = c3.clone();
		System.out.println(Circle.getInstanceCnt() + " circles");
		System.out.println("c1 equals c2: " + c1.equals(c2));
		System.out.println("c4 equals c3: " + c4.equals(c3));

		Circle c5 = new Circle(2, "cm");
		System.out.println("c5 equals c3: " + c5.equals(c3));

	}

}
