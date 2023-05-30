class Route
  include InstanceCounter
  attr_reader :stations

  def initialize(station_first, station_last)
    @stations = [station_first, station_last]
    register_instance
    validate!
  end

  def valid?
    validate!
  rescue
    false
  end

  def first_station
    @stations.first
  end

  def last_station
    @stations.last
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remove_station(station)
    if station != @stations.first || station != @stations.last
      @stations.delete(station)
    end
  end

  protected

  def validate(station)
    # 6 task
    raise "Name station can't be nil !" if station.nil?
    raise "This object: #{station} - is not an instance of the Station class !!!" unless station.class == Station
    raise "Name station can't be Empty !" if station.name.strip.empty?
  end

  def validate!
    validate(first_station)
    validate(last_station)
    raise "The route must have different stations! (In this case first: #{first_station.name}, last: #{last_station.name}) " if first_station.name == last_station.name
    true
  end

end
