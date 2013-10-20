class AddScriptToService < ActiveRecord::Migration
  def change
    add_column :services, :script, :string
  end
end
