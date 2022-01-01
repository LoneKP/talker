import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "source", "copiedElement" ]

  copy() {
    navigator.clipboard.writeText(this.sourceTarget.value)
  }

  copied() {
    this.copiedElementTarget.innerText = "Link copied!"

    setTimeout(() =>  
    this.copiedElementTarget.innerText = "Share talk link", 2000
    );
  }
  
}