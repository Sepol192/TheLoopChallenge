class AddSessionTokenToSeats < ActiveRecord::Migration[7.0]
  def change
    add_column :seats, :session_token, :string
  end
end
