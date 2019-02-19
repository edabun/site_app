class CreateSites < ActiveRecord::Migration[5.2]
  def change
    create_table :sites do |t|
      t.string :name
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :sites, [:user_id, :created_at]
  end
end
