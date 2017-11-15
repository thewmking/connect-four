require "spec_helper"

module ConnectFour
  describe Game do

    let (:jareth) { Player.new({color: "X", name: "Jareth"}) }
    let (:tony)   { Player.new({color: "0", name: "Tony"}) }

    context "#initialize" do
      it "randomly selects a current_player" do
        Array.any_instance.stub(:shuffle) { [jareth, tony] }
        game = Game.new([tony, jareth])
        expect(game.current_player).to eql(jareth)
      end

      it "randomly selects another player" do
        Array.any_instance.stub(:shuffle) { [jareth, tony] }
        game = Game.new([tony, jareth])
        expect(game.other_player).to eql(tony)
      end
    end

    context "#switch_players" do
      it "will set @current_player to @other_player" do
        game = Game.new([tony, jareth])
        other_player = game.other_player
        game.switch_players
        expect(game.current_player).to eql(other_player)
      end

      it "will set @other_player to @current_player" do
        game = Game.new([tony, jareth])
        current_player = game.current_player
        game.switch_players
        expect(game.other_player).to eql(current_player)
      end
    end

    context "#move_prompt" do
      it "asks the player to make a move" do
        game = Game.new([tony, jareth])
        game.stub(:current_player) {tony}
        expected = "Tony: Enter a column number to make your move"
        expect(game.move_prompt).to eql(expected)
      end
    end

    context "#human_move_to_coordinate" do
      it "converts human_move of '1' to 0" do
        game = Game.new([tony, jareth])
        expect(game.human_move_to_coordinate("1")).to eql(0)
      end
    end

    context "#game_over_message" do
      it "returns '{current_player.name} won' if board shows a winner" do
        game = Game.new([tony, jareth])
        game.stub(:current_player) { tony }
        game.board.stub(:game_over) { :winner }
        expect(game.game_over_message).to eql("Tony won!")
      end

      it "returns 'the game ended in a tie' if board shows a draw" do
        game = Game.new([tony, jareth])
        game.stub(:current_player) { tony }
        game.board.stub(:game_over) { :draw }
        expect(game.game_over_message).to eql("The game ended in a tie")
      end
    end

  end
end
