class Roomba
  def initialize(sensor, engine, cleaner)
    @sensor = sensor
    @engine = engine
    @cleaner = cleaner
  end

  def auto_move
    move mover.next_move
  end

  def move(direction)
    case @sensor.check(direction)
      when :obstacle
        mapper.blocked(direction)
      else
        @engine.move(direction)
        mapper.moved(direction)
    end
  end

  private

  def mover
    @mover ||= Mover.new mapper
  end

  def mapper
    @mapper ||= Mapper.new
  end
end
