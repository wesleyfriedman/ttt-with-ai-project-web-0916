require 'pry'
class Game

	WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]]

	attr_accessor :board, :player_1, :player_2, :winner

	def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
		@player_1 = player_1
		@player_2 = player_2
		@board = board
	end

	def self.winning_combos
		WINNING_COMBINATIONS
	end

	def current_player
		board.turn_count.even? ? player_1 : player_2
	end

	def over?
		WIN_COMBINATIONS.each do |win_combination|
			if @board.three_in_a_row?(win_combination)
				return true
			elsif @board.full?
				return true
			end
		end
		return false
	end

	def won?
		WIN_COMBINATIONS.each do |win_combination|
			if @board.three_in_a_row?(win_combination)
				@winner = @board.cells[win_combination.first] == "X" ? player_1 : player_2
				return true
			end
		end
		return false
	end

	def draw?
		!won? && @board.full?
	end

	def winner
		WIN_COMBINATIONS.each do |win_combination|
			return @board.cells[win_combination.first] if @board.three_in_a_row?(win_combination)
		end
		return nil
	end

	def turn
		if current_player == @player_1
			player_1_move = @player_1.move(@board)
			player_1_move = @player_1.move(@board) unless @board.valid_move?(player_1_move)
			@board.cells[player_1_move.to_i - 1] = @player_1.token
			# binding.pry
			return player_1_move
		else
			player_2_move = @player_2.move(@board)
			player_2_move = @player_2.move(@board) unless @board.valid_move?(player_2_move)
			@board.cells[player_2_move.to_i - 1] = @player_2.token
			return player_2_move
		end
	end

	def play
		until over?
			@board.display
			turn
			# binding.pry
			if won? && over?
				player = @board.turn_count.odd? ? player_1 : player_2
				puts "Congratulations #{player.token}!"
				return player.token
				break
			end
			if draw?
				puts "Cats Game!"
				break
			end
		end
		if won? && over?
			player = @winner
			puts "Congratulations #{player.token}!"
			return player.token
		end
		if draw?
			puts "Cats Game!"
		end
	end

end