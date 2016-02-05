# players take turn answering addition Qs w/ numbers being randomly generated btwn 1-20
# both players start with 3 lives
# loose a life if wrong answer and game outputs new scores
# game ends when one user looses all their lives and game calcs who won

class MathGame
  attr_reader :player1, :player2, :current_player, :game_ongoing
  attr_accessor :answer, :num1, :num2

  def initialize
    @player1 = {score: 0, lives: 3}
    @player2 = {score: 0, lives: 3}
    @current_player = @player1
    @game_ongoing = true
  end

  def get_player
    @current_player == @player1 ? "Player 1" : "Player 2"
  end

  def switch_player 
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def generate_question
    num = Random.new
    @num1 = num.rand(20)
    @num2 = num.rand(20)

    "#{get_player}: What does #{@num1} plus #{@num2} equal?"
  end

  def prompt_player
    puts generate_question
    @answer = gets.chomp
  end

  def game_end?
    @current_player[:lives] == 0
  end

  def print_lives
    puts "Player1 lives left: #{@player1[:lives]}"
    puts "Player2 lives left: #{@player2[:lives]}"
  end

  def print_stats
    puts "Player 1"
    puts "\tScore: #{@player1[:score]}"
    puts "\tLives left: #{@player1[:lives]}"

    puts "Player 2"
    puts "\tScore: #{@player2[:score]}"
    puts "\tLives left: #{@player2[:lives]}"
  end

  def declare_winner
    winner = @player1[:score] > @player2[:score] ? "Player 1" : "Player 2"
    draw = @player1[:score] == @player2[:score]
    @game_ongoing = false

    draw ? "It's a draw!" : "#{winner} wins!" 
  end

  def loose_life(player)
    player[:lives] -= 1
    declare_winner if game_end? 
  end

  def right_answer?
    @answer.to_i == @num1 + @num2
  end

  def verify_answer
    right_answer? ? @current_player[:score] += 1 : loose_life(@current_player)
  end

  def play
    begin 
      prompt_player
      verify_answer
      print_stats
      switch_player 
    end while @game_ongoing

    puts declare_winner
    puts "Final score: "
    print_stats
  end
end

game = MathGame.new
game.play
