class Unit
  attr_reader :health_points, :attack_power
  def initialize(health_points, attack_power)
    @health_points = health_points
    @attack_power = attack_power
  end
  
  def attack!(enemy)
    enemy.damage(attack_power)
  end

  def damage(attack)
    @health_points -= attack
  end
end
