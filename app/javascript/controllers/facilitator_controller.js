import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["Facilitator", "Participant"]
  static values = { url: String }


  initialize() {
    this.evaluateRoles()
  }

  evaluateRoles() {
    fetch(this.urlValue)
    .then(response => response.json())
    .then((visitor) => {
      if (visitor.facilitator === true) {
        this.FacilitatorTargets.forEach(element => element.classList.remove("hidden"));
      } else {
        this.ParticipantTargets.forEach(element => element.classList.remove("hidden"));
      }
    });
  }
}