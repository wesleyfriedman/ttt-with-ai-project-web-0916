class Board

	attr_accessor :cells

	def initialize
		@cells = Array.new(9, " ")
	end

	def reset!
		@cells = Array.new(9, " ")
	end

	def display
		puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
		puts "-"*11
		puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
		puts "-"*11
		puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
	end


	def position(position_number)
		@cells[position_number.to_i - 1]
	end

	def full?
		!@cells.include?(" ")
	end

	def turn_count
		@cells.reject {|cell| cell == " "}.count
	end

	def taken?(position_number)
		position(position_number) != " "
	end

	def valid_move?(position_number)
		!taken?(position_number) && position_number.to_i.between?(1,10)
	end

	def update(position_number, player)
		if valid_move?(position_number)
			@cells[position_number.to_i - 1] = player.token
		end
	end

	def winning_cells(winning_cell_indices)
		winning_cell_indices.map do |index_string|
			@cells[index_string.to_i]
		end
	end

	def three_in_a_row?(winning_cell_indices)
		symbols = winning_cells(winning_cell_indices)
		return false if symbols.include?(" ")
		return false if symbols.uniq.count > 1
		return true
	end

end