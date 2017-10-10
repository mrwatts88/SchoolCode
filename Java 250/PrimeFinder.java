import java.util.ArrayList;
import java.util.Scanner;

/**
 * A program to print out the first n prime numbers, where n is specified by the user.
 */

/**
 * @author Matthew Watts
 *
 */

public class PrimeFinder {

	/**
	 * @param args
	 */
	public static void main(String[] args) {

		int n = getN();

		if (n < 1) {
			return;
		}

		printPrimes(n);
	}

	// Asks the user to choose a positive number.
	public static int getN() {
		Scanner scanner = new Scanner(System.in);
		System.out.println("Welcome to the list of N prime numbers program!");
		System.out.println("=============================================================");
		System.out.println("Please enter the value of N (positive integer):");		
		int n = scanner.hasNextInt() ? scanner.nextInt() : 1;  		// Assigns 1 to n if invalid type.
		System.out.println("");
		scanner.close();
		return n;
	}

	/**
	 * @param n
	 * Finds the first n primes and prints them to the console.
	 */
	public static void printPrimes(int n) {
		System.out.printf("First %d prime numbers are:\n", n);
		ArrayList<Integer> primesFound = new ArrayList<Integer>();  // Store prime numbers in ArrayList as they are found.
		primesFound.add(2); 										// Add 2 initially because it is the only even prime.
		System.out.println(2);
		int currentCandidate = 3; 									// Start searching at 3.

		// Any non-prime number is divisible by at least one prime number lower than itself, so loop through the primes that have been found and see if the current candidate 
		// divided by that prime has a modulus of 0.  If it does, it is prime, move on to the next candidate. 
		while (primesFound.size() < n) {

			boolean isPrime = true;
			for (Integer prime : primesFound) {
				if (prime > Math.sqrt(currentCandidate)){  			// No need to check any divisors greater than the square root of the candidate, because if 
					break;								 			// it was prime, it would have been discovered before then.
				}					
				if (currentCandidate % prime == 0) {  				// Current candidate is not prime.
					isPrime = false;
					break;
				}
			}

			if (isPrime) {  										// Prime number found!!
				primesFound.add(currentCandidate);
				System.out.println(currentCandidate);
			}

			currentCandidate += 2;  								// Only check the odd candidates.
		}
	}
}