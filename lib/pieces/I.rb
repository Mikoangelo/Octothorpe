# encoding: utf-8
require 'piece'

class Piece::I < Piece
  color :cyan
  
  up down    [[0, 0], [-1, 0], [1, 0], [2, 0]]
  right left [[0, 0], [0, -1], [0, 1], [0, 2]]
end
