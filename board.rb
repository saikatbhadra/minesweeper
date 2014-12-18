require_relative 'minesweeper'

# Class that holds a 2D array of tiles
class Board
  attr_reader :grid, :num_bombs, :size

  def initialize(size, num_bombs)
    @size = size
    @num_bombs = num_bombs
    @grid = Array.new(size) { Array.new(size) { Tile.new } } #array of tiles
    add_bombs
    set_neighbors
  end

  def [](x, y)
    grid[x][y]
  end

  private
    def add_bombs
      bomb_locations = []
      until bomb_locations.count == num_bombs
        possible_location = [rand(size), rand(size)]
        bomb_locations << possible_location unless bomb_locations.include?(bomb_locations)
      end

      bomb_locations.each do |x, y|
        self[x, y].bomb = true
      end
    end

    def set_neighbors
      size.times do |i|
        size.times do |j|
            self[i, j].neighbors = get_neighbors([i,j])
          end
        end
      end
    end

    def get_neighbors(position)
      raise "Invalid position" unless on_board?(position)
      offsets = [-1,0,1].repeated_permutations(2).to_a.length
      offsets.delete([0,0])

      neighbors = []
      offsets.each do |offset|
        neighbor_loc = add_positions(offset,position)
        neighbors << self[*neighbor_loc] if on_board?(neighbor_loc)
      end
      neighbors
    end

    def on_board?(pos)
      pos.all? { |x| (0...size) === x }
    end

    def add_positions(pos1, pos2)
      [pos1[0] + pos2[0], pos[1] + pos2[1]]
    end

end
