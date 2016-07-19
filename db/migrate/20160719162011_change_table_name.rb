class ChangeTableName < ActiveRecord::Migration
  def self.up
    rename_table :survey, :surveys
  end

  def self.down
    rename_table :surveys, :survey
  end
end
