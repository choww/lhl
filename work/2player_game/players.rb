class Player
  attr_accessor :name, :score, :lives

  def initialize
    @lives = 3
    @score = 0
  end

  def reset_stats
    @lives = 3
    @score = 0
  end

  def no_lives?
    @lives == 0
  end

  def loose_life
    @lives -= 1
  end
end