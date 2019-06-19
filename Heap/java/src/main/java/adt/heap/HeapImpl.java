package adt.heap;

import java.util.Arrays;
import java.util.Comparator;
import java.util.function.IntFunction;

import util.Util;

/**
 * O comportamento de qualquer heap é definido pelo heapify. Neste caso o
 * heapify dessa heap deve comparar os elementos e colocar o maior sempre no
 * topo. Essa comparação não é feita diretamente com os elementos armazenados,
 * mas sim usando um comparator. Dessa forma, dependendo do comparator, a heap
 * pode funcionar como uma max-heap ou min-heap.
 */
public class HeapImpl<T extends Comparable<T>> implements Heap<T> {

	protected T[] heap;
	protected int index = -1;
	/**
	 * O comparador é utilizado para fazer as comparações da heap. O ideal é
	 * mudar apenas o comparator e mandar reordenar a heap usando esse
	 * comparator. Assim os metodos da heap não precisam saber se vai funcionar
	 * como max-heap ou min-heap.
	 */
	protected Comparator<T> comparator;

	private static final int INITIAL_SIZE = 20;
	private static final int INCREASING_FACTOR = 10;

	/**
	 * Construtor da classe. Note que de inicio a heap funciona como uma
	 * min-heap.
	 */
	@SuppressWarnings("unchecked")
	public HeapImpl(Comparator<T> comparator) {
		this.heap = (T[]) (new Comparable[INITIAL_SIZE]);
		this.comparator = comparator;
	}

	@Override
	public boolean isEmpty() {
		return (index == -1);
	}

	@Override
	public T[] toArray() {
		return Arrays.copyOf(this.heap, this.size());
	}

	/**
	 * Valida o invariante de uma heap a partir de determinada posicao, que pode
	 * ser a raiz da heap ou de uma sub-heap. O heapify deve colocar os maiores
	 * (comparados usando o comparator) elementos na parte de cima da heap.
	 */
	private void heapify(int position) {

		IntFunction left2 = (n) -> n * 2 + 1;
		IntFunction right2 = (n) -> n * 2 + 2;

		if (position >= index)
			return;

		int max = position;
		int leftPos = Integer.valueOf(left2.apply(position).toString());
		int rightPos = Integer.valueOf(right2.apply(position).toString());

		if (leftPos <= index && comparator.compare(this.heap[max], this.heap[leftPos]) < 0)
			max = leftPos;

		if (rightPos <= index && comparator.compare(this.heap[max], this.heap[rightPos]) < 0)
			max = rightPos;

		if (max != position) {
			Util.swap(heap, position, max);
			heapify(max);
		}
	}

	@Override
	public void insert(T element) {
		// ESSE CODIGO E PARA A HEAP CRESCER SE FOR PRECISO. NAO MODIFIQUE
		if (index == heap.length - 1)
			heap = Arrays.copyOf(heap, heap.length + INCREASING_FACTOR);

		else if (element == null)
			return;

		else {

			this.heap[++index] = element;
			upHeap(index);
		}
	}

	public void upHeap(int position) {

		if (position > 0) {

			IntFunction parent = (n) -> (n - 1) / 2;
			int parentPos = Integer.valueOf(parent.apply(position).toString());

			if (comparator.compare(this.heap[position], this.heap[parentPos]) > 0) {
				Util.swap(heap, position, parentPos);
				heapify(position);
				upHeap(parentPos);
			}
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public void buildHeap(T[] array) {

		if (array == null)
			return;

		this.heap = (T[]) (new Comparable[INITIAL_SIZE]);
		this.index = -1;

		if (array.length != 0) {

			Arrays.asList(array).stream().filter(e -> e != null);
			Arrays.asList(array).forEach(n -> this.insert(n));
		}
	}

	@Override
	public T extractRootElement() {

		if (index == -1)
			return null;

		else {

			T root = this.heap[0];

			this.heap[0] = this.heap[index];
			this.heap[index--] = null;
			heapify(0);

			return root;
		}
	}

	@Override
	public T rootElement() {
		return (this.index == -1) ? null : this.heap[0];
	}

	@Override
	@SuppressWarnings("unchecked")
	public T[] heapsort(T[] array) {

		if (array == null)
			return (T[]) new Comparable[0];

		Comparator<T> atualComparator = this.comparator;

		this.setComparator(new Comparator<T>() {

			@Override
			public int compare(T arg0, T arg1) {
				return arg1.compareTo(arg0);
			}
		});

		this.clear();

		Arrays.asList(array).stream().filter(e -> e != null);
		Arrays.asList(array).forEach(n -> this.insert(n));

		T[] result = (T[]) (new Comparable[size()]);

		for (int i = 0; i < result.length; i++) {
			result[i] = extractRootElement();
		}

		this.clear();
		setComparator(atualComparator);

		return result;
	}

	@SuppressWarnings("unchecked")
	private void clear() {
		this.index = -1;
		this.heap = (T[]) (new Comparable[INITIAL_SIZE]);
	}

	@Override
	public int size() {
		return index + 1;
	}

	public Comparator<T> getComparator() {
		return comparator;
	}

	public void setComparator(Comparator<T> comparator) {
		this.comparator = comparator;
	}

	public T[] getHeap() {
		return heap;
	}

}
