import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="rotate"
export default class extends Controller {
  static values = {
    tuile: Array,
    attaque: String,
    lvl: Number
  }

  static targets = ["tuile", "attaque"]

  rotate() {
    if (this.element.querySelector(".miror")) {
      fetch(`/rotate?tuile=${this.tuileValue}&attaque=${this.attaqueValue}&miror=1&lvl=${this.lvlValue}`, {
        headers: { "Accept": "text/plain" }
      })
        .then(response => response.text())
        .then((data) => {
          this.element.outerHTML = data
        })
    } else {
      fetch(`/rotate?tuile=${this.tuileValue}&attaque=${this.attaqueValue}&lvl=${this.lvlValue}`, {
        headers: { "Accept": "text/plain" }
      })
        .then(response => response.text())
        .then((data) => {
          this.element.outerHTML = data
        })
    }
    
  }

  miror() {
    this.tuileTarget.classList.toggle("miror")
    this.attaqueTarget.classList.toggle("attaque-toggle")
  }
}
