class CreateFollows < ActiveRecord::Migration[5.2]
  def change
    create_table :follows do |t|
      t.references :user, foreign_key: true
      t.references :follow, foreign_key: { to_table: :user }

      t.timestamps
    end
  end
end
