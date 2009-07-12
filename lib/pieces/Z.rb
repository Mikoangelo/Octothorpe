# encoding: utf-8
require 'piece'

class Piece::Z < Piece
  color :red
  
  up down    [[0, 0], [-1, 0], [0,  1], [-1, -1]]
  right left [[0, 0], [1, -1], [-1, 0], [0,  -1]]
end
