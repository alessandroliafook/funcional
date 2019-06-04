package adt.heap;

import java.util.Arrays;
import java.util.Comparator;

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

	// /////////////////// METODOS IMPLEMENTADOS
	private int parent(int i) {
		return (i - 1) / 2;
	}

	/**
	 * Deve retornar o indice que representa o filho a esquerda do elemento
	 * indexado pela posicao i no vetor
	 */
	private int left(int i) {
		return (i * 2 + 1);
	}

	/**
	 * Deve retornar o indice que representa o filho a direita do elemento
	 * indexado pela posicao i no vetor
	 */
	private int right(int i) {
		return (i * 2 + 1) + 1;
	}

	@Override
	public boolean isEmpty() {
		return (index == -1);
	}

	@Override
	public T[] toArray() {
		@SuppressWarnings("unchecked")
		T[] resp = (T[]) new Comparable[size()];
		for (int i = 0; i <= index; i++) {
			resp[i] = this.heap[i];
		}
		return resp;
	}

	// ///////////// METODOS A IMPLEMENTAR
	/**
	 * Valida o invariante de uma heap a partir de determinada posicao, que pode
	 * ser a raiz da heap ou de uma sub-heap. O heapify deve colocar os maiores
	 * (comparados usando o comparator) elementos na parte de cima da heap.
	 */
	private void heapify(int position) {

		if (position >= index)
			return;

		int max = position;

		if (left(position) <= index && comparator.compare(this.heap[position], this.heap[left(position)]) < 0)
			max = left(position);

		if (right(position) <= index && comparator.compare(this.heap[max], this.heap[right(position)]) < 0)
			max = right(position);

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

		// /////////////////////////////////////////////////////////////////
		// TODO Implemente a insercao na heap aqui.

		else if (element == null)
			return;

		else {

			this.heap[++index] = element;
			upHeap(index);
		}
	}

	public void upHeap(int position) {

		if (position > 0) {
			int parent = parent(position);

			if (comparator.compare(this.heap[position], this.heap[parent]) > 0) {
				Util.swap(heap, position, parent);
				heapify(position);
				upHeap(parent);
			}
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public void buildHeap(T[] array) {

		if (array == null)
			return;

		this.heap = (T[]) (new Comparable[INITIAL_SIZE]);
		index = -1;

		if (array.length != 0) {

			for (int i = 0; i < array.length; i++) {
				if (array[i] != null)
					insert(array[i]);
			}
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

		for (int i = 0; i < array.length; i++) {
			if (array[i] != null)
				this.insert(array[i]);
		}

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
