public class Deck {

	Deck() {
		char _faceValue;
		this.numberOfCardsRemaining = 52;
		this.cards = new Card[52];
		this.formatIndex = 0;
		for (int i = 0; i < 4; i++) {
			for (int j = 0; j < 13; j++) {
				if (j + 1 == 1) {
					_faceValue = 'A';
				} else if (j + 1 == 10) {
					_faceValue = 'T';
				} else if (j + 1 == 11) {
					_faceValue = 'J';
				} else if (j + 1 == 12) {
					_faceValue = 'Q';
				} else if (j + 1 == 13) {
					_faceValue = 'K';
				} else {
					_faceValue = Character.forDigit(j + 1, 10);
				}

				this.cards[j + i * 13] = new Card(_faceValue, availableSuits[i]);
			}
		}
	}

	private Card[] cards;
	private int numberOfCardsRemaining;
	private char[] availableSuits = { 'c', 'd', 'h', 's' };
	private int formatIndex;

	private void showCard(Card card) {
		if (formatIndex % 5 == 0) {
			System.out.println();
		}
		System.out.format("%c%c ", card.getFaceValue(), card.getSuit());
		formatIndex++;
	}

	public int getNumberOfCardsRemaining() {
		return numberOfCardsRemaining;
	}

	public void dealCard() {
		if (getNumberOfCardsRemaining() < 1) {
			System.out.println("\n\nNo cards remaining in deck.");
			return;
		}
		int randomCardIndex = (int) (Math.random() * 52);
		if (this.cards[randomCardIndex].getHasBeenDealt() == false) {
			this.cards[randomCardIndex].setHasBeenDealt(true);
			showCard(this.cards[randomCardIndex]);
			numberOfCardsRemaining--;
		} else {
			dealCard();
		}
	}

	public void dealRemainingCards() {
		while (getNumberOfCardsRemaining() > 0) {
			dealCard();
		}
	}
}