import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["publicLiabilityTypeSubmitBtn"]
  connect() {
    this.publicLiabilityTypeSubmitBtnTarget.hidden = true;
  }

  remoteSubmitPublicLiabilityType() {
    this.publicLiabilityTypeSubmitBtnTarget.click()
  }
}
