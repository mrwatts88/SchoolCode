import java.util.Scanner;

public class LetterCounter {

	public static void main(String[] args) {
		countTheLetters();
	}

	public static void countTheLetters() {

		int[] charFreq = new int[26];
		Scanner scanner = new Scanner(System.in);

		System.out.print("Please enter a string: ");
		String myString = scanner.nextLine().toUpperCase();
		scanner.close();

		for (int i = 0; i < myString.length(); i++) {

			if ((myString.charAt(i) >= 'A' && myString.charAt(i) <= 'Z')) {
				charFreq[myString.charAt(i) - 'A']++;
			}
		}

		for (char i = 'A'; i <= 'Z'; i++) {
			System.out.printf("%c %d \n", i, charFreq[i - 'A']);
		}
	}
}