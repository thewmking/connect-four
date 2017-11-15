module ConnectFour
  class Board
    attr_reader :grid
    def initialize(input = {})
      @grid = input.fetch(:grid, default_grid)
    end

    def get_lowest_in_column(x)
      i = 5
      until i == -1
        if grid[i][x].value.empty?
          cell = grid[i][x]
          return cell
        else
          i -= 1
        end
      end
      return false
    end

    def get_cell(x, y)
      grid[y][x]
    end

    def set_cell(x, value)
      get_lowest_in_column(x).value = value
    end

    def game_over
      return :winner if winner?
      return :draw if draw?
      false
    end

    def formatted_grid
        puts "1 2 3 4 5 6 7"
      grid.each do |row|
        puts row.map { |cell| cell.value.empty? ? "_" : cell.value }.join(" ")
      end
    end

    private

    def default_grid
      Array.new(6) { Array.new(7) {Cell.new}}
    end

    def draw?
      grid.flatten.map { |cell| cell.value }.none_empty?
    end

    def winner?
      winning_positions.each do |winning_position|
        next if winning_position_values(winning_position).all_empty?
        return true if winning_position_values(winning_position).all_same?
      end
      false
    end

    def winning_position_values(winning_position)
      winning_position.map { |cell| cell.value }
    end

    def winning_positions
      horizontals + #rows
      verticals + # columns
      diagonals
    end

    def horizontals
      horizontals = []
      i = 0
      6.times do
        horizontals << [get_cell(0,i), get_cell(1,i), get_cell(2,i), get_cell(3,i)]
        horizontals << [get_cell(1,i), get_cell(2,i), get_cell(3,i), get_cell(4,i)]
        horizontals << [get_cell(2,i), get_cell(3,i), get_cell(4,i), get_cell(5,i)]
        horizontals << [get_cell(3,i), get_cell(4,i), get_cell(5,i), get_cell(6,i)]
        i += 1
      end
      horizontals
    end

    def verticals
      verticals = []
      i = 0
      7.times do
       verticals << [get_cell(i,0), get_cell(i,1), get_cell(i,2), get_cell(i,3)]
       verticals << [get_cell(i,1), get_cell(i,2), get_cell(i,3), get_cell(i,4)]
       verticals << [get_cell(i,2), get_cell(i,3), get_cell(i,4), get_cell(i,5)]
       i += 1
      end
      verticals
    end

    def diagonals
      diagonals = []
      i = 0
      4.times do
        # descending
        diagonals << [get_cell(i,0), get_cell(i+1,1), get_cell(i+2,2), get_cell(i+3,3)]
        diagonals << [get_cell(i,1), get_cell(i+1,2), get_cell(i+2,3), get_cell(i+3,4)]
        diagonals << [get_cell(i,2), get_cell(i+1,3), get_cell(i+2,4), get_cell(i+3,5)]
        # ascending
        diagonals << [get_cell(i,3), get_cell(i+1,2), get_cell(i+2,1), get_cell(i+3,0)]
        diagonals << [get_cell(i,4), get_cell(i+1,3), get_cell(i+2,2), get_cell(i+3,1)]
        diagonals << [get_cell(i,5), get_cell(i+1,4), get_cell(i+2,3), get_cell(i+3,2)]
        i += 1
      end
      diagonals
    end
  end
end
