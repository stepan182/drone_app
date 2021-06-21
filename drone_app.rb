require 'thor'
require_relative './drone'

class DroneApp < Thor
  def initialize(*args)
    super
    @drone = Drone.new(4)
  end

  desc "take_off", "Takes off the drone"
  def take_off
    @drone.take_off
    STDOUT.puts @drone.status
  end

  desc "stabilize", "Stabilizes the Drone"
  def stabilize
    @drone.stabilize
    STDOUT.puts @drone.status
  end

  desc "land", "Lands the Drone"
  def land
    @drone.land
    STDOUT.puts @drone.status
  end
end

DroneApp.start(ARGV)