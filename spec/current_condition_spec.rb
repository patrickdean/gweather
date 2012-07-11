require 'spec_helper.rb'

describe CurrentConditions do

  let(:current) do
    data = Nokogiri::XML(open("spec/example.xml"))
    data.slop!
    current_data = data.xml_api_reply.weather.current_conditions
    CurrentConditions.from_element(current_data)
  end

  subject { current }

  it { should respond_to(:temperature) }
  it { should respond_to(:fahrenheit) }
  it { should respond_to(:celsius) }
  it { should respond_to(:condition) }
  it { should respond_to(:humidity) }
  it { should respond_to(:wind) }
  it { should respond_to(:image_url) }

  describe "it should give correct data" do
    it { current.fahrenheit.should == 86 }
    it { current.celsius.should    == 30 }
    it { current.condition.should  == "Mostly Cloudy" }
    it { current.humidity.should   == 0.30 }
    it { current.wind.should       == "NE at 8 mph" }
    it { current.image_url.should  == "/ig/images/weather/mostly_cloudy.gif" }
  end
end