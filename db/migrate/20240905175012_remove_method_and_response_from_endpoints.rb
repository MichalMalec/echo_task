class RemoveMethodAndResponseFromEndpoints < ActiveRecord::Migration[7.2]
  def change
    remove_column :endpoints, :method, :string
    remove_column :endpoints, :response, :text
  end
end
