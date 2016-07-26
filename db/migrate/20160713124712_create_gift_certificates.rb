class CreateGiftCertificates < ActiveRecord::Migration
  def change
    create_table :gift_certificates do |t|
      t.integer :user_id
      t.integer :order_id
      t.integer :amount, :default => 0
      t.string :token, unique: true

      t.timestamps null: false
    end
  end
end
