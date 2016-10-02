module Players

	class Computer < Player

		def move(board)
			(1..9).each do |move|
				return move.to_s if board.valid_move?(move)
			end
		end

	end
end