import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="play"
export default class extends Controller {
  connect() {
    console.log("play")
  }

  play(event) {
    event.preventDefault()
    console.log("wesh alors")
    const formData = new FormData(event.currentTarget)
    const stats = Object.fromEntries(formData)
    console.log(stats)
  }
}
