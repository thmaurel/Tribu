import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  connect() {
    Sortable.create(this.element, {group: 'shared', onEnd: this.computeAttaque})
  }

  computeAttaque(event) {
    let attaque = 0
    document.querySelectorAll(".ingame .attaque").forEach((tuile) => {
      attaque += parseInt(tuile.innerHTML)
    })
    if (parseInt(document.querySelector(".cubeTomate").style.cssText.split(" ")[1].split('px')[0]) > 250) {
      attaque += 3
    } else if (parseInt(document.querySelector(".cubeTomate").style.cssText.split(" ")[1].split('px')[0]) > 150) {
      attaque += 2
    } else if (parseInt(document.querySelector(".cubeTomate").style.cssText.split(" ")[1].split('px')[0]) > 50) {
      attaque += 1
    }
    document.querySelector(".attaque-input").value = attaque
  }
}
