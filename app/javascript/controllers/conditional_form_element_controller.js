import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="conditional-form-element"
export default class extends Controller {
  static targets = ["submitBtn"]
  connect() {
    this.submitBtnTarget.hidden = true;
  }

  remoteSubmit() {
    this.submitBtnTarget.click()
  }
}
