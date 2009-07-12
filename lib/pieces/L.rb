# encoding: utf-8
require 'piece'

class Piece::L < Piece
  color :white
  
  up    [[0, 0], [1,  0], [0,   1], [0,  2]]
  right [[0, 0], [1,  0], [2,   0], [0, -1]]
  down  [[0, 0], [-1, 0], [0,  -1], [0, -2]]
  left  [[0, 0], [-1, 0], [-2,  0], [0,  1]]
end
