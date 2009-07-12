#!/usr/bin/env ruby1.9
# encoding: utf-8

$LOAD_PATH.unshift(File.dirname(__FILE__) + "/lib").uniq!
require 'game'

# Character mode engage!
original_terminal_settings = `stty -g`
system "stty raw -echo"

begin
  TheGame = GameSingleton.new
  TheGame.run
ensure
  system "stty '#{original_terminal_settings}'"
end
