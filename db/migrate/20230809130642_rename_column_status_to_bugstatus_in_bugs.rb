class RenameColumnStatusToBugstatusInBugs < ActiveRecord::Migration[7.0]
  def up
    rename_column :bugs, :status, :bug_status
  end

  def down
    rename_column :bugs, :bug_status, :status
  end
end
