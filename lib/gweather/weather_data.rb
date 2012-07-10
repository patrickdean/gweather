require "../gweather.rb"

class WeatherData
  attr_reader :city, :date, :location, :current
  alias :currently :current
  class << self
    def from_xml(filename)
      file = Nokogiri::XML(open(filename))
      file.slop!
      weather = file.xml_api_reply.weather
      @city = weather.forecast_information.city.attributes["data"].value
      @date = weather.forecast_information.forecast_date.attributes["data"].value
      @current = CurrentConditions.from_element(weather.current_conditions)
      weather.forecast_conditions.each do |forecast|
        @data << ForecastCondition.from_element(forecast)
      end
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

  def initialize(location)
    @location = location
    @data = []
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
      @data[day]
    end

    def get_by_weekday(day)
      @data.each { |forecast| return forecast if forecast.day == day }
      "No data for #{day}"
    end
end