# encoding: utf-8
class Point
  attr_accessor :x, :y
  
  def initialize x, y
    @x = x
    @y = y
  end
  
  def == other
    @x == other.x and @y == other.y
  end
  
  def + other
    Point.new @x + other.x, @y + other.y
  end
  
  def * other
    # i = imaginary identity.
    # u = other.x; w = other.y
    # 
    # (x + yi) × (u + wi)           ⇔
    # (x + yi) × u + (x + yi) × wi  ⇔
    # xu + yui + xwi + ywii         ⇔
    # xu + (yu + xw)i + yw × i²     ⇔
    # xu + (yu + xw)i - yw          ⇔  (Note that i² = -1)
    # xu - yw + (yu + xw)i          ⇔
    # Have a nice day. :)
    
    Point.new @x * other.x - @y * other.y, @y * other.x + @x * other.y
  end
  
  def inspect; "#<Point #@x + #{@y}i>" end
end
