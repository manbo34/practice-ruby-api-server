class CreateDirectMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :direct_messages do |t|
      t.references :user, foreign_key: true
      t.references :to, foreign_key: { to_table: :user }
      t.string :message

      t.timestamps
    end
  end
end
