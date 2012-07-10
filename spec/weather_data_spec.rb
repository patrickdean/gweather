
describe WeatherData do
  @days = %w{sunday monday tuesday wednesday thursday
             friday saturday}.map(&:to_sym)
  let(:data) { WeatherData.new }

  subject { @data }

  it { should respond_to(:city) }
  it { should respond_to(:today) }
  it { should respond_to(:tomorrow) }
  it { should respond_to(:in_two_days) }
  it { should respond_to(:in_three_days) }
  it { should respond_to(:date) }
  @days.each do |day|
    it { should respond_to(day) }
  end


end