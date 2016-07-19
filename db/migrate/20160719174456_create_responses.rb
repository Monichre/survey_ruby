class CreateResponses < ActiveRecord::Migration
  def change
    create_table(:responses) do |t|
      t.column(:response_content, :string)
      t.column(:rating, :integer)

      t.timestamp()
    end
  end
end
