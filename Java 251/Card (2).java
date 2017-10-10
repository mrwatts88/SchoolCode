public class Card {

	private String suit;
	private int rank;

	public Card() {
		this(1, "C"); // Default card is the Ace of Clubs
	}

	public Card(String rank, String suit) { // Allows instantiating card with
											// string representations for
		this.setRank(rank); // A,T,J,Q, and K
		this.setSuit(suit);
	}

	public Card(int rank, String suit) {
		this.setRank(rank);
		this.setSuit(suit);
	}

	public String getSuit() {
		return this.suit;
	}

	public int getRank() {
		return this.rank;
	}

	private void setSuit(String suit) { // Suit setter with validation
		if (suit.toUpperCase().equals("C") || suit.toUpperCase().equals("D") || suit.toUpperCase().equals("H")
				|| suit.toUpperCase().equals("S")) {
			this.suit = suit.toUpperCase();
		}
	}

	private void setRank(int rank) { // Rank setter with validation
		if (rank > 0 && rank < 14) {
			this.rank = rank;
		}
	}

	private void setRank(String rank) { // Overloading rank setter to allow for
										// strings
		if (rank.equals("A")) {
			this.setRank(1);
		} else if (rank.equals("T")) {
			this.setRank(10);
		} else if (rank.equals("J")) {
			this.setRank(11);
		} else if (rank.equals("Q")) {
			this.setRank(12);
		} else if (rank.equals("K")) {
			this.setRank(13);
		}
	}

	@Override
	public Card clone() {
		Card card = new Card(this.getRank(), this.getSuit());
		return card;
	}

	public boolean equals(Card guest) {
		return this.getRank() == guest.getRank() && this.getSuit().equals(guest.getSuit());
	}

	@Override
	public String toString() {
		String cardString = "";
		int rank = this.getRank();
		if (rank == 1) {
			cardString += "A";
		} else if (rank == 10) {
			cardString += "T";
		} else if (rank == 11) {
			cardString += "J";
		} else if (rank == 12) {
			cardString += "Q";
		} else if (rank == 13) {
			cardString += "K";
		} else {
			cardString += rank;
		}

		cardString += this.getSuit();
		return cardString;
	}
}