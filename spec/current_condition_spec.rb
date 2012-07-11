require 'spec_helper.rb'

describe CurrentConditions do

  let(:current) do
    data = Nokogiri::XML(open("spec/exmaple.xml")).slop!
    current_data = data.weather.current_conditions
    CurrentConditions.from_element(current_data)
  end

  subject { @current }

  it { should respond_to(:fahrenheit) }
  it { should respond_to(:celsius) }
  it { should respond_to(:condition) }
  it { should respond_to(:humidity) }
  it { should respond_to(:wind) }
  it { should respond_to(:image_url) }

  describe "it should give correct data" do
    it { fahrenheit.should == 86 }
    it { celsius.should    == 30 }
    it { condition.should  == "Mostly Cloudy" }
    it { humidity.should   == 0.30 }
    it { wind.should       == "NE at 8 mph" }
    it { image_url.should  == "/ig/images/weather/mostly_cloudy.gif" }
  end
end