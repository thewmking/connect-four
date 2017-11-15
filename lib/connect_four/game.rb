module ConnectFour
  class Game
    attr_reader :players, :board, :current_player, :other_player
    def initialize(players, board = Board.new)
      @players = players
      @board = board
      @current_player, @other_player = players.shuffle
    end

    def switch_players
      @current_player, @other_player = @other_player, @current_player
    end

    def move_prompt
      "#{current_player.name}: Enter a column number to make your move"
    end

    def get_move(human_move = gets.chomp)
      human_move
    end

    def game_over_message
      return "#{current_player.name} won!" if board.game_over == :winner
      return "The game ended in a tie" if board.game_over == :draw
    end

    def move_flow
      puts ""
      puts move_prompt
      x = get_move
      until (1..7).include? x.to_i
        puts ""
        puts move_prompt + "[Your entry was invalid]"
        x = get_move
      end
      x = human_move_to_coordinate(x)
      if board.get_lowest_in_column(x) != false
        board.set_cell(x, current_player.color)
      else
        puts "That column is full. Try a different column."
        board.formatted_grid
        move_flow
      end
    end

    def play
      puts "#{current_player.name} has randomly been selected as the first player"
      while true
        board.formatted_grid
        move_flow
        if board.game_over
          puts game_over_message
          board.formatted_grid
          return
        else
          switch_players
        end
      end
    end


    def human_move_to_coordinate(human_move)
      mapping = {
        "1" => 0,
        "2" => 1,
        "3" => 2,
        "4" => 3,
        "5" => 4,
        "6" => 5,
        "7" => 6
      }
      mapping[human_move]
    end

  end
end
