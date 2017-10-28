public class Stack extends DynArray {

	public int size() { return super.elements(); }

	public boolean isEmpty() { return this.size() == 0; }

	public void push(double value) { super.insert(value); }

	public double pop() { return this.isEmpty() ? Double.NaN : super.remove(); }

	public void stackDump() {
		int size = this.size();
		for (int i = size - 1; i >= 0; i--) {
			System.out.println(super.at(i));
		}
	}
}