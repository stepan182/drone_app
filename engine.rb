class Engine
  attr_accessor :status, :power

  STATUS = ["off", "on"].freeze

  def initialize(status = STATUS[1])
    @status = status
  end

  def start
    @status = STATUS[1]
  end

  def power=(power)
    @power = power
    raise "Power should be between 0 to 100" if power < 0 || power > 100
  end
end