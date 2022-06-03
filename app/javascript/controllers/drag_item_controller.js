import { Controller } from "stimulus"
import Sortable from "sortablejs"

export default class extends Controller {

  connect() {
    this.sortable = Sortable.create(this.element, {
      onEnd:this.end.bind(this)
    })
  }

  end(event) {
    console.log(event)
  }

  // dragstart(event) {
  //   event.dataTransfer.setData("application/drag-key", event.target.getAttribute("data-todo-id"))
  //   event.dataTransfer.effectAllowed = "move"
  // }

  // dragover(event) {
  //   event.preventDefault()
  //   return true
  // }

  // dragenter(event) {
  //     event.preventDefault()
  // }

  // drop(event) {
  //   var data = event.dataTransfer.getData("application/drag-key")
  //   const dropTarget = event.target
  //   const draggedItem = this.element.querySelector(`[data-todo-id='${data}']`);
  //   const positionComparison = dropTarget.compareDocumentPosition(draggedItem)
  //   if ( positionComparison & draggedItem.id + 1 ) {
  //       event.target.insertAdjacentElement('beforebegin', draggedItem);
  //   } else if ( positionComparison & draggedItem.id - 1) {
  //       event.target.insertAdjacentElement('afterend', draggedItem);
  //   }
  //   event.preventDefault()
  // }

  // dragend(event) {
  // }

}
