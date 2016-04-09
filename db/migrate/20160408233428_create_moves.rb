class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.string :move

      t.timestamps null: false
    end
  end
end
