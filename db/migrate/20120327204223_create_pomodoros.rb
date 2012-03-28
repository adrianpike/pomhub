class CreatePomodoros < ActiveRecord::Migration
  def change
    create_table :pomodoros do |t|

      t.integer :user_id
      t.text    :description

      t.datetime  :started_at
      t.datetime  :stopped_at

      t.timestamps
    end
  end
end
