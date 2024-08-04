import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["project", "taskBoard"];

  connect() {
    if (this.projectTargets.length > 0) {
      this.selectProject({ currentTarget: this.projectTargets[0] });
    }
  }

  selectProject(event) {
    const selectedProjectId = event.currentTarget.dataset.projectId;

    this.projectTargets.forEach((project) => {
      project.classList.toggle(
        "active",
        project.dataset.projectId === selectedProjectId
      );
    });

    this.taskBoardTargets.forEach((board) => {
      board.classList.toggle(
        "d-none",
        board.dataset.projectId !== selectedProjectId
      );
    });
  }
}
