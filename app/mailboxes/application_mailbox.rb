class ApplicationMailbox < ActionMailbox::Base
  # Routing for emails sent to updates.<task_id>.<user_id>@app.bordu.vip
  routing(/@updates\./i => :task_updates)
end
