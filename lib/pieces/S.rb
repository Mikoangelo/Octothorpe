# encoding: utf-8
require 'piece'

class Piece::S < Piece
  color :green
  
  up down    [[0, 0], [1,  0], [1, -1], [0, 1]]
  right left [[0, 0], [-1, 0], [1,  1], [0, 1]]
end
