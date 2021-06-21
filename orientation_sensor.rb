class OrientationSensor
  def pitch(x, y, z)
    to_degrees Math.atan(x / dist(y, z))
  end

  def roll(x, y, z)
    to_degrees Math.atan(y / dist(x, z))
  end

  private

    def to_degrees(radians)
      radians / Math::PI * 180
    end

    def dist(a, b)
      Math.sqrt((a*a)+(b*b))
    end
end