class PassengerTrain < Train
  attr_reader :number

  def initialize(number)
    super(number,:passenger)
  end
end
