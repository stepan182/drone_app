require_relative './engine'
require_relative './gyroscope'
require_relative './orientation_sensor'

class Drone
  attr_accessor :status

  STATUS = ["off", "hovering", "moving"].freeze

  def initialize(engines = 4)
    @status = STATUS[0]
    @engines = []
    1.upto(engines) { @engines << Engine.new }
    @sensor = OrientationSensor.new
    @gyroscope = Gyroscope.new
  end

  def take_off
    engine_is_off = false
    begin
      @engines.each do |engine|
        engine.start
        engine.power = 50
        engine_is_off = true if engine.status == Engine::STATUS[0]
      end
      move_up(10, -10)
    rescue Exception => e
      send_distress_signal e
      land if engine_is_off
    end
  end

  def move_forward(coords)
    @gyroscope.x = @sensor.pitch(coords, 0, 0)
    move_status
  end

  def move_left(coords)
    @gyroscope.y = @sensor.roll(0, coords, 0)
    move_status
  end

  def move_right(coords)
    @gyroscope.y = @sensor.roll(0, coords, 0)
    move_status
  end

  def move_back(coords)
    @gyroscope.x = @sensor.pitch(coords, 0, 0)
    move_status
  end

  def move_up(coords1, coords2)
    @gyroscope.x = @sensor.pitch(coords1, 0, 0)
    @gyroscope.z = @sensor.pitch(0, 0, coords2)
    move_status
  end

  def move_down(coords1, coords2)
    @gyroscope.x = @sensor.pitch(coords1, 0, 0)
    @gyroscope.z = @sensor.pitch(0, 0, coords2)
    move_status
  end

  def stabilize
    @engines.each { |engine| engine.power = 100 }
    @status = STATUS[1]
  end

  def land
    stabilize
    @engines.each { |engine| engine.power = 25 }
    move_down(-10, 10)
  end

  private

    def move_status
      @status = STATUS[2]
    end

    def send_distress_signal(err)
      STDOUT.puts err
    end
end