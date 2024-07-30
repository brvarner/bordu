class ApplicationMailbox < ActionMailbox::Base
  # Routing for emails sent to updates.<task_id>.<user_id>@app.bordu.vip
  routing(/^updates\.\d+\.\d+@parse\.bordu\.vip$/i => :task_updates)
end
