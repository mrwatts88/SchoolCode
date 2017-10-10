public class CardDriver {
	public static final String[] SUITS = { "C", "D", "H", "S" }; // Enumerating
																	// suits
	public static Card[] deck;

	public static void main(String[] args) {
		deck = initDeck();

		for (int i = 0; i < 100; i++) {
			swap();
		}

		printDeck();

		int cardIndex = findCard(new Card("Q", "C"));
		System.out.println(cardIndex);
	}

	public static Card[] initDeck() { // Fill deck with cards in order
		Card[] deck = new Card[52];
		for (int i = 0; i < 4; i++) {
			for (int j = 0; j < 13; j++) {
				deck[j + (i * 13)] = new Card(j + 1, SUITS[i]);
			}
		}
		return deck;
	}

	public static void swap() { // Swap position of two random cards using a
								// temp variable
		int indexA = (int) (Math.random() * 52);
		int indexB = (int) (Math.random() * 52);
		Card tempCard = deck[indexA];
		deck[indexA] = deck[indexB];
		deck[indexB] = tempCard;
	}

	public static void printDeck() {
		for (int i = 0; i < deck.length; i++) {
			System.out.format("%s ", deck[i].toString());
			if ((i + 1) % 5 == 0) {
				System.out.println();
			}
		}
		System.out.print("\n\n");
	}

	public static int findCard(Card card) { // Utilizing equals instance method
											// to find card in deck
		for (int i = 0; i < deck.length; i++) {
			if (deck[i].equals(card)) {
				return i;
			}
		}
		return -1;
	}
}