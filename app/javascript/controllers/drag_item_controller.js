import { Controller } from "stimulus"
import Sortable from "sortablejs"

export default class extends Controller {

  connect() {
    this.sortable = Sortable.create(this.element, {
      onEnd:this.end.bind(this),
      group: 'shared',
      pull: 'clone',
      animation: 150
    })
  }

  end(event) {
    console.log(event)
  }

}
