class TodoListsController < ApplicationController
  def index
  end

  def new
    @todo_list = TodoList.new
    @todo_list.todo_items.build unless @todo_list.todo_items.any?
  end

  def create
    binding.pry
    @todo_list = TodoList.create( todo_list_params.merge(user_id: 1) )
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def todo_list_params
    params.require(:todo_list).permit(
      :description,
      todo_items_attributes: [
        :id,
        :text,
        :_destroy
      ]
    )
  end

end
