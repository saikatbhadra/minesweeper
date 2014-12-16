class Tile

  attr_accessor :neighbors
  attr_writer :bomb, :flagged, :revealed

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

  def reveal
    self.revealed = true

    if !bomb? && self.neighbor_bomb_count == 0
      neighbors.each { |el| el.reveal }
    end
  end

  def flagged?
    @flagged
  end

  def display_val
    if revealed?
      if bomb?
        'B'
      else
        if neighbor_bomb_count > 0
          neighbor_bomb_count.to_s
        else
          '_'
        end
      end
    elsif flagged?
      'F'
    else
      '*'
    end
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

  a.bomb = true
  b.flagged = true
  c.bomb = true

  # setter/getters
  p a.bomb?  # => true
  p b.flagged? # => true
  p c.revealed? # => false

  a.neighbors = [b,c,d]
  b.neighbors = [a,c,d]
  c.neighbors = [b,d]

  # neighbor_bomb_count

  p a.neighbor_bomb_count # => 1
  p b.neighbor_bomb_count # => 2
  p c.neighbor_bomb_count # => 0
  p d.neighbor_bomb_count # => 0

  # display_valu
  x = Tile.new
  x.revealed = true
  x.bomb = true
  p x.display_val # => 'B'

  b.flagged = false
  b.revealed = true
  p b.display_val # => '2'

  d.revealed = true
  p d.display_val # => '_'

  d.revealed = true
  p d.display_val # => '_'

  a.revealed = false
  p a.display_val # => '*'
end
