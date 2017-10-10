import java.util.Scanner;

/**
 * Program to calculate total cost of monthly subscriptions.
 */

/**
 * @author Matthew Watts
 *
 */
public class Metaview {

	public static void main(String[] args) {
		stars(20);
		System.out.print("MetaCorp Streaming Service");
		stars(21);
		askQuestions();
	}

	public static void stars(int n) {

		if (n > 0) {
			for (int i = 0; i < n; i++) {
				System.out.print("*");
			}
		} else {
			System.out.print("");
		}
	}

	public static void askQuestions() {

		Scanner myScanner = new Scanner(System.in);
		System.out.println("");
		int numOfMonths;

		do {
			System.out.print("Enter number of months on subscription: ");
			while (!myScanner.hasNextInt()) {
				System.out.print("That's not a number. Enter number of months on subscription: ");
				myScanner.next();
			}
			numOfMonths = myScanner.nextInt();
		} while (numOfMonths <= 0);

		int huluCost = ask("Hulu", 8, myScanner);
		int netflixCost = ask("Netflix", 10, myScanner);
		int primeCost = ask("Prime", 7, myScanner);

		myScanner.close();
		stars(67);
		System.out.println("");
		System.out.println("");

		int cost = numOfMonths * (huluCost + netflixCost + primeCost);

		String subscriptionString = createSubString(huluCost, netflixCost, primeCost);

		System.out.printf("%s for %d months is $%d.", subscriptionString, numOfMonths, cost);
	}

	public static String createSubString(int _huluCost, int _netflixCost, int _primeCost) {

		String subString = "";

		if (_huluCost > 0) {
			subString += "Hulu";
			if (_netflixCost > 0) {
				subString += " and Netflix";
			}
			if (_primeCost > 0) {
				subString += " and Prime";
			}
		} else if (_netflixCost > 0) {
			subString += "Netflix";
			if (_primeCost > 0) {
				subString += " and Prime";
			}
		} else if (_primeCost > 0) {
			subString += "Prime";
		} else {
			subString += "No subscriptions";
		}

		return subString;
	}

	public static int ask(String subscription, int price, Scanner myScanner) {

		System.out.printf("Do you want %s ($%d/month) [y = yes, anything else = no] : ", subscription, price);
		String answer = myScanner.next();

		boolean hasSub = (answer.equals("y"));
		System.out.println("");

		if (hasSub) {
			return price;
		} else
			return 0;
	}
}
