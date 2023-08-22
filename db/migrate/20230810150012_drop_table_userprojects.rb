class DropTableUserprojects < ActiveRecord::Migration[7.0]
  def change
    drop_table :userprojects
  end
end
