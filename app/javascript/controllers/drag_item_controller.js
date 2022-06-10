import { Controller } from "stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  static targets = [ "mealSpot", "recipe" ]

  connect() {
    this.sortable = Sortable.create(this.element, {
      onEnd:this.end.bind(this),
      group: 'shared',
      pull: 'clone',
      animation: 150
    })
  }

  end(event) {
    // console.log(event)
    // let id = event.item.dataset.id
    // let data = new FormData()
    // data.append("to", event.newIndex + 1)

    // Rails.ajax({
    //   url: this.data.get("url").replace(":id", id),
    //   type: 'PATCH',
    //   data: data
    // })
  }

  createMeal(event) {
    console.log(this.mealSpotTarget.id)
    console.log(this.recipeTarget.id)
    const body = { "recipe_id": this.recipeTarget.id,
                   "position": this.mealSpotTarget.id,
                   "plan_id": this.planTarget.id }
    const url = "/profile/meals"
    fetch(url, {
          method: "POST",
          body: body
    })
  }

}
