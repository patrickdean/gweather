require './lib/gweather.rb'

class WeatherData
  attr_reader :city, :date, :location, :current
  alias :currently :current

  class << self
    def create(zipcode)
      gweather_url = 'http://www.google.com/ig/api?weather='
      from_xml(gweather_url + zipcode.to_s)
    end

    def from_xml(filename)
      file = Nokogiri::XML(open(filename))
      file.slop!
      weather = file.xml_api_reply.weather
      city = weather.forecast_information.city.attributes["data"].value
      date = weather.forecast_information.forecast_date.attributes["data"].value
      current = CurrentConditions.from_element(weather.current_conditions)
      data = {}
      weather.forecast_conditions.each_with_index do |forecast, index|
        data[relative_days[index]] = ForecastConditions.from_element(forecast)
      end
      new(city, date, current, data)
    end

    def relative_days
      @relative_days ||= %w{today tomorrow 
                            in_two_days in_three_days}.map(&:to_sym)
    end

    def days
      @days ||= %w{sunday monday tuesday wednesday thursday
                   friday saturday}.map(&:to_sym)
    end
  end

  def initialize(city = nil, date = nil, current = nil, forecasts = {})
    @city, @date, @current, @forecasts = city, date, current, forecasts
  end

  def method_missing(method, *args)
    if self.class.relative_days.member?(method)
      get_by_relative_day(method) 
    elsif self.class.days.member?(method)
      get_by_weekday(method) 
    else
      super
    end
  end

  def respond_to?(method)
    return true if self.class.days.member?(method) || 
                   self.class.relative_days.member?(method)
    super
  end

  private

    def get_by_relative_day(day)
      @forecasts[day]
    end

    def get_by_weekday(day)
      
      @forecasts.each do |key, forecast| 
        return forecast if forecast.day.downcase.to_sym == day 
      end
      "No data for #{day}"
    end
end