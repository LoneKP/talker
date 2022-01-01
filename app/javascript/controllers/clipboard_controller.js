import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "copiedElement" ]

  copy() {
    navigator.clipboard.writeText(window.location.href)
  }

  copied() {
    this.copiedElementTarget.innerText = "Link copied!"

    setTimeout(() =>  
    this.copiedElementTarget.innerText = "Share talk link", 2000
    );
  }
  
}