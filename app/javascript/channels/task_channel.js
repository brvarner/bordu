import consumer from "channels/consumer";

consumer.subscriptions.create("TaskChannel", {
  connected() {},

  disconnected() {},

  received(data) {
    // Remove the task from its current status list
    const currentTaskElement = document.getElementById(`task-${data.task.id}`);
    if (currentTaskElement) {
      currentTaskElement.remove();
    }

    // Add the task to the new status list
    const newTaskList = document.getElementById(
      `project-${data.task.project_id}-${data.task.status}-tasks`
    );
    if (newTaskList) {
      newTaskList.insertAdjacentHTML("beforeend", data.task_html);
    }
  },
});
