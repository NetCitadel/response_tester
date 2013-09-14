class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.text :payload
      t.references :service, null: false

      t.timestamps
    end
  end
end
