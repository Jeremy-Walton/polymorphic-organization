class CreateSubscriptions < ActiveRecord::Migration[8.1]
  def change
    create_table :subscriptions do |t|
      t.references :subscriber, polymorphic: true, null: false
      t.references :subscribable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
