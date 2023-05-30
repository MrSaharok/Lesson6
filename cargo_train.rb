class CargoTrain < Train
  attr_reader :number

  def initialize(number)
    super(number, :cargo)
  end
end
