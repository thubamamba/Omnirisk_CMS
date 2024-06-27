import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["propertyClaimSubmitBtn"]
  connect() {
    this.propertyClaimSubmitBtnTarget.hidden = true;
  }

  remoteSubmitPropertyClaimType() {
    this.propertyClaimSubmitBtnTarget.click()
  }
}
