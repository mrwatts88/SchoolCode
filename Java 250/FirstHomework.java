/**
 * Simple application to print a drawing to the console. 
 */

/**
 * @author Matthew Watts Comp Sci 250-202 Summer 2017 Homework #1
 */

public class FirstHomework {

	public static void main(String[] args) {
		drawImage();
	}

	// Method to print an image consisting of asterisks.
	public static void drawImage() {
		for (int i = 0; i < 13; i++) {
			if (i % 3 == 0) {
				drawEight();
			} else {
				drawTwo();
			}
		}
	}

	// Method to print a line with 8 asterisks.
	public static void drawEight() {
		System.out.println("********");
	}

	// Method to print a line 8 spaces wide with an asterisk on each end.
	public static void drawTwo() {
		System.out.println("*      *");
	}
}
