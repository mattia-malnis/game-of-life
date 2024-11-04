import { Controller } from "@hotwired/stimulus";
import { Turbo } from "@hotwired/turbo-rails";

// Connects to data-controller="upload-dialog"
export default class extends Controller {
  static targets = ["inputField"];

  openDialog(e) {
    e.preventDefault();
    this.inputFieldTarget.click();
  }

  onInputChange() {
    Turbo.navigator.submitForm(this.element);
  }
}
