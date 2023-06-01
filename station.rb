require_relative 'modul'
require_relative 'validator'

class Station
  include InstanceCounter
  include Validation
  attr_reader :name, :trains

  @@stations = []

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations << self
    register_instance
  end

  def to_s
    @name
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
    errors = []

    errors << "Name station can't be nil!" if name.nil?
    errors << "Name station can't be Empty!" if name.strip.empty?
    errors << "Name station should be at least 5 symbols" if name.length < 4

    raise errors.join('.') unless errors.empty?
  end
end
