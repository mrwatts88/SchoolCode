public class Card {

	Card(char faceValue, char suit) {
		this.faceValue = faceValue;
		this.suit = suit;
		setHasBeenDealt(false);
	}

	public char getFaceValue() {
		return faceValue;
	}

	public int getSuit() {
		return suit;
	}

	public boolean getHasBeenDealt() {
		return hasBeenDealt;
	}

	public void setHasBeenDealt(boolean hasBeenDealt) {
		this.hasBeenDealt = hasBeenDealt;
	}

	private char faceValue;
	private char suit;
	private boolean hasBeenDealt;
}