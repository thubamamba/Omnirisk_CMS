import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["vehicleClaimTypeSubmitBtn"]
  connect() {
    this.vehicleClaimTypeSubmitBtnTarget.hidden = true;
  }

  remoteSubmitVehicleClaimType() {
    this.vehicleClaimTypeSubmitBtnTarget.click()
  }
}
