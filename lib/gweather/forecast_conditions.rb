require './lib/gweather.rb'

class ForecastConditions
  attr_reader :day, :low, :high, :condition, :image_url

  def self.from_element(forecast)
    unless forecast.is_a?(Nokogiri::XML::Element)
      raise "must be of type Nokogiri::XML::Element" 
    end
    day = forecast.day_of_week.attributes["data"].value
    low = forecast.low.attributes["data"].value.to_i
    high = forecast.high.attributes["data"].value.to_i
    condition = forecast.condition.attributes["data"].value
    image_url = forecast.icon.attributes["data"].value

    new(day, low, high, condition, image_url)
  end

  def initialize(day, low, high, condition, image_url)
    @day = convert_day(day)
    @low = low
    @high = high
    @condition = condition
    @image_url = image_url
  end

  private

    def convert_day(day)
      case day
      when /^Sun/
        "Sunday"
      when /^Mon/
        "Monday"
      when /^Tue/
        "Tuesday"
      when /^Wed/
        "Wednesday"
      when /^Thu/
        "Thursday"
      when /^Fri/
        "Friday"
      when /^Sat/
        "Saturday"
      else
        "Not a day"
      end
    end

end