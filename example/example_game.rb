root = File.expand_path("../", File.dirname(__FILE__))
require_relative "#{root}/lib/connect_four.rb"


puts "Welcome to connect four"
puts "player 1 enter your name"
player_name_1 = gets.chomp
puts "hello #{player_name_1}!"
puts "player 2 enter your name"
player_name_2 = gets.chomp
puts "hello #{player_name_2}!"

player_1 = ConnectFour::Player.new({color: "X", name: "#{player_name_1}"})
player_2 = ConnectFour::Player.new({color: "O", name: "#{player_name_2}"})
players = [player_1, player_2]
ConnectFour::Game.new(players).play
