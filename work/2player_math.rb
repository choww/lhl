# players take turn answering addition Qs w/ numbers being randomly generated btwn 1-20
# both players start with 3 lives
# loose a life if wrong answer and game outputs new scores
# game ends when one user looses all their lives and game calcs who won

class MathGame
  attr_reader :player1, :player2, :current_player
  attr_accessor :answer, :num1, :num2

  def initialize
    @player1 = {score: 0, lives: 3}
    @player2 = {score: 0, lives: 3}
  end

  def get_player
    @current_player == @player1 ? "Player 1" : "Player 2"
  end

  def generate_question
    num = Random.new
    @num1 = num.rand(20)
    @num2 = num.rand(20)

    "#{get_player}: What does #{@num1} plus #{@num2} equal?"
  end

  def switch_player 
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def prompt_player
    generate_question
    @answer = gets.chomp
  end

  def game_end?
    @current_player[:lives] == 0
  end

  def declare_winner
  end

  def loose_life(player)
    # change current player's life if needed
    player[:lives] -= 1
    # check if anyone lost all their lives yet (game_end?)
    declare_winner if game_end? 
  end

  def right_answer?
    @answer.to_i == @num1 + @num2
  end

  def change_score
    # if answer is accurate, add score to the right player
    right_answer? ? @current_player[:score] += 1 : loose_life(@current_player)
    # if answer is wrong, subtract a life (loose_life)
  end

  def verify_answer
    # make sure answer is a numeric
    # check answer is accurate (get_score)
    loose_life if !right_answer
    change_score
    switch_player 
    # once answer verified, switch players
  end

  def play
    # REPL all dis
  end

end
