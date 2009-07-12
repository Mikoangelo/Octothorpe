# encoding: utf-8
module Console
  module_function
  
  def clear; "\033[0m" end
  def bold;  "\033[1m" end
  
  def red;     "\033[31m" end
  def green;   "\033[32m" end
  def yellow;  "\033[33m" end
  def blue;    "\033[34m" end
  def magenta; "\033[35m" end
  def cyan;    "\033[36m" end
  def white;   "\033[37m" end
                  
  def move_up lines; "\033[#{lines}A" end
  def move_down lines; "\033[#{lines}B" end
  def move_right colums; "\033[#{colums}C" end
  def move_left colums; "\033[#{colums}D" end
  def move_down_and_reset_column lines; "\033[#{lines}E" end
  def move_up_and_reset_column lines; "\033[#{lines}F" end
  def move_to_column column; "\033[#{column}G" end
end
