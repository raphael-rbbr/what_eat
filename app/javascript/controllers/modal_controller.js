import { Controller } from "@hotwired/stimulus"
import { useDispatch } from 'stimulus-use'

export default class extends Controller {
  connect() {
    console.log(this.modalTarget);
  }

  open(event) {
    const id = event.detail.content;
    const url = `/profile/recipes/${id}`
    fetch(url, { headers: { Accept: 'text/plain' } })
      .then((response) => response.text())
      .then((data) => {
        const recipe = document.getElementById(`recipe${id}`)
        recipe.outerHTML=data
      })



    // console.log(recipe.outerHTML);
  }

}
