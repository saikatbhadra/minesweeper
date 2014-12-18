class Tile
  attr_writer :revealed, :flagged
  attr_accessor :neighbors, :bomb, :position

  def initialize()
    @bomb = false
    @revealed = false
    @flagged = false
    @position = nil
    @neighbors = []
  end

  def inspect
    inspect_hash = {
      bomb: bomb?,
      flagged: flagged?,
      revealed: revealed?,
      position: position,
      neighbors: neighbors.map(&:position)
    }.inspect
  end

  def bomb?
    @bomb
  end

  def revealed?
    @revealed
  end

  def reveal
    if revealed?
      p self
      raise "Already revealed!"
    end
    self.revealed = true

    if !bomb? && self.neighbor_bomb_count == 0
      neighbors.each { |el| el.reveal unless el.flagged? || el.revealed? }
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
