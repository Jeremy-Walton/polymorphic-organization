class CreateFeedUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :feed_users do |t|
      t.belongs_to :feed, null: false
      t.belongs_to :user
      t.boolean :active, default: true, null: false
      t.string :role, default: :member, null: false

      t.timestamps
    end
  end
end
