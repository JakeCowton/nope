class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.jsonb :payload

      t.timestamps
    end
  end
end
