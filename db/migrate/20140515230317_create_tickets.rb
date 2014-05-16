class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :event
      t.string :description
      t.references :user, index: true

      t.timestamps
    end
  end
end
