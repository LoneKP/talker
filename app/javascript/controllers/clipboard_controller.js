import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["copiedTextElement", "copiedButtonElement" ]

  copy() {
    navigator.clipboard.writeText(window.location.href)
    console.log("heey")
  }

  copiedFromButton() {
    this.copiedButtonElementTarget.innerText = "Link copied!"

    setTimeout(() =>  
    this.copiedButtonElementTarget.innerText = "Share talk link", 2000
    );
  }
  
  copiedFromText() {
    this.copiedTextElementTarget.innerText = "1. Link copied!"

    setTimeout(() =>  
    this.copiedTextElementTarget.innerText = "1. Share talk link with participants", 2000
    );
  }
}