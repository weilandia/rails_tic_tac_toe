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

    expect(@game.win?("o")).to eq("you shouldn't have lost, but you did...")
  end

  scenario "computer blocks user from winning" do
    @game = Game.new({"1"=>"x",
                     "2"=>"x",
                     "3"=>nil,
                     "4"=>nil,
                     "5"=>"o",
                     "6"=>nil,
                     "7"=>nil,
                     "8"=>nil,
                     "9"=>nil})
    @game.make_move({"player" => "o"})

    expect(@game.moves).to eq({"1"=>"x",
                               "2"=>"x",
                               "3"=>"o",
                               "4"=>nil,
                               "5"=>"o",
                               "6"=>nil,
                               "7"=>nil,
                               "8"=>nil,
                               "9"=>nil})

    expect(@game.win?("x")).to eq(false)
  end

  scenario "computer can checnk for forked corners" do
    @game = Game.new({"1"=>"x",
                     "2"=>nil,
                     "3"=>nil,
                     "4"=>nil,
                     "5"=>nil,
                     "6"=>nil,
                     "7"=>nil,
                     "8"=>nil,
                     "9"=>"x"})
    @game.current_player = "o"

    expect(@game.opponent_forked_corners?).to eq(true)

    @game = Game.new({"1"=>nil,
                     "2"=>nil,
                     "3"=>"x",
                     "4"=>nil,
                     "5"=>nil,
                     "6"=>nil,
                     "7"=>"x",
                     "8"=>nil,
                     "9"=>nil})
    @game.current_player = "o"

    expect(@game.opponent_forked_corners?).to eq(true)
  end

  scenario "computer makes smart attacks" do
    @game = Game.new({"1"=>"x",
                     "2"=>nil,
                     "3"=>nil,
                     "4"=>nil,
                     "5"=>"o",
                     "6"=>nil,
                     "7"=>nil,
                     "8"=>nil,
                     "9"=>"x"})
    @game.make_move({"player" => "o"})

    expect(@game.moves).to eq({"1"=>"x",
                               "2"=>nil,
                               "3"=>nil,
                               "4"=>"o",
                               "5"=>"o",
                               "6"=>nil,
                               "7"=>nil,
                               "8"=>nil,
                               "9"=>"x"})

    expect(@game.win?("x")).to eq(false)
  end

  scenario "computer responds to asynchronous play" do
    @game = Game.new({"1"=>"x",
                     "2"=>"o",
                     "3"=>"x",
                     "4"=>nil,
                     "5"=>"x",
                     "6"=>nil,
                     "7"=>"o",
                     "8"=>"x",
                     "9"=>"o"})
    @game.make_move({"player" => "o"})

    expect(@game.moves).to eq({"1"=>"x",
                               "2"=>"o",
                               "3"=>"x",
                               "4"=>"o",
                               "5"=>"x",
                               "6"=>nil,
                               "7"=>"o",
                               "8"=>"x",
                               "9"=>"o"})

    expect(@game.win?("x")).to eq(false)
  end
end
