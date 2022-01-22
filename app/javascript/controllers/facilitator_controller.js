import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["viewAsFacilitator", "viewAsParticipant"]

  initialize() {
    if (this.isFacilitator()) {
      this.viewAsFacilitatorTargets.forEach(element => element.classList.remove("hidden"));
    }
    else {
      this.viewAsParticipantTargets.forEach(element => element.classList.remove("hidden"));
    }
  }

  isFacilitator() {
    return this.showCookie("facilitator_id") === this.showCookie("visitor_id")
  }

  showCookie(name) {
    if (typeof document.cookie.split("; ").find(row => row.startsWith(name)) !== "undefined") {
      return document.cookie.split('; ').find(row => row.startsWith(name)).split('=')[1];
    }
    else {
      return "there is no such cookie"
    }
  }
}