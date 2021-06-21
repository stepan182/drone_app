require_relative './orientation_sensor'

class Gyroscope
  attr_accessor :x, :y, :z, :last_x, :last_y, :k

  def initialize
    @x = 0
    @y = 0
    @z = 0
    @last_x = 0
    @last_y = 0
    @k = 0.30
    @sensor = OrientationSensor.new
  end

  def velocity
    gyro_x = (@x / 131.0).round(1)
    gyro_y = (@y / 131.0).round(1)
    gyro_z = (@z / 131.0).round(1)
    acceleration_x = gyro_x / 16384.0
    acceleration_y = gyro_y / 16384.0
    acceleration_z = gyro_z / 16384.0
    rotation_x = @k * @sensor.pitch(acceleration_x, acceleration_y, acceleration_z) + (1-@k) * @last_x
    rotation_y = @k * @sensor.roll(acceleration_x, acceleration_y, acceleration_z) + (1-@k) * @last_y
    @last_x = rotation_x
    @last_y = rotation_y
    "#{rotation_x.round(1)} #{rotation_y.round(1)}"
  end
end