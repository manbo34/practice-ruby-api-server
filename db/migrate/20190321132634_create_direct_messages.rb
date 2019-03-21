class CreateDirectMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :direct_messages do |t|
      t.integer :from_id
      t.integer :to_id
      t.string :message

      t.timestamps
    end
  end
end
