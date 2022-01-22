import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["copiedTextElement", "copiedButtonElement" ]

  copy() {
    navigator.clipboard.writeText(window.location.href)
  }

  copiedFromButton() {
    this.copiedButtonElementTarget.innerText = "Link copied!"

    setTimeout(() =>  
    this.copiedButtonElementTarget.innerText = "Invite link", 2000
    );
  }
}