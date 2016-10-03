module Players

    class Computer < Player

        def move(board)

        end

        def winning_combos
            Game.winning_combos
        end

        def calc_best_move(player, board)

        end

        def block_win(self_combo_hash, opponent_combo_hash, board)
            intersect_2_2 = self_combo_hash[:2] & opponent_combo_hash[:2]
            intersect_1_2 = self_combo_hash[:1] & opponent_combo_hash[:2]
            if self_combo_hash[:2].length > 0
                intersect_2_2.each do |index|
                    return index if board.cells[index.to_i -1] == " "
                end
            elsif self_combo_hash[:1].length > 0
                intersect_1_2.each do |index|
                    return index if board.cells[index.to_i -1] == " "
                end
            else
                 board.cells.each_with_index do |symbols, index|
                    return (index +1).to_s if board.cells[index.to_i -1] == " "
                end
            end
        end

        def block_move

        end

        def gather_winning_combos(player, board)
            players_used_spaces = used_spaces(player, board)
            winning_combo_overlap = winning_combo & players_used_spaces
            winning_combos.each_with_object({1:[],2:[]}) do |winning_combo, winning_combo_hash|
                if (winning_combo_overlap).length = 1
                    winning_combo_hash[:1] << winning_combo
                elsif (winning_combo_overlap).length = 2
                    winning_combo_hash[:2] << winning_combo
                end
            end
        end

        def winning_move?(player, board)
            winning_combo_hash = gather_winning_combos(player, board)
            winning_combo_hash[:2].length > 0
        end

        def used_spaces(player, board)
            board.map.with_index do |space, space_index|
                (space_index + 1).to_s if space == player.token
            end.compact
        end

    end
end