require './players.rb'
# How game works: 
# 2 Players take turn answering math questions with randomly generated numbers between 1-20
# Both players start with 3 lives
# Loose a life if wrong answer and game outputs new scores
# Game ends when one user looses all their lives and game calcs who won based on their scores

class MathGame
  attr_reader :player1, :player2, :current_player
  attr_reader :game_ongoing, :restart_game
  attr_reader :num1, :num2, :operator, :correct_answer
  attr_accessor :answer

  def initialize
    @player1 = Player.new
    @player2 = Player.new
    @current_player = @player1
  end

  ##### BASIC GAME SETUP/INFO #####

  # color codes are Linux-specific--may or may not work on other OSes
  def colorize(str, color)
    colors = {red: 31, green: 32, blue: 34}
    "\e[#{colors[color]}m #{str}\e[0m"
  end

  # set/reset lives & scores but not wins/losses
  def initialize_stats
    @game_ongoing = true
    @player1.reset_stats
    @player2.reset_stats
  end

  def get_player 
    @current_player.name
  end

  def switch_player 
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def ask_player_name
    puts "Player 1: Enter your name:"
    @player1.name = gets.chomp
    puts "Player 2: Enter your name:"
    @player2.name = gets.chomp
  end

  # side effect: change random numbers to floats for division 
  def add_decimals
    @num1 = @num1.to_f
    @num2 = @num2.to_f
  end

  def division?
    @operator == "/"
  end

  def generate_question
    num = Random.new
    # generate random numbers between 1-20
    @num1 = 1 + num.rand(20)
    @num2 = 1 + num.rand(20)

    operator = num.rand(4)
    operators = ["+", "-", "*", "/"]
    @operator = operators[operator]
    add_decimals if division?

    "#{get_player}: What does #{@num1} #{@operator} #{@num2} equal?"
  end

  def prompt_player
    puts colorize(generate_question, :blue)
    puts "(Round to 2 decimal places where appropriate for division questions)"
    @answer = gets.chomp
  end

  ##### CHECK ANSWERS & UPDATE SCORE/LIVES #####

  def right_answer?
    @correct_answer = @num1.send(@operator, @num2)
    # round answer to 2 decimal places if division
    if division? 
      @correct_answer = @correct_answer.round(2) 
      @answer = @answer.to_f
    else
      @answer = @answer.to_i
    end

    @answer == @correct_answer
  end

  # side effect: update player score or lives depending on if answer is right/wrong
  def verify_answer
    right_answer? ? @current_player.score += 1 : @current_player.loose_life
  end

  ##### GAME OUTCOMES #####

  def print_question_outcome
    # wrong answers printed in red
    wrong = "WRONG! The correct answer is #{@correct_answer}" 
    correct = "CORRECT!"
    puts right_answer? ? colorize(correct, :green) : colorize(wrong, :red)
  end

  # side effect: prints scores & lives for each player 
  def print_stats
    puts "Player 1 (#{@player1.name})"
    puts "\tScore: #{@player1.score}"
    puts "\tLives left: #{@player1.lives}"

    puts "Player 2 (#{@player2.name})"
    puts "\tScore: #{@player2.score}"
    puts "\tLives left: #{@player2.lives}"

    declare_winner if @current_player.no_lives? 
  end

  # side effect: changes @game_ongoing value to false
  def declare_winner
    winner = @player1.score > @player2.score ? @player1.name : @player2.name
    @game_ongoing = false

    draw? ? "*** It's a draw! ***" : "*** #{winner} wins! ***" 
  end

  ##### CHECK IF GAME OVER #####

  def end_game
    @game_ongoing = false
  end

  def draw?
    @player1.score == @player2.score
  end

  def restart_or_not
    puts "Play again? (Enter 'yes' to restart, anything else to quit)"
    @restart = gets.chomp
  end

  def keeping_playing?
    @restart.downcase == "yes"
  end

  ##### REPLs #####

  # REPL for each round
  def play
    begin 
      prompt_player
      verify_answer

      print_question_outcome
      print_stats

      switch_player 
      get_player
    end while @game_ongoing

    puts "\n"
    puts colorize(declare_winner, :green)
  end

  # game REPL
  def start
    ask_player_name

    begin 
      initialize_stats 
      play
      restart_or_not
    end while keeping_playing? 

    puts colorize("Bye!", :blue)
  end
end

game = MathGame.new
game.start
