class UserMailer < ApplicationMailer
  def todo_notification(todo_list_id)
    @todo_list = TodoList.find(todo_list_id)
    @user = @todo_list.user
    mail(to: @user.email, subject: "#{@todo_list.freq.capitalize} - Todo List progress")
  end
end
