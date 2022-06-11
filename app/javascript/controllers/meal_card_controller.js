import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    console.log("Hello, Stimulus!")
    // this.outputTarget.textContent = 'Hello, Stimulus!'
  }

  open() {
    let selectedRecipe = console.log(this.element.innerText);
  }
}
