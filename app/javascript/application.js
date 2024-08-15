// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import "channels";
import "dragula";

import jquery from "jquery";
window.jQuery = jquery;
window.$ = jquery;
import Rails from "@rails/ujs";
Rails.start();

document.addEventListener("turbo:load", function () {
  const containerSelectors = [
    '[id^="project-"][id$="-unassigned-tasks"]',
    '[id^="project-"][id$="-assigned-tasks"]',
    '[id^="project-"][id$="-in progress-tasks"]',
    '[id^="project-"][id$="-complete-tasks"]',
  ];

  const containers = containerSelectors.flatMap((selector) =>
    Array.from(document.querySelectorAll(selector))
  );

  const drake = dragula(containers, {
    moves: function (el, container, handle) {
      return el.classList.contains("task"); // Assuming each task has a 'task' class
    },
  });

  drake.on("drop", function (el, target, source, sibling) {
    // Handle the drop event
    const taskId = el.dataset.taskId;
    const newStatus = target.id.split("-").slice(-2, -1).join(" ");
    const projectId = target.id.split("-")[1];

    // Send AJAX request to update task status
    Rails.ajax({
      url: `/projects/${projectId}/tasks/${taskId}`,
      type: "PATCH",
      data: `task[status]=${newStatus}&task[id]=${taskId}`,
      task: `${taskId}`,
      success: function (response) {
        console.log("Task status updated successfully");
      },
      error: function (error) {
        console.log(this.data);
        console.error("Error updating task status:", error);
        // Revert the drag if the update fails
        drake.cancel(true);
      },
    });
  });
});
