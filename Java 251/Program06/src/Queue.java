public class Queue extends DynArray {
	
	public int size() { return super.elements(); }

	public boolean isEmpty() { return this.size() == 0; }

	public void que(double value) { super.insert(value); }

	public double deQue() {	return this.isEmpty() ? Double.NaN : super.removeAt(0);	}

	public void queueDump() {
		int size = this.size();
		for (int i = 0; i < size; i++) {
			System.out.println(super.at(i));
		}
	}
}