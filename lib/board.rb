# encoding: utf-8
# Origin is at bottom left, increasing north-east.

require 'piece'

class BoardSingleton
  def initialize width, height
    @width            = width
    @height           = height
    @cells            = Array.new(@height) { Array.new(@width) }
    @current_key      = nil
    @running          = true
    @has_printed_once = false
    
    generate_piece
  end
  
  def running?
    @running
  end
  
  def occupiable? cell
    legal_position? cell and not occupied? cell
  end
  
  def occupied? cell
    @cells[cell.y][cell.x] if legal_position? cell and cell.y < @height
  end
  
  def legal_position? cell
    # Intentionally allows placement above top.
    (0...@width).include?(cell.x) and cell.y >= 0
  end
  
  def advance
    if @current_piece.can_move_down?
      @current_piece.y -= 1
    else
      absorb_piece
    end
  end
  
  def interpret_key key
    @current_key = key
    return unless key == 'p' or running?
    
    case key
    when 'h'
      @current_piece.x -= 1 if @current_piece.can_move_left?
    when 'l'
      @current_piece.x += 1 if @current_piece.can_move_right?
    when 'j'
      @current_piece.rotate_counterclockwise if @current_piece.can_rotate_counterclockwise?
    when 'k'
      @current_piece.rotate_clockwise if @current_piece.can_rotate_clockwise?
    when 'n'
      advance
    when ' '
      hard_drop
    when 'p'
      @running = !@running
    when 'q'
      raise Interrupt
    end
  end
  
  def draw
    if @has_printed_once
      print Console.move_up_and_reset_column visual_height
    else
      @has_printed_once = true
    end
    
    print horizontal_border + "\r\n"
    
    @cells.reverse.each_with_index do |row, y|
      y = @height - y - 1 # Make sure we count in the right direction.
      print "|"
      row.each_with_index do |cell, x|
        if cell
          print Piece.color_of_shape(cell) + "#"
        elsif @current_piece.covers? Point.new(x, y)
          print @current_piece.color + Console.bold + "#" + Console.clear
        else
          print " "
        end
      end
      print Console.clear + "|"
      print " #{Console.bold}#{TheGame.score}#{Console.clear} points" if y == @height - 1
      print "\r\n"
    end
    
    print horizontal_border + "\r\n"
  end
  
protected
  
  def hard_drop
    @current_piece.y -= 1 while @current_piece.can_move_down?
    absorb_piece
  end
  
  def absorb_piece
    @current_piece.covered_cells.each do |cell|
      @cells[cell.y][cell.x] = @current_piece.shape if legal_position? cell and cell.y < @height
    end
    
    clear_full_rows
    generate_piece
  end
  
  def clear_full_rows
    cleared_rows = @cells.inject 0 do |count, row|
      count + (row.all? ? 1 : 0)
    end
    if cleared_rows > 0
      @cells = @cells.reject { |r| r.all? } + Array.new(cleared_rows) { Array.new(@width) }
      TheGame.cleared_rows cleared_rows
    end
  end
  
  def generate_piece
    @current_piece = Piece.new Piece::Pieces.keys.shuffle.first, Point.new(@width / 2, @height - 1)
    throw :GAMEOVER if @current_piece.covered_cells.any? &method(:occupied?)
  end
  
  def visual_height
    @height + 2
  end
  
  def horizontal_border
    "+" + "-" * @width + "+"
  end
end
