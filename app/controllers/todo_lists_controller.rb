class TodoListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo_list, only: [:edit, :update, :destroy]

  def index
    @todo_lists = current_user.todo_lists
  end

  def new
    @todo_list = current_user.todo_lists.new
    @todo_list.todo_items.build unless @todo_list.todo_items.any?
  end

  def create
    @todo_list = current_user.todo_lists.new(todo_list_params)
    if @todo_list.save
      redirect_to root_path, notice: "Todo List created."
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @todo_list.update(todo_list_params)
      redirect_to root_path, notice: "Todo List updated."
    else
      render 'edit'
    end
  end

  def destroy
    if @todo_list.destroy
      redirect_to root_path, notice: "Deleted Todo List."
    else
      redirect_to root_path, alert: 'Something went wrong.'
    end
  end

  private

  def set_todo_list
    @todo_list = TodoList.find(params[:id])
  end

  def todo_list_params
    params.require(:todo_list).permit(
      :description,
      :notification,
      :freq,
      :completed,
      :archived,
      todo_items_attributes: [
        :id,
        :text,
        :completed,
        :_destroy
      ]
    )
  end
end
