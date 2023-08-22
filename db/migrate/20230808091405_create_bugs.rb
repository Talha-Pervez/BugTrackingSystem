class CreateBugs < ActiveRecord::Migration[7.0]
  def change
    create_table :bugs do |t|
      t.string :title
      t.text :description
      t.datetime :deadline
      t.string :screenshot
      t.string :type
      t.string :status
      t.integer :project_id
      t.integer :developer_id
      t.integer :qa_id
      t.timestamps
    end
  end
end
