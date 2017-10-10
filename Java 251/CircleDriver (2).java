import java.util.Scanner;

public class CircleDriver {
	public static void main(String[] args) {
		Scanner stdIn = new Scanner(System.in);

		Circle big1 = new Circle();
		System.out.println("# of instances: " + Circle.getInstanceCount());
		Circle small1 = new Circle(13.3);
		System.out.println("# of instances: " + Circle.getInstanceCount());
		System.out.println("");
		System.out.print("Big : ");
		big1.print();

		System.out.println("");
		System.out.print("Small : ");
		small1.print();

		System.out.println("\n");

		Circle big2 = new Circle(14);
		System.out.println("# of instances: " + Circle.getInstanceCount());
		Circle small2 = new Circle(big2);
		System.out.println("# of instances: " + Circle.getInstanceCount());

		System.out.println("");
		System.out.print("Big : ");
		big2.print();

		System.out.println("");
		System.out.print("Small : ");
		small2.print();

		System.out.println("\n");

		// double bigRadius;
		// System.out.print("Enter the radius of a big circle : ");
		// bigRadius = stdIn.nextDouble();
		// big.resize(bigRadius);
		//
		// double smallRadius;
		// System.out.print("Enter the radius of small circle : ");
		// smallRadius = stdIn.nextDouble();
		// small.resize(smallRadius);
		//
		// System.out.println("");
		// System.out.print("Big : ");
		// big.print();
		//
		// System.out.println("");
		// System.out.print("Small : ");
		// small.print();
		//
		// System.out.println("");
		// if (big.equals(small))
		// System.out.println(" big equals small ");
		// else
		// System.out.println(" big does not equals small ");
		//
		// System.out.println("");
		// Circle bigCopy = big.clone();
		// System.out.print("BigCopy : ");
		// bigCopy.print();
		//
		// System.out.println("");
		// if (bigCopy.equals(big))
		// System.out.println(" bigCopy equals big ");
		// else
		// System.out.println(" bigCopy does not equals big ");
		//
		// System.out.println("");
	}
}
