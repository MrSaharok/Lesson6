class Wagon
  include NameCompany
  attr_reader :type

  def initialize(wagon_type)
    @type = wagon_type
    validate!
  end

  def valid?
    validate!
  rescue
    false
  end

  protected

  def validate!
    raise "Type can't be nil" if type.nil?
    true
  end
end
