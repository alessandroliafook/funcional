class Heap:

    def __init__(self, comparator=lambda a, b: a > b): 

        self.array = []
        self.comparator = comparator

    def _parent(self, i):
        return (i - 1) / 2
    
    def _left(self, i):
        return (i * 2) + 1
    
    def _right(self, i):
        return (i * 2) + 2
    
    def _swap(self, x, y):    
        self.array[x], self.array[y] = self.array[y], self.array[x]

    def isEmpty(self):
        return len(self.array) == 0
    
    def toArray(self):
        return this.array.copy()

    def size(self):
        return len(self.array)

    def getHeap(self):
        return self.array.copy() 
    
    def clear(self):        
        self.array = []

    def _heapify(self, position):

        if position >= self.size():
            return
        
        max = position

        if(self._left(position) < self.size() and self.comparator(self.array[max], self.array[self._left(position)]) == False):
            max = self._left(position)

        if(self._right(position) < self.size() and self.comparator(self.array[max], self.array[self._right(position)]) == False):
            max = self._right(position)

        if max != position:
            self._swap(position, max)
            self._heapify(max)

    def insert(self, element):

        if (len(self.array) > 0 and type(element) != type(self.array[0])) or element == None:
            return

        self.array.append(element)
        self.upHeap(self.size() - 1)

    def upHeap(self, position):

        if position > 0:

            parent = self._parent(position)

            if self.comparator(self.array[position], self.array[parent]) == True:

                self._swap(position, parent)
                self._heapify(position)
                self.upHeap(parent)

    def buildHeap(self, array):
        
        if array == None or len(array) == 0:
            return
        
        self.clear()
        map(self.insert, array)

    def extractRootElement(self):

        if self.size() == 0:
            return None
        
        else:
            
            root = self.array[0]

            if self.size() > 1:
                self.array[0] = self.array.pop(self.size() - 1)
                self._heapify(0)

            else:
                self.clear()

            return root

    def rootElement(self):
        return self.array[0] if self.size() > 0 else None
    
    def heapSort(self, array):

        out = []

        if array == None:
            return out
        
        comp, l = self.comparator, self.array

        self.comparator = lambda a, b: a < b
        self.clear()

        map(self.insert, array)
        
        [out.append(self.extractRootElement()) for i in xrange(self.size())]

        self.clear()
        self.comparator, self.array = comp, l

        return out


if __name__ == "__main__":

    h = Heap()
    assert h.size() == 0
    assert h.isEmpty() == True

    h.buildHeap([82, 6, 99, 12, 34, 64, 58, 1])
    assert h.size() == 8
    assert h.isEmpty() == False
    assert h.array == [99, 34, 82, 6, 12, 64, 58, 1]
    assert h.extractRootElement() == 99
    assert h.rootElement() == 82

    h.clear()
    assert h.size() == 0
    assert h.isEmpty() == True
    assert h.heapSort([82, 6, 99, 12, 34, 64, 58, 1]) == sorted([82, 6, 99, 12, 34, 64, 58, 1])