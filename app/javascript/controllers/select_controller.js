import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["project", "tasks"];

  connect() {
    this.showTasksForProject(this.projectTargets[0]);
  }

  select(e) {
    this.showTasksForProject(e.currentTarget);
  }

  showTasksForProject(project) {
    this.projectTargets.forEach((element) => {
      element.classList.remove("active");
    });
    project.classList.add("active");

    const projectId = project.dataset.projectId;
    this.taskTargets.forEach((tasks) => {
      tasks.classList.add("d-none");
      if (tasks.dataset.projectId === projectId) {
        tasks.classList.remove("d-none");
      }
    });
  }
}
