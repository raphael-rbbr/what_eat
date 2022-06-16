import { Controller } from "stimulus"

export default class extends Controller {
    connect() {
      // this.element.splice(2, 1, "checked");
      console.log("Hello, Stimulus!", this.element)
    }
  }
