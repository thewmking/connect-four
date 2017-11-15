require_relative "spec_helper"

module ConnectFour
  describe Player do
    context "#initialize" do
      it "raises an exception when initalized with {}" do
        expect { Player.new({})}.to raise_error
      end
      it "does not raise error when initalized with valid input" do
        input = { color: "X", name: "Name"}
        expect { Player.new(input) }.to_not raise_error
      end
    end

    context "#color" do
      it "returns the player's color" do
        input = { color: "X", name: "Name"}
        player = Player.new(input)
        expect(player.color).to eql("X")
      end
    end

    context "#name" do
      it "returns the player's name" do
        input = { color: "X", name: "Name"}
        player = Player.new(input)
        expect(player.name).to eql("Name")
      end
    end

  end

end
