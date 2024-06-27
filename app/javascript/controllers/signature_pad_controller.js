import { Controller } from "@hotwired/stimulus";
import SignaturePad from "signature_pad";

export default class extends Controller {
  static targets = ["canvas", "input", "clearButton", "saveButton"];

  connect() {
    this.signaturePad = new SignaturePad(this.canvasTarget);
    this.resizeCanvas();

    window.addEventListener("resize", this.resizeCanvas.bind(this));

    this.clearButtonTarget.addEventListener("click", () => {
      this.signaturePad.clear();
    });

    this.saveButtonTarget.addEventListener("click", (event) => {
      if (this.signaturePad.isEmpty()) {
        alert('You must sign to accept the Terms and Conditions');
        event.preventDefault();
      } else {
        this.inputTarget.value = this.signaturePad.toDataURL();
      }
    });
  }

  disconnect() {
    window.removeEventListener("resize", this.resizeCanvas.bind(this));
  }

  resizeCanvas() {
    const ratio = Math.max(window.devicePixelRatio || 1, 1);
    this.canvasTarget.width = this.canvasTarget.offsetWidth * ratio;
    this.canvasTarget.height = this.canvasTarget.offsetHeight * ratio;
    this.canvasTarget.getContext("2d").scale(ratio, ratio);
  }
}
