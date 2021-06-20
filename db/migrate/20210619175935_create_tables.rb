class CreateTables < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      CREATE TYPE user_role AS ENUM ('standard', 'admin');
      CREATE TYPE todo_list_freq AS ENUM ('daily', 'weekly', 'monthly', 'not set');
    SQL

    create_table :users do |t|
      #t.string :first_name, null: false
      #t.string :last_name, null: false
      t.boolean :is_deactivated, default: false, null: false
    end
    add_column :users, :role, :user_role, default: 'standard'

    create_table :todo_lists do |t|
      t.integer :user_id, null: false
      t.text :description, limit: 300
      t.boolean :completed, default: false
      t.boolean :archived, default: false
      t.boolean :notification, default: false
    end
    add_column :todo_lists, :freq, :todo_list_freq, default: 'not set'
    add_foreign_key :todo_lists, :users

    create_table :todo_items do |t|
      t.integer :todo_list_id, null: false
      t.string :text, limit: 100, null: false
      t.boolean :completed, default: false
    end
    add_foreign_key :todo_items, :todo_lists
  end

  def down
    drop_table :todo_items
    drop_table :todo_lists
    drop_table :users

    execute <<-SQL
      DROP TYPE user_role;
      DROP TYPE todo_list_freq;
    SQL
  end
end
