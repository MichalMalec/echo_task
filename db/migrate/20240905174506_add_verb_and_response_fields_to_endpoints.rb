class AddVerbAndResponseFieldsToEndpoints < ActiveRecord::Migration[7.2]
  def change
    add_column :endpoints, :verb, :string, null: false
    add_column :endpoints, :code, :integer, null: false, default: 200
    add_column :endpoints, :headers, :jsonb, default: {}
    add_column :endpoints, :body, :text
  end
end
