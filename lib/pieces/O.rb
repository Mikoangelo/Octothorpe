# encoding: utf-8
require 'piece'

class Piece::O < Piece
  color :yellow
  
  up down right left [[0, 0], [1, 0], [0, 1], [1, 1]]
end
