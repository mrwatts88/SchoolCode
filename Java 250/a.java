package a;

class a {
	public static final int ROWS = 3;

	public static void main(String[] args) {

		drawLine();
		drawSmallTop();
		drawSmallTop();
		drawLine();
		drawBigTop();
		drawBigTop();
		drawLine();
	}

	public static void drawLine() {
		System.out.print("+");
		for (int i = 1; i <= 2 * ROWS; i++) {
			System.out.print("-");
		}
		;
		System.out.print("+");
		System.out.println();
	}

	public static void drawSmallTop() {
		for (int i = 1; i <= ROWS; i++) {

			System.out.print("|");

			for (int j = 1; j <= -1 * i + ROWS; j++) {
				System.out.print(" ");
			}

			System.out.print("^");

			for (int k = 1; k <= 2 * i - 2; k++) {
				System.out.print(" ");
			}

			System.out.print("^");

			for (int j = 1; j <= -1 * i + ROWS; j++) {
				System.out.print(" ");
			}

			System.out.println("|");
		}
	}

	public static void drawBigTop() {
		for (int i = 1; i <= ROWS; i++) {

			System.out.print("|");

			for (int j = 1; j <= -1 * i + ROWS; j++) {
				System.out.print(" ");
			}

			System.out.print("V");

			for (int k = 1; k <= 2 * i - 2; k++) {
				System.out.print(" ");
			}

			System.out.print("V");

			for (int j = 1; j <= -1 * i + ROWS; j++) {
				System.out.print(" ");
			}

			System.out.println("|");
		}
	}
}
