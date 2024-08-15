import consumer from "channels/consumer";

consumer.subscriptions.create("TaskChannel", {
  connected() {},

  disconnected() {},

  received(data) {
    const taskList = document.getElementById(
      `project-${data.task.project_id}-${data.status}-tasks`
    );
    if (taskList) {
      taskList.insertAdjacentHTML("beforeend", data.task_html);
    }
  },
});
