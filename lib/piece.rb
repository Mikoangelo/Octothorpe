# encoding: utf-8
require 'point'
require 'console'

class Piece
  attr_reader :shape
  attr_accessor :orientation, :position
  
  Orientations = [:up, :right, :down, :left]
  Pieces = {}
  
  class << self
    def new shape, *args
      if self == Piece
        raise "Invalid shape, yo! #{shape.inspect}" unless Pieces.keys.include? shape
        Pieces[shape].new shape, *args
      else
        super
      end
    end
    
    def inherited klass
      Pieces[klass.name[/[^:]+$/].to_sym] = klass
      klass.instance_variable_set :@cell_coverage, {}
    end
    
    def color_of_shape shape
      Pieces[shape].color
    end
    
    attr_reader :cell_coverage
    
    def color color = nil
      if color
        @color = Console.send color
      else
        @color
      end
    end
    
  protected
    
    Orientations.each do |direction|
      define_method direction do |cells|
        @cell_coverage[direction] = cells
      end
    end
  end
  
  def initialize shape, position = Point.new(0,0)
    @shape       = shape
    @orientation = :up
    @position    = position
  end
  
  def covers? point
    covered_cells.include? point
  end
  
  def covered_cells orientation = @orientation
    self.class.cell_coverage[orientation].map do |(x, y)|
      @position + Point.new(x, y)
    end
  end
  
  def color; self.class.color end
  
  def can_move_with_delta? delta
    covered_cells.all? { |cell| Board.occupiable? cell + delta }
  end
  def can_move_down?;  can_move_with_delta? Point.new(0, -1) end
  def can_move_left?;  can_move_with_delta? Point.new(-1, 0) end
  def can_move_right?; can_move_with_delta? Point.new(1,  0) end
  
  def can_rotate_to_orientation? orientation
    covered_cells(orientation).all? &Board.method(:occupiable?)
  end
  def can_rotate_clockwise?
    desired_orientation = Orientations[(Orientations.index(orientation) + 1) % Orientations.length]
    can_rotate_to_orientation? desired_orientation
  end
  def can_rotate_counterclockwise?
    desired_orientation = Orientations[(Orientations.index(orientation) - 1) % Orientations.length]
    can_rotate_to_orientation? desired_orientation
  end
  
  def rotate_clockwise
    @orientation = Orientations[(Orientations.index(orientation) + 1) % Orientations.length]
  end
  def rotate_counterclockwise
    @orientation = Orientations[(Orientations.index(orientation) - 1) % Orientations.length]
  end
  
  def x; @position.x end
  def y; @position.y end
  def x= x; @position.x = x end
  def y= y; @position.y = y end
end

# Let's load the suckers!
Dir[File.dirname(__FILE__) + '/pieces/*'].each &method(:require)
