module Players

	class Human < Player

		def move(board)
			puts "move?"
			gets.chomp
		end

	end
end