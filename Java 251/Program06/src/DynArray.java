public class DynArray {
	
	private double[] array;
	private int size; // Actual number of elements in underlying array
	private int nextIndex; // Number of elements in DynArray that client is using	

	public DynArray() {
		this.array = new double[1];
		this.size = 1;
		this.nextIndex = 0;
	}
	
	public DynArray(double[] arr){ // Constructor for instantiating from a regular array
		this();
		for(double d:arr)
			this.insert(d);
	}

	public int arraySize() { return this.size; }

	public int elements() {	return this.nextIndex; }

	public double at(int index) { // Return the value at the given index if it is a valid index, else NaN										
		if (index >= 0 && index < this.elements()) {
			return this.array[index];
		} else
			return Double.NaN;
	}

	public void insertAt(int index, double value) {
		if (index == this.elements()) { // Call insert method if inserting at end
			this.insert(value);
		} else if (index >= 0 && index < this.elements()) { // Check to make sure the index is within the bounds of the array

			int i = 0;
			for (i = this.elements(); i > index; i--) { // Start from the nextIndex and copy the value from the previous element, until the desired index is reached
				this.array[i] = this.array[i - 1];
			}

			this.array[i - 1] = value; // Assign the value to the desired index

			++this.nextIndex; // Increment nextIndex pointer
			if (timeToGrow()) // Grow array if it is full
				this.grow();
		}
	}

	public void insert(double value) { // Adds a value to the array at nextIndex, increments the nextIndex pointer, and checks if the array needs to grow
		this.array[this.elements()] = value;
		++this.nextIndex;
		if (timeToGrow())
			this.grow();
	}

	public double removeAt(int index) {
		if (index >= 0 && index < this.elements()) { // Check for valid index
			double elRemoved = this.array[index]; // Store value of element being removed
			for (int i = index; i < this.elements() - 1; i++) {
				this.array[i] = this.array[i + 1]; // Starting at the desired index, copy the next position's value to the current position, until the last used value is copied
			}
			--this.nextIndex; // Decrement nextIndex pointer
			if (timeToShrink()) // Shrink array if less than half of the elements are being used by the client
				this.shrink();
			return elRemoved;
		} else
			return Double.NaN;
	}
	
	// Call removeAt() with the last used index as a parameter
	public double remove() { return this.removeAt(this.elements() - 1); }

	public void printArray() { // Print only the elements used by the client
		System.out.print("[");
		int i = 0;
		for (i = 0; i < this.nextIndex; i++) {
			System.out.format("%.1f", this.array[i]);
			if (i != this.nextIndex - 1)
				System.out.print(", ");
		}
		System.out.print("]");
	}
	
	// Underlying array is full
	private boolean timeToGrow() { return this.elements() == this.arraySize(); }

	// Underlying array is less than half full
	private boolean timeToShrink() { return (this.elements() < (this.arraySize() / 2));	}

	private void grow() {
		double[] arr = new double[this.arraySize() * 2]; // Create a new array with 2 * size of current array															 
		this.recreateDynArray(arr);
	}

	private void shrink() {
		double[] arr = new double[this.arraySize() / 2]; // Create a new array with 0.5 the size of current array															
		this.recreateDynArray(arr);
	}

	private void recreateDynArray(double[] copy) { // Helper method to prevent repeat code for grow() and shrink() methods
		this.size = copy.length; // Adjust size variable to account for new array's size
		for (int i = 0; i < this.elements(); i++) {
			copy[i] = this.array[i]; // Copy contents of current array to new array
		}
		this.array = copy; // Assign array's reference to the new array
	}
}