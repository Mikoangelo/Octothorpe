# encoding: utf-8
require 'board'

Board = BoardSingleton.new 9, 15

class GameSingleton
  attr_reader :score
  
  def initialize
    @score = 0
    @delay = 1.0
  end
  
  def cleared_rows rows
    old_score =  @score
    @score += rows*1000
    
    if old_score.to_s.length < @score.to_s.length
      @delay *= 0.7
    end
  end
  
  def run
    Board.draw
    next_advance = Time.now + @delay
    
    catch :GAMEOVER do
      loop do
        if Board.running?
          delay = next_advance - Time.now
          delay = 0 if delay < 0
        else
          delay = nil
        end
        
        if select [$stdin], nil, nil, delay
          Board.interpret_key $stdin.read 1
        end
        
        if Time.now > next_advance
          Board.advance
          next_advance = Time.now + @delay
        end
        
        Board.draw
      end
    end
    
    print "GAME OVER!\r\n"
  rescue Interrupt
    print "You quitter :(\r\n"
  end
end
