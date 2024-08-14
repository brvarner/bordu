import consumer from "channels/consumer";

consumer.subscriptions.create("TaskChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const taskList = document.querySelector(
      `#project-${data.task.project_id} .${data.status}-tasks`
    );
    if (taskList) {
      taskList.insertAdjacentHTML("beforeend", data.task);
    }
  },
});
