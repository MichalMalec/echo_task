class CreateEndpoints < ActiveRecord::Migration[7.2]
  def change
    create_table :endpoints do |t|
      t.string :path
      t.string :method
      t.text :response

      t.timestamps
    end
  end
end
