import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["showSelectedDuration", "getSelectedDuration" ]

  //8 is the standard time per topic and 10 is the amount of time estimated to get set up and generate topics
  showDuration() {
    this.showSelectedDurationTarget.innerText = Math.floor((this.getSelectedDurationTarget.value - 10) /8)
  }
}