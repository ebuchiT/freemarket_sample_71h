class AddItemConditionToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :item_condition, null: false
  end
end