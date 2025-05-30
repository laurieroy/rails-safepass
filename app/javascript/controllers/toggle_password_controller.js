import { Controller } from "@hotwired/stimulus";
import { eyeClosedIcon, eyeOpenIcon } from "../utils/icons";

class TogglePasswordController extends Controller {
  static targets = ["input"];

  toggle(e) {
    if (this.inputTarget.type == "password") {
      this.inputTarget.type = "text";
      e.currentTarget.innerHTML = eyeClosedIcon;
    } else {
      this.inputTarget.type = "password";
      e.currentTarget.innerHTML = eyeOpenIcon;
    }
  }
}

export default TogglePasswordController;
