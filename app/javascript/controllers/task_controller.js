import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "modal",
    "modalBody",
    "content",
    "statusInput",
    "details",
    "assignments",
    "toggleAssignment",
  ];

  connect() {
    this.modal = new bootstrap.Modal(this.modalTarget);
    this.assignmentsVisible = false;
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

  preventClose(event) {
    event.stopPropagation();
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
        if (data) {
          this.modal.hide();
        }
      } else {
        console.error("Error creating task");
      }
    } catch (error) {
      console.error("Error:", error);
    }
  }

  async changeStatus(event) {
    const taskId = event.currentTarget.dataset.taskId;
    const newStatus = event.target.value;
    const url = `/tasks/${taskId}/update_status`;

    try {
      const response = await fetch(url, {
        method: "PATCH",
        headers: {
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
            .content,
          Accept: "application/json",
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ status: newStatus }),
      });

      if (response.ok) {
        const data = await response.json();
      } else {
        console.error("Error updating status");
      }
    } catch (error) {
      console.error("Error:", error);
    }
  }

  toggleAssignments(event) {
    event.preventDefault();
    const taskId = event.currentTarget.dataset.taskId;

    const detailsElement = this.detailsTargets.find(
      (element) => element.dataset.taskId === taskId
    );

    const assignmentsElement = this.assignmentsTargets.find(
      (element) => element.dataset.taskId === taskId
    );

    const toggleAssignmentElement = this.toggleAssignmentTargets.find(
      (element) => element.dataset.taskId === taskId
    );

    const assignmentsVisible = !assignmentsElement.classList.contains("d-none");

    this.updateView(
      detailsElement,
      assignmentsElement,
      toggleAssignmentElement,
      assignmentsVisible
    );
  }

  updateView(
    detailsElement,
    assignmentsElement,
    toggleAssignmentElement,
    assignmentsVisible
  ) {
    if (assignmentsVisible) {
      detailsElement.classList.remove("d-none");
      assignmentsElement.classList.add("d-none");
      toggleAssignmentElement.textContent = "Assign Task";
    } else {
      detailsElement.classList.add("d-none");
      assignmentsElement.classList.remove("d-none");
      toggleAssignmentElement.textContent = "View Details";
    }
  }
}
