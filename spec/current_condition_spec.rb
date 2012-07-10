require 'spec_helper.rb'

describe CurrentConditions do

  let(:current) { CurrentConditions.new }

  subject { @current }

  it { should respond_to(:fahrenheit) }
  it { should respond_to(:celsius) }
  it { should respond_to(:condition) }
  it { should respond_to(:humidity) }
  it { should respond_to(:wind) }
  it { should respond_to(:image_url) }


end