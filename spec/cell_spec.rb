require "spec_helper"

module ConnectFour
  describe Cell do
    context "#initialize" do
      it "is initialized with the given value by default" do
        cell = Cell.new("X")
        expect(cell.value).to eq 'X'
      end
    end
  end

end
