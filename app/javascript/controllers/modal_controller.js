import { Controller } from "@hotwired/stimulus"
import { useDispatch } from 'stimulus-use'

export default class extends Controller {
  connect() {
  }

  open(event) {
    const id = event.detail.content;
    const url = `/profile/recipes/${id}`
    const recipe = document.getElementById(`recipe${id}`)
    fetch(url, { headers: { Accept: 'text/plain' } })
      .then((response) => response.text())
      .then((data) => {
        recipe.outerHTML=data
      })
  }

}
