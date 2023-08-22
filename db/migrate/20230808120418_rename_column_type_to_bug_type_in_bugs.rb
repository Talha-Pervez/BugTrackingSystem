class RenameColumnTypeToBugTypeInBugs < ActiveRecord::Migration[7.0]
  def up
    rename_column :bugs, :type, :bug_type
  end

  def down
    rename_column :bugs, :bug_type, :type
  end
end
