require 'spec_helper.rb'

describe ForecastConditions do
  
  let(:forecast) do 
    data = Nokogiri::XML(open("spec/example.xml"))
    data.slop!
    forecast_data = data.xml_api_reply.weather.forecast_conditions[0]
    ForecastConditions.from_element(forecast_data)
  end
  
  subject { forecast }

  it { should respond_to(:day) }
  it { should respond_to(:high) }
  it { should respond_to(:low) }
  it { should respond_to(:condition) }
  it { should respond_to(:image_url) }

  describe "should give correct data" do
    it { forecast.day.should       == "Tuesday" }
    it { forecast.high.should      == 88 }
    it { forecast.low.should       == 63 }
    it { forecast.condition.should == "Mostly Sunny" }
    it { forecast.image_url.should == "/ig/images/weather/mostly_sunny.gif" }
  end

  describe "should give correct days" do
    test_days = [[['Mon', 'Monday'], 'Monday'], 
                 [['Tue', 'Tuesday'], 'Tuesday'],
                 [['Wed', 'Wednesday'],'Wednesday'],
                 [['Thu', 'Thursday'], 'Thursday'],
                 [['Fri', 'Friday'], 'Friday'],
                 [['Sat', 'Saturday'], 'Saturday'],
                 [['Sun', 'Sunday'], 'Sunday']]
    test_days.each do |test_data, day|
      test_data.each do |test_day|
        it "should match #{day}" do
          forecast.send(:convert_day, test_day).should == day
        end
      end
    end
  end
end