import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["Facilitator", "Participant"]

  initialize() {
    //this.evaluateRoles()
    if (document.querySelector("body").dataset.facilitator === "true") {
      this.FacilitatorTargets.forEach(element => element.classList.remove("hidden"));
    } else {
      this.ParticipantTargets.forEach(element => element.classList.remove("hidden"));
    }
  }

  evaluateRoles() {
    fetch(`/talks/${document.querySelector("body").dataset.talkId}/current_visitor`)
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