class TaskChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'task_channel'
  end

  def unsubscribed
    # remove unused comments
    # Any cleanup needed when channel is unsubscribed
  end
end
