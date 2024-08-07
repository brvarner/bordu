import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "modal",
    "form",
    "statusInput",
    "projectIdInput",
    "content",
  ];

  connect() {
    console.log("Task controller connected");
    console.log("Modal element:", this.modalTarget);
    this.modal = new bootstrap.Modal(this.modalTarget);
    console.log("Modal instance:", this.modal);
  }

  openModal(event) {
    console.log("Opening modal");
    const status = event.currentTarget.dataset.status;
    const projectId = event.currentTarget.dataset.projectId;
    console.log("Status:", status);
    console.log("Project ID:", projectId);
    this.statusInputTarget.value = status;
    this.projectIdInputTarget.value = projectId;
    console.log("Attempting to show modal");
    this.modal.show();
    console.log("Modal show method called");
  }

  async createTask(event) {
    event.preventDefault();

    const formData = new FormData(this.formTarget);
    const projectId = this.projectIdInputTarget.value;

    try {
      const response = await fetch(`/projects/${projectId}/tasks`, {
        method: "POST",
        body: formData,
        headers: {
          Accept: "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
            .content,
        },
      });

      if (response.ok) {
        const task = await response.json();
        this.addTaskToList(task);
        this.modal.hide();
        this.formTarget.reset();
      } else {
        console.error("Error creating task");
      }
    } catch (error) {
      console.error("Error:", error);
    }
  }

  addTaskToList(task) {
    const statusContainer = this.element.querySelector(
      `[data-status="${task.status}"][data-project-id="${task.project_id}"]`
    );
    const taskElement = this.createTaskElement(task);
    statusContainer.insertAdjacentHTML("beforeend", taskElement);
  }

  createTaskElement(task) {
    return `
      <div class="card bg-warning my-3 p-3" data-bs-toggle="modal" data-bs-target="#task${task.id}Modal" style="cursor: pointer;">
        <div class="card-body d-flex align-items-center justify-content-center">
          <div class="card-title">
            <h5 class="text-center font-weight-bold">
              ${task.title}
            </h5>
          </div>
        </div>
      </div>
    `;
  }
}
