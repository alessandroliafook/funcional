class Heap:

    def __init__(self, comparator=lambda a, b: return a > b): 

        self.array = []
        self.comparator = comparator
        self.index = -1

    def _parent(i):
        return (i - 1) / 2
    
    def _left(i):
        return (i * 2) + 1
    
    def _right(i):
        return (i * 2) + 2
    
    def _swap(self, x, y):
    
        t = self.array[x]
        self.array[x] = self.array[y]
        self.array[y] = t

    def isEmpty(self):
        return index == -1
    
    def toArray(self):
        return this.array.copy()

    def size(self):
        return self.index + 1

    def getHeap(self):
        return self.array 
    
    def clear(self):        
        self.array = []
        self.index = -1

    def _heapify(self, position):

        if position >= index:
            return
        
        max = position

        if(self._left(position) <= self.index and self.comparator(self.array[position], self.array[self._left(position)] == False)):
            max = self._left(position)

        if(self._right(position) <= self.index and self.comparator(self.array[position], self.array[self._right(position)] == False)):
            max = self._right(position)
        
        if max != position:
            self._swap(position, max)
            self._heapify(max)

    def insert(self, element):

        if (len(self.array) >= 0 and type(element) != type(self.array[0])) or element == None:
            return

        self.array.append(element)
        self.index += 1

        upHeap(self.index)

    def upHeap(self, position):

        if position > 0:

            parent = self._parent(position)

            if self.comparator(self.array[position], self.array[parent]) == True):

                self._swap(position, parent)
                self._heapify(position)
                self.upHeap(parent)

    def buildHeap(self, array):
        
        if array == None or len(array) == 0:
            return
        
        self.clear()

        for el in array:
            if el not None:
                self.insert(el)

    def extractRootElement(self):

        if index == -1:
            return None
        
        else:
            
            root = self.array[0]

            self.array[0] = self.array[self.index]
            self.array.pop(self.index)
            self.index -= self.index
            
            self._heapify(0)

            return root

    def rootElement(self):
        return self.array[0] if index != -1 else None
    
    def heapSort(self, array):

        out = []

        if array == None:
            return out
        
        comp = self.comparator

        self.comparator = lambda a, b: return a > b

        self.clear()

        for el in array:
            self.insert(el)

        el = self.extractRootElement()

        while el not None:
            out.append(el)
            el = self.extractRootElement()

        self.clear
        self.comparator = comp

        return out