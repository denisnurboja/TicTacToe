class Player
	attr_accessor :name, :moves, :score

	def initialize(name)
		@name = name
		@moves
		@score = 0
	end

	def prompt(letter, taken_moves)
		puts "#{@name}, where would you like to place your #{letter}? Enter a number between 1 and 9:"
		next_move = gets.chomp.to_i

		while move_taken?(next_move, taken_moves) || invalid_move?(next_move)
			if move_taken?(next_move, taken_moves)
				puts "#{@name}, that move is already taken! Try again:"
				next_move = gets.chomp.to_i
			end
			if invalid_move?(next_move)
				puts "#{@name}, please enter a number that is between 1 and 9:"
				next_move = gets.chomp.to_i
			end
		end

		@moves.push(next_move)
		return next_move
	end
end

class Game
	attr_accessor :board, :taken_moves

	def initialize
		@board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
		@taken_moves = []
	end

	def display
		puts "Here is the current game board:"
		puts "#{@board[0]}|#{@board[1]}|#{@board[2]}\n#{@board[3]}|#{@board[4]}|#{@board[5]}\n#{@board[6]}|#{@board[7]}|#{@board[8]}"
	end

	def update(number, letter)
		@taken_moves.push(number)
		for i in 0...@board.length
			if number == @board[i]
				@board[i] = letter
			end
		end
	end
end

def invalid_move?(move)
	return move != 1 && move != 2 && move != 3 && move != 4 && move != 5 && move != 6 && move != 7 && move != 8 && move != 9
end

def move_taken?(move, taken_moves)
	move_taken = false
	taken_moves.each do |item|
		if move == item
			move_taken = true
		end
	end
	return move_taken
end

def has_player_won?(player, winning_combos)
	winning_combos.each do |array|
		if player.moves.include?(array[0]) && player.moves.include?(array[1]) && player.moves.include?(array[2])
			puts "Game over: #{player.name} wins!"
			player.score += 1
			return true
		end
	end
	return false
end

def has_nobody_won?(game)
	if game.taken_moves.length >= game.board.length
		puts "Game over: nobody wins!"
		return true
	else
		return false
	end
end

def start_game?
	puts "Do you want to play Tic Tac Toe? Enter YES or NO:"
	input = gets.chomp.downcase
	while input != "yes" && input != "no"
		puts "Please enter YES or NO:"
		input = gets.chomp.downcase
	end
	return input == "yes"
end

def play_game(player1, player2)
	game = Game.new
	winning_combos = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
	player1.moves = []
	player2.moves = []

	game_in_progress = true
	game.display

	while game_in_progress
		if game_in_progress
			game.update(player1.prompt("X", game.taken_moves), "X")
			game.display

			if has_player_won?(player1, winning_combos) || has_nobody_won?(game)
				game_in_progress = false
			end
		end

		if game_in_progress
			game.update(player2.prompt("O", game.taken_moves), "O")
			game.display

			if has_player_won?(player2, winning_combos) || has_nobody_won?(game)
				game_in_progress = false
			end
		end
	end

	puts "The current scores are:"
	puts "#{player1.name}: #{player1.score}, #{player2.name}: #{player2.score}"
end

def start_sequence
	puts "What is the name of the first player?"
	player1 = Player.new(gets.chomp)

	puts "What is the name of the second player?"
	player2 = Player.new(gets.chomp)

	while start_game?
		play_game(player1, player2)
	end
end

start_sequence