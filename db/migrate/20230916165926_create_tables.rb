class CreateTables < ActiveRecord::Migration[7.0]
  def change
    create_table :seats do |t|
      t.string :state
      t.integer :seat_number
      t.string :row

      t.timestamps
    end

    create_table :reservations do |t|
      t.references :seat, foreign_key: true
      t.string :reservation_name
      t.string :reservation_email

      t.timestamps
    end
  end
end
