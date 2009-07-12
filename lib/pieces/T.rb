# encoding: utf-8
require 'piece'

class Piece::T < Piece
  color :magenta
  
  up    [[0, 0], [-1, 0], [1,  0], [0,  1]]
  right [[0, 0], [0, -1], [1,  0], [0,  1]]
  down  [[0, 0], [-1, 0], [1,  0], [0, -1]]
  left  [[0, 0], [-1, 0], [0, -1], [0,  1]]
end
