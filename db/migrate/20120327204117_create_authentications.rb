class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|

      t.integer :user_id
      t.string  :provider
      t.string  :provider_id
      t.string  :provider_token

      t.text    :raw_details

      t.timestamps
    end
  end
end
