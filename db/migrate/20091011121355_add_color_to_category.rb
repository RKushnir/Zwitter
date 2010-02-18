class AddColorToCategory < ActiveRecord::Migration
  def self.up
    add_column :categories, :color, :string, :length => 7
  end

  def self.down
    remove_column :categories, :color
  end
end
