import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["liabilitySubmitBtn"]
  connect() {
    this.liabilitySubmitBtnTarget.hidden = true;
  }

  remoteSubmitLiability() {
    this.liabilitySubmitBtnTarget.click()
  }
}
