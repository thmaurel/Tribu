import { Controller } from "@hotwired/stimulus"
import Rails from 'rails-ujs'

// Connects to data-controller="play"
export default class extends Controller {
  static values = {
    player: Number,
    stats: Object
  }

  static targets = [
    "cubeAubergine",
    "cubeJambon",
    "cubeOlive",
    "cubeAnanas",
    "cubeChampi",
    "cubeChevre",
    "cubeTomate",
    "cubeSalade",
    "pv",
    "round"
  ]

  connect() {
    console.log("play")
    console.log(this.statsValue.aubergine)
    this.cubeAubergineTarget.style.left = `${4 + 50 * this.statsValue.aubergine}px`
    this.cubeJambonTarget.style.left = `${4 + 50 * this.statsValue.jambon}px`
    this.cubeOliveTarget.style.left = `${4 + 50 * this.statsValue.olive}px`
    this.cubeAnanasTarget.style.left = `${4 + 50 * this.statsValue.ananas}px`
    this.cubeChampiTarget.style.left = `${4 + 50 * this.statsValue.champi}px`
    this.cubeChevreTarget.style.left = `${4 + 50 * this.statsValue.chevre}px`
    this.cubeTomateTarget.style.left = `${4 + 50 * this.statsValue.tomate}px`
    this.cubeSaladeTarget.style.left = `${4 + 50 * this.statsValue.salade}px`
    this.pvTarget.innerText = this.statsValue.pv
  }

  play(event) {
    event.preventDefault()
    console.log("wesh alors")
    const formData = new FormData(event.currentTarget)
    const stats = Object.fromEntries(formData)
    fetch(`/players/${this.playerValue}/play?player=${this.playerValue}`, {
      method: "POST",
      headers: { "Content-Type": "application/json",  'X-CSRF_Token': Rails.csrfToken() },
      body: JSON.stringify(stats)
    })
      .then(response => response.json())
      .then((data) => {
        console.log(data.player.pv)
        this.cubeAubergineTarget.style.left = `${4 + 50 * parseInt(data.player.aubergine)}px`
        this.cubeJambonTarget.style.left = `${4 + 50 * parseInt(data.player.jambon)}px`
        this.cubeOliveTarget.style.left = `${4 + 50 * parseInt(data.player.olive)}px`
        this.cubeAnanasTarget.style.left = `${4 + 50 * parseInt(data.player.ananas)}px`
        this.cubeChampiTarget.style.left = `${4 + 50 * parseInt(data.player.champi)}px`
        this.cubeChevreTarget.style.left = `${4 + 50 * parseInt(data.player.chevre)}px`
        this.cubeTomateTarget.style.left = `${4 + 50 * parseInt(data.player.tomate)}px`
        this.cubeSaladeTarget.style.left = `${4 + 50 * parseInt(data.player.salade)}px`
        this.pvTarget.innerText = data.player.pv
        this.roundTarget.innerText = parseInt(this.roundTarget.innerText) + 1 
      })
  }
}
