const BinaryHeap = () => [];

const size = heap => heap.length;

const _parent = index => parseInt((index - 1) / 2);

const left = index => (index * 2) + 1;

const right = index => (index * 2) + 2;

const isEmpty = heap => (heap.length === 0);

const toArray = heap => heap;

const rootElement = heap => !isEmpty(heap) ? heap[0] : undefined;

const swap = (heap, index_1, index_2) => {
   const newHeap = [...heap];
   const item_1 = newHeap[index_1];
   newHeap[index_1] = newHeap[index_2];
   newHeap[index_2] = item_1;
   return newHeap;   
};

const heapify = (heap, index) => {
   const pseudo_index = size(heap) - 1;
   let newHeap = [...heap];
   if(index >= pseudo_index){
      return newHeap;
   }

   let max = index;

   if(left(index) <= pseudo_index && newHeap[index] <= newHeap[left(index)]){
      max = left(index);
   }

   if(right(index) <= pseudo_index && newHeap[index] <= newHeap[right(index)]){
      max = right(index);
   }

   if(max !== index){
      newHeap = swap(newHeap, index, max);
      newHeap = heapify(newHeap, max);
   }

   return newHeap;
};


const upHeap = (heap, index) => {
   if (index < 0){
      return [...heap];
   }

   let newHeap = [...heap];
   const parent_index = _parent(index);

   if(heap[index] > heap[parent_index]){
      newHeap = swap(newHeap, index, parent_index);
      newHeap = heapify(newHeap, index);
      newHeap = upHeap(newHeap, parent_index);
   }

   return newHeap;
};

const insert = (heap, element) => {
   let newHeap = [...heap, element];
   newHeap = upHeap(newHeap, size(newHeap) - 1);
   return newHeap;
};

const buildHeap = (array) => array.reduce((heap, elem) => {
    return insert(heap, elem); 
 }, BinaryHeap());

 const extractRootElement = heap => {
   if(isEmpty(heap)){
      return heap;
   }

   let newHeap = [...heap];
   const oldRoot = rootElement(newHeap);
   newHeap[0] = newHeap[size(newHeap) - 1];
   newHeap.pop();
   newHeap = heapify(newHeap, 0);
   return newHeap;
}