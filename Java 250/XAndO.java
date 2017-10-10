/**
 * Simple application to print a drawing to the console. 
 */

/**
 * @author Matthew Watts Comp Sci 250-202 Summer 2017 Homework #3
 */

package xando;

public class XAndO {

	public static final int ROWS = 6;
	public static final int COLS = ROWS + 1;

	public static void main(String[] args) {
		drawImage();
	}

	// Draws a grid of Xs and Os
	public static void drawImage() {

		for (int row = 1; row <= ROWS; row++) {

			// Draw Os
			for (int o = 1; o <= row; o++) {
				System.out.print("O");
			}

			// Draw Xs
			for (int x = 1; x <= COLS - row; x++) {
				System.out.print("X");
			}

			System.out.println("");
		}
	}
}
