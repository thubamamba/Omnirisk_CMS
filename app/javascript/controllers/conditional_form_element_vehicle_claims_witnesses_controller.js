import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["vehicleClaimWitnessesSubmitBtn"]
  connect() {
    this.vehicleClaimWitnessesSubmitBtnTarget.hidden = true;
  }

  remoteSubmitVehicleClaimWitness() {
    this.vehicleClaimWitnessesSubmitBtnTarget.click()
  }
}
