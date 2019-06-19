function init() {
  let heap = buildHeap([1,2,3,4,10,9,5,27]);

  mountTree(heap);

  // Actions
  $("#add").on("click", function () {
    heap = insert(heap, parseInt($('#value').val()));
    $('#value').val('');

    
    mountTree(heap);
  });

  $("#removeRoot").on("click", function () {
    heap = extractRootElement(heap);

    mountTree(heap);
  });

  $("#clear").on("click", function () {
    heap = buildHeap([]);
    
    mountTree(heap);
  });

}

function mountTree(heap) {
  function percorreHeap(root, index, heap) {
    let content = '';

    if (!root) {
      return '';
    
    }
    let indexLeft = left(index);
    let indexRight = right(index);
    let nodeLeft = heap[indexLeft];
    let nodeRight = heap[indexRight];

    let indexParent = _parent(index);

    let brotherLeft = heap[left(indexParent)];
    let brotherRight = heap[right(indexParent)];

    let entrySole = brotherLeft && brotherRight ? '' : 'sole';

    if (index !== 0) {
      content += `<div class="entry ${entrySole}">`
    }

    content += `<span class="label toggleable">${root}</span>`

    if (nodeLeft || nodeRight) {
      content += '<div class="branch">'

      content += percorreHeap(nodeRight, indexRight, heap);
      content += percorreHeap(nodeLeft, indexLeft, heap);

      content += '</div>'
    }

    if (index !== 0) {
      content += '</div>'
    }

    return content;
  }

  const content = percorreHeap(rootElement(heap), 0, heap);

  $('#content').html(content);
}