class Tile

  attr_accessor :neighbors
  attr_writer :bomb, :flagged

  def initialize()
    @bomb = false
    @revealed = false
    @flagged = false
    @neighbors = []
  end

  def bomb?
    @bomb
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
      bomb_count += 1 if neighbor.bomb?
    end

    bomb_count
  end

end

#############################################
# Create basic test functions for Tile class
#############################################
if __FILE__  == $PROGRAM_NAME
  a = Tile.new
  b = Tile.new
  c = Tile.new
  d = Tile.new

  # check bomb, flagged, revealed functions
  a.bomb = true
  b.flagged = true
  c.bomb = true

  p a.bomb?  # => true
  p b.flagged? # => true
  p c.revealed? # => false

  a.neighbors = [b,c,d]
  b.neighbors = [a,c,d]
  c.neighbors = [b,d]

  p a.neighbor_bomb_count # => 1
  p b.neighbor_bomb_count # => 2
  p c.neighbor_bomb_count # => 0
  p d.neighbor_bomb_count # => 0
end
