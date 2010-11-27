class AddSoctypeToEntries < ActiveRecord::Migration
  def self.up
    add_column :entries, :soctype, :string 
  end

  def self.down
    remove_column :entries, :soctype, :string 
  end
end
