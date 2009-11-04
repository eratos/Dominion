require 'logger'
require 'singleton'

class Log
  include Singleton
  attr_accessor :log
  def initialize
    @log = Logger.new("game.log")
    @log.level = Logger::DEBUG
    @log.datetime_format = "%H:%M:%S"
  end
end