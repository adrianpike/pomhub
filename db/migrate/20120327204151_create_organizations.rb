class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|

      t.string  :name
      t.string  :website

      t.integer :owner_id

      t.boolean :public, :default => true

      t.timestamps
    end
  end
end
