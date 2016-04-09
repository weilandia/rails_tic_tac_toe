class CreateGameMoves < ActiveRecord::Migration
  def change
    create_table :game_moves do |t|
      t.references :game, index: true, foreign_key: true
      t.references :move, index: true, foreign_key: true
      t.string :player

      t.timestamps null: false
    end
  end
end
