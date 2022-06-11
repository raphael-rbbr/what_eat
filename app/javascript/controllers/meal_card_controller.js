import { Controller } from "@hotwired/stimulus"
import { useDispatch } from 'stimulus-use'

export default class extends Controller {
  static targets = ["recipe"]

  connect() {
    useDispatch(this);
  }

  click() {
    this.dispatch("click", { content: this.recipeTarget.id });
  }
}
