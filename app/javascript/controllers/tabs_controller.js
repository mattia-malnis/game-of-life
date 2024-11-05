import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="tabs"
export default class extends Controller {
  static targets = ["tab", "tabPanel"];

  change(e) {
    e.preventDefault();
    const tabID = e.target.dataset.reference;
    this.tabPanelTargets.forEach((el) => {
      if (el.id == tabID) {
        el.classList.remove("hidden");
      } else {
        el.classList.add("hidden");
      }
    });

    this.tabTargets.forEach((el) => {
      if (el == e.target) {
        el.classList.add("bg-lime-400", "text-emerald-900");
        el.classList.remove("text-white");
      } else {
        el.classList.remove("bg-lime-400", "text-emerald-900");
        el.classList.add("text-white");
      }
    });
  }
}
