import { Controller } from "stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  static targets = [ "mealSpot", "recipe" ]
  static values = {
     plan: Number
   }

  connect() {
    // this.sortable = Sortable.create(this.element, {
    //   group: 'shared',
    //   pull: 'clone',
    //   animation: 150
    // })

    this.sortable = Sortable.create(this.element, {
      group: {
          name: 'shared',
          pull: 'clone',
          put: false
      },
      animation: 150,
      sort: false
    })

    this.sortable = Sortable.create(this.element, {
      group: 'shared',
      animation: 150
    })

  }

      //   new Sortable(example4Left, {
      //     group: {
      //         name: 'shared',
      //         pull: 'clone',
      //         put: false // Do not allow items to be put into this list
      //     },
      //     animation: 150,
      //     sort: false // To disable sorting: set sort to false
      // });

      // new Sortable(example4Right, {
      //     group: 'shared',
      //     animation: 150
      // });

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
