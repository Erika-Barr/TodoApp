require 'sidekiq-scheduler'

class BatchMonthlyTodoListWorker
  include Sidekiq::Worker
  sidekiq_options retry: 0 # send straight to dead set

  # executes before entering dead set
  sidekiq_retries_exhausted do |msg, ex|
    Sidekiq.logger.warn "#{msg['class']}- Failed #{msg['args']}: #{msg['error_message']}"
  end

  def perform
    TodoList.frequency('monthly').email_opt_in.each do |todo_list|
      UserMailer.delay.todo_notification(todo_list.id)
    end
  end
end
