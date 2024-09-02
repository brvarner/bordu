import { Controller } from "@hotwired/stimulus";

// Todo, fix this controller to have a clickable target or sumn
export default class extends Controller {
  document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll(".read-more").forEach(function (link) {
      link.addEventListener("click", function (event) {
        event.preventDefault();
        const shortText = this.previousElementSibling.previousElementSibling;
        const fullText = this.previousElementSibling;
  
        if (fullText.style.display === "none") {
          shortText.style.display = "none";
          fullText.style.display = "inline";
          this.textContent = "Read less";
        } else {
          shortText.style.display = "inline";
          fullText.style.display = "none";
          this.textContent = "Read more";
        }
      });
    });
  });
}


