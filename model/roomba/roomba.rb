class Roomba
  def initialize(sensor, mover, cleaner)
    @sensor = sensor
    @mover = mover
    @cleaner = cleaner
  end

  def move(direction)
    @mover.move(direction) unless @sensor.check(direction) == :obstacle
  end
end
