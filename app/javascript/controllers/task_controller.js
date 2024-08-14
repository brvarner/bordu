import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal", "modalBody", "content", "statusInput"];
  static values = { status: String };

  connect() {
    this.modal = new bootstrap.Modal(this.modalTarget);
  }

  openModal(event) {
    const projectId = event.currentTarget.dataset.projectId;
    const status = event.currentTarget.dataset.taskStatus;
    const url = `/projects/${projectId}/tasks/new`;
    fetch(url)
      .then((response) => response.text())
      .then((html) => {
        this.modalBodyTarget.innerHTML = html;
        if (this.hasStatusInputTarget) {
          this.statusInputTarget.value = status;
        }
        this.modal.show();
      });
  }

  async createTask(event) {
    event.preventDefault();
    const form = event.target.closest("form");
    form.dataset.submitted = "true";
    const url = form.action;
    const formData = new FormData(form);
    try {
      const response = await fetch(url, {
        method: "POST",
        body: formData,
        headers: {
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
            .content,
          Accept: "application/json",
        },
      });

      if (response.ok) {
        const data = await response.json();
        console.log({ data });
        const taskContainer = document.getElementById(
          `${data.task.status}-tasks`
        );
        const newTaskHTML = data.task_html;
        taskContainer.insertAdjacentHTML("beforeend", newTaskHTML);
        this.modal.hide();
      } else {
        console.error("Error creating task");
      }
    } catch (error) {
      console.error("Error:", error);
    }
  }
}
