require_relative 'modul'

class Station
  include InstanceCounter
  attr_reader :name, :trains

  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
    validate!
  end

  def to_s
    @name
  end

  def valid?
    validate!
  rescue RuntimeError
    false
  end

  def add_train(train)
    trains << train
  end

  def trains_type(type)
    trains.select { |train| train.type == type }
  end

  def send_train(train)
    trains.delete(train)
  end

  def self.all
    @@stations
  end

  protected

  def validate!
    raise "Name station can't be nil!" if name.nil?
    raise "Name station can't be Empty!" if name.strip.empty?
    raise "Name station should be at least 5 symbols" if name.length < 4
    true
  end
end
