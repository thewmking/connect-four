require_relative "spec_helper"

module ConnectFour
  describe Board do

    context "#initialize" do
      it "intializes the board with a grid" do
        expect { Board.new(grid: "grid")}.to_not raise_error
      end

      it "sets the grid with 6 rows by default" do
        board = Board.new
        expect(board.grid.size).to eql(6)
      end

      it "creates 7 things in each row by default" do
        board = Board.new
        board.grid.each do |row|
          expect(row.size).to eql(7)
        end
      end
    end

    context "#grid" do
      it "returns the grid" do
        board = Board.new(grid: "blah")
        expect(board.grid).to eql("blah")
      end
    end

    context "#get_cell" do
      it "returns the cell based on the (x, y) coordinate" do
        grid = [["", "", ""], ["", "", "something"], ["", "", ""]]
        board = Board.new(grid: grid)
        expect(board.get_cell(2,1)).to eq "something"
      end
    end

    context "#get_lowest_in_column" do
      it "returns the bottom cell of the column based on the x coordinate when array is empty" do
        Cat = Struct.new(:value)
        grid = Array.new(6) { Array.new(7) {Cat.new("")}}
        board = Board.new(grid: grid)
        expect(board.get_lowest_in_column(1).value).to eql("")
      end

      it "returns the lowest empty cell of the column based on the x coordinate when column has values" do
        grid = Array.new(6) { Array.new(7) {Cat.new("")}}
        grid[5][5].value = "X"
        board = Board.new(grid: grid)
        expect(board.get_lowest_in_column(5).value).to eql("")
      end

      it "returns false if there is no space in the column" do
        grid = Array.new(6) { Array.new(7) {Cat.new("")}}
        grid[5][5].value = "X"
        grid[4][5].value = "X"
        grid[3][5].value = "X"
        grid[2][5].value = "X"
        grid[1][5].value = "X"
        grid[0][5].value = "X"
        board = Board.new(grid: grid)
        expect(board.get_lowest_in_column(5)).to be false
      end
    end

    context "#set_cell" do
      it "updates the value of the cell object at the lowest spot of the given column" do
        grid = Array.new(6) { Array.new(7) {Cat.new("")}}
        board = Board.new(grid: grid)
        board.set_cell(5, "X")
        board.set_cell(5, "0")
        expect(board.get_cell(5,5).value).to eql("X")
        expect(board.get_cell(5,4).value).to eql("0")
      end
    end

TestCell = Struct.new(:value)
let(:x_cell) { TestCell.new("X")}
let(:o_cell) { TestCell.new("O")}
let(:empty)  { TestCell.new }

  context "#game_over" do
    it "returns :winner if winner? is true" do
      board = Board.new
      board.stub(:winner?) { true }
      expect(board.game_over).to eql(:winner)
    end

    it "returns :draw if winner? is false and draw? is true" do
      board = Board.new
      board.stub(:winner?) { false }
      board.stub(:draw?) { true }
      expect(board.game_over).to eql(:draw)
    end

    it "returns false if winner? is false and draw? is false" do
      board = Board.new
      board.stub(:winner?) { false }
      board.stub(:draw?) { false }
      expect(board.game_over).to be false
    end

    it "returns :winner when there are 4 of the same objects in a row" do
      grid = [
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, x_cell, x_cell, x_cell, x_cell],
        [x_cell, o_cell, x_cell, o_cell, x_cell, o_cell, x_cell]
      ]
      board = Board.new(grid: grid)
      expect(board.game_over).to eql(:winner)
    end

    it "returns :winner when there are 4 of the same objects in a column" do
      grid = [
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty],
        [x_cell, empty, empty, empty, empty, empty, empty],
        [x_cell, empty, empty, empty, empty, empty, empty],
        [x_cell, empty, empty, empty, x_cell, x_cell, x_cell],
        [x_cell, o_cell, x_cell, o_cell, x_cell, o_cell, x_cell]
      ]
      board = Board.new(grid: grid)
      expect(board.game_over).to eql(:winner)
    end

    it "returns :winner when there are 4 of the same objects in a diagonal sequence" do
      grid = [
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, x_cell, empty, empty, empty],
        [empty, empty, x_cell, o_cell, empty, empty, empty],
        [empty, x_cell, o_cell, x_cell, x_cell, x_cell, x_cell],
        [x_cell, o_cell, x_cell, o_cell, x_cell, o_cell, x_cell]
      ]
      board = Board.new(grid: grid)
      expect(board.game_over).to eql(:winner)
    end

    it "returns :draw when all spaces on the board are taken but there is no winner" do
      grid = [
        [o_cell, o_cell, x_cell, x_cell, o_cell, o_cell, x_cell],
        [x_cell, x_cell, o_cell, o_cell, x_cell, x_cell, o_cell],
        [o_cell, o_cell, x_cell, x_cell, o_cell, o_cell, x_cell],
        [x_cell, x_cell, o_cell, o_cell, x_cell, x_cell, o_cell],
        [o_cell, o_cell, x_cell, o_cell, x_cell, o_cell, x_cell],
        [x_cell, o_cell, x_cell, o_cell, x_cell, o_cell, x_cell]
      ]
      board = Board.new(grid: grid)
      expect(board.game_over).to eql(:draw)
    end

    it "returns false when there is no winner or draw" do
      grid = [
        [empty, empty, empty, empty, empty, o_cell, x_cell],
        [x_cell, x_cell, o_cell, o_cell, x_cell, x_cell, o_cell],
        [o_cell, o_cell, x_cell, x_cell, o_cell, o_cell, x_cell],
        [x_cell, x_cell, o_cell, o_cell, x_cell, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, o_cell, x_cell, empty, x_cell]
      ]
      board = Board.new(grid: grid)
      expect(board.game_over).to be false
    end

  end


  end
end
