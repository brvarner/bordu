class ApplicationMailbox < ActionMailbox::Base
  # routing /something/i => :somewhere
  routing(/update-\d+/i => :updates)
end
