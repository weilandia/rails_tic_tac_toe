require 'rails_helper'

RSpec.describe Game, type: :model do
  scenario "computer plays center if open" do
    @game = Game.new(nil)
    @game.make_move({"move" => "1", "player" => "x"})
    @game.make_move({"player" => "o"})

    expect(@game.center_open?).to eq(false)
    expect(@game.moves).to eq({"1"=>"x",
                               "2"=>nil,
                               "3"=>nil,
                               "4"=>nil,
                               "5"=>"o",
                               "6"=>nil,
                               "7"=>nil,
                               "8"=>nil,
                               "9"=>nil})
  end

  scenario "computer wins if possible" do
    @game = Game.new({"1"=>"x",
                     "2"=>"x",
                     "3"=>"o",
                     "4"=>"x",
                     "5"=>"o",
                     "6"=>nil,
                     "7"=>nil,
                     "8"=>nil,
                     "9"=>nil})
    @game.make_move({"player" => "o"})

    expect(@game.moves).to eq({"1"=>"x",
                               "2"=>"x",
                               "3"=>"o",
                               "4"=>"x",
                               "5"=>"o",
                               "6"=>nil,
                               "7"=>"o",
                               "8"=>nil,
                               "9"=>nil})

    expect(@game.win?("o")).to eq(true)
  end
end
