require 'spec_helper.rb'

describe ForecastConditions do
  
  let(:forecast) { ForecastConditions.new }
  
  subject { @forecast }

  it { should respond_to(:day) }
  it { should respond_to(:high) }
  it { should respond_to(:low) }
  it { should respond_to(:condition) }
  it { should respond_to(:image_url) }

end