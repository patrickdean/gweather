require 'spec_helper.rb'

describe WeatherData do
  @days = %w{sunday monday tuesday wednesday thursday
             friday saturday}.map(&:to_sym)
  before(:all) { @data = WeatherData.from_xml("spec/example.xml") }

  subject { @data }

  it { should respond_to(:city) }
  it { should respond_to(:current) }
  it { should respond_to(:today) }
  it { should respond_to(:tomorrow) }
  it { should respond_to(:in_two_days) }
  it { should respond_to(:in_three_days) }
  it { should respond_to(:date) }
  @days.each do |day|
    it { should respond_to(day) }
  end

  it "should get the name of the city" do
    @data.city.should == "Madison, WI"
  end

  it "should get the date" do
    @data.date.should == "2012-07-10"
  end

  it "should get current conditions" do
    @data.current.should be_kind_of(CurrentConditions)
  end

  it "should get current day's forecast" do
    @data.today.should be_kind_of(ForecastConditions)
  end

  it "should get next day's forecast" do
    @data.tomorrow.should be_kind_of(ForecastConditions)
  end

  it "should get third day's forecast" do
    @data.in_two_days.should be_kind_of(ForecastConditions)
  end

  it "should get fourth day's forecast" do
    @data.in_three_days.should be_kind_of(ForecastConditions)
  end

  describe "future forecast" do
    it "example.xml should give tuesday as today" do
      @data.today.should == @data.tuesday
    end

    it "example.xml should give wednesday as tomorrow" do
      @data.tomorrow.should == @data.wednesday
    end

    it "example.xml should give thursday as in_two_days" do
      @data.in_two_days.should == @data.thursday
    end

    it "example.xml should give friday as in_three_days" do
      @data.in_three_days.should == @data.friday
    end
  end
end