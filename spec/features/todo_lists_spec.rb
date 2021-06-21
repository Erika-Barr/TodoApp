require 'rails_helper'
require 'pry'

feature "Index page" do
  let!(:user) { FactoryBot.create(:user) }
  let!(:todo_list) { FactoryBot.create(:todo_list, user: user) }

  before { login_as user }
  after  { logout }

  describe "New page" do
    let(:description) { "Things todo this month" }
    let(:item_text) { "Car Inspection" }

    it 'saves form values' do
      visit new_todo_list_path
      expect(page).to have_content("Create a Todo List")
      fill_in("todo_list_description", with: description)
      fill_in("todo_list_todo_items_attributes_0", with: item_text)
      click_on "Submit"

      saved_todo_list = TodoList.last
      expect(saved_todo_list.description).to eq(description)
      expect(saved_todo_list.todo_items.reload.last.text).to eq(item_text)
    end
  end

  describe "Edit page" do
    it 'updates form values' do
      new_description = "modified description"
      visit edit_todo_list_path(todo_list.id)
      fill_in("todo_list_description", with: new_description)
      click_on "Submit"
      todo_list.reload
      expect(current_path).to eq(root_path)
      expect(todo_list.description).to eq(new_description)
    end
  end

  describe "Index page" do
    it 'has create button' do
      visit todo_lists_path
      expect(page).to have_link("Create Todo List", href: new_todo_list_path)
    end

    describe 'full text search' do
      describe 'with postgresql' do
        it 'can search todo items text' do
          text = "postgres fts can search nested todo item"
          todo_item = todo_list.todo_items.create(text: text)
          todo_list.update_pg_search_document # update pg document

          # ensure todo list description text do not match query
          todo_list_text_match = /postgres fts can search nested todo item/.match(user.todo_lists.pluck(:description).join(" "))
          expect(todo_list_text_match.present?).to eq(false)

          visit todo_lists_path

          fill_in("query", with: text)
          click_on "Search"
          expect(page).to have_css("#todo-list-#{todo_list.id}") # next todo_item matches
        end
      end

      #describe 'with elastic search' do
      #end
    end

    it 'Displays todo list matrix' do
      visit todo_lists_path
      expect(page).to have_content("Todo List Matrix")

      within "#todo-list-#{todo_list.id}" do
         expect(page).to have_link("Edit Todo List", href: edit_todo_list_path(todo_list.id))
         expect(page).to have_content("#{todo_list.description}")
         expect(page).to have_content("#{todo_list.freq}")
         expect(page).to have_link("Delete Todo List", href: todo_list_path(todo_list.id))
       end
    end
  end # End of describe "Index page"
end
