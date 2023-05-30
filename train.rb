require_relative 'station'
require_relative 'route'

class Train
  include NameCompany
  include InstanceCounter
  attr_reader :number, :type, :wagons, :routes, :speed, :current_station_index

  NUMBER_FORMAT = /^[a-z\d]{3}-?[a-z\d]{2}$/i

  @@trains = {}

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    @speed = 0
    @current_station_index = 0
    @@trains[number] = self
    register_instance
    validate!
  end

  def to_s
    @number
  end

  def valid?
    validate!
  rescue RuntimeError
    false
  end

  def speed_up(speed)
    @speed += speed if speed <= 0
  end

  def stop
    @speed = 0
  end

  def relevant_wagon?(wagon)
    wagon.type == @type
  end

  def add_wagon(wagon)
    @wagons << wagon
  end

  def remove_wagons(wagon)
    if @speed.nonzero?
      @wagons.delete(wagon)
    end
  end

  def assign_route(routes)
    @routes = routes
    @current_station_index = 0
    @routes.stations[@current_station_index].add_train(self)
  end

  def current_station
    @routes.stations[@current_station_index]
  end

  def next_station
    @routes.stations[@current_station_index + 1]
  end

  def previous_station
    @routes.stations[@current_station_index - 1]
  end

  def move_forward
    current_station.send_train(self)
    @current_station_index += 1
    current_station.add_train(self)
    puts "Train:#{self} is current station#{current_station}"
  end

  def move_backward
    current_station.send_train(self)
    @current_station_index -= 1
    current_station.add_train(self)
    puts "Train:#{self} is current station#{current_station}"
  end

  def self.find(number)
    @@trains[number]
  end

  protected

  def validate!
    raise "Number can't be Nil!" if number.nil?
    raise "Number can't be EMPTY!" if number.to_s.empty?
    raise "Number should be at least 5 symbols" if 0 < number.strip.length && number.strip.length < 5
    raise "The valid number must be of the form: XXX-XX or XXXXX" if number !~ NUMBER_FORMAT
    raise "Type can't be nil" if type.nil?
    raise "Type should be at least 5 symbols" if type.length < 5
  end
end