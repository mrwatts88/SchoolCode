package stickstairs;

public class stairs {

	public static final int STAIRS = 5;
	public static final int WIDTH = STAIRS * 5;

	public static void main(String[] args) {

		for (int i = 1; i <= STAIRS; i++) {

			for (int x = 1; x <= (WIDTH + (i * (-5))); x++) {
				System.out.print(" ");
			}

			printHead();

			for (int y = 1; y <= ((i - 1) * 5); y++) {
				System.out.print(" ");
			}

			System.out.println("*");

			for (int x = 1; x <= (WIDTH + (i * (-5))); x++) {
				System.out.print(" ");
			}

			printBody();

			for (int y = 1; y <= (i * 5); y++) {
				System.out.print(" ");
			}

			System.out.println("*");

			for (int x = 1; x <= (WIDTH + (i * (-5))); x++) {
				System.out.print(" ");
			}

			printLegs();

			for (int y = 1; y <= (i * 5); y++) {
				System.out.print(" ");
			}

			System.out.println("*");
		}

		for (int z = 1; z <= (WIDTH + 7); z++) {
			System.out.print("*");
		}
	}

	public static void printHead() {
		System.out.print("  o  ******");
	}

	public static void printBody() {
		System.out.print(" /|\\ *");
	}

	public static void printLegs() {
		System.out.print(" / \\ *");
	}

}