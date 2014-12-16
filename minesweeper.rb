class Tile

  attr_accessor :neighbors

  def initialize()
    @has_bomb = false
    @revealed = false
    @flagged = false
    @neighbors = []
  end

  def has_bomb?
    @has_bomb
  end

  def revealed?
    @revealed
  end

  def flagged?
    @flagged
  end

  def neighbor_bomb_count
    bomb_count = 0
    neighbors.each do |neighbor|
      bomb_count += 1 if neighbor.has_bomb?
    end

    bomb_count
  end
  



end
