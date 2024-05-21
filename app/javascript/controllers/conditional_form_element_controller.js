import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="conditional-form-element"
export default class extends Controller {
  static targets = ["submitBtn", "liabilitySubmitBtn", "publicLiabilityTypeSubmitBtn"]
  connect() {
    this.submitBtnTarget.hidden = true;
    this.liabilitySubmitBtnTarget.hidden = true;
    this.publicLiabilityTypeSubmitBtnTarget.hidden = true;
  }

  remoteSubmit() {
    this.submitBtnTarget.click()
  }

  remoteSubmitLiability() {
    this.liabilitySubmitBtnTarget.click()
  }

  remoteSubmitPublicLiabilityType() {
    this.publicLiabilityTypeSubmitBtnTarget.click()
  }
}
