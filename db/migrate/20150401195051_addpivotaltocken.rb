class Addpivotaltocken < ActiveRecord::Migration
  def change
    add_column :users, :pivotaltoken, :string
  end
end
