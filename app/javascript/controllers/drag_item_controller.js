import { Controller } from "stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  static targets = [ "mealSpot", "recipe" ]
  static values = {
     plan: Number
   }

  connect() {
    this.sortable = Sortable.create(this.mealSpotTarget, {
      group: 'shared',
      animation: 150
    })

    this.sortable = Sortable.create(cloning, {
      group: {
          name: 'shared',
          pull: 'clone',
          put: false
      },
      animation: 150,
      sort: false
    })

  }

  create(event) {
    const token = document.getElementsByName("csrf-token")[0].content;
    console.log(this.mealSpotTarget.id)
    console.log(this.recipeTarget.id)
    console.log(this.planValue)
    const body = JSON.stringify({ "recipe_id": this.recipeTarget.id,
                                  "position": this.mealSpotTarget.id,
                                  "plan_id": this.planValue })
    const url = "/profile/meals#create"
    fetch(url, {
          method: "POST",
          headers: { "Content-Type": "application/json", "X-CSRF-Token": token },
          body: body
    })
  }

}
