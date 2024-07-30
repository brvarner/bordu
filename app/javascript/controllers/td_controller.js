// This is the task display controller

import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["tab", "content"];

  connect() {
    this.showContent(this.tabTargets[0]);
  }

  select(e) {
    this.showContent(e.currentTarget);
  }

  showContent(tab) {
    this.tabTargets.forEach((element) => {
      element.classList.remove("active");
    });
    tab.classList.add("active");

    const status = tab.dataset.status;
    this.contentTargets.forEach((content) => {
      content.classList.add("d-none");
      if (content.dataset.status === status) {
        content.classList.remove("d-none");
      }
    });
  }
}
