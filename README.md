gweather, a(nother) google weather api wrapper in ruby
======================================================

This is my first ruby gem. I wanted to do something relatively simple to get
the hang of it, thus, another weather gem.


Using my gem is simple!

```ruby
require 'gweather'

# will accept zip codes and city names!
weather = WeatherData.create(53717)         # WeatherData.create("madison")

puts weather.city                           # Madison, WI
puts weather.date                           # 2012-07-10 (Well, today's date!)
puts weather.current                        # Current weather conditions
puts weather.today                          # Today's forecast
puts weather.tomorrow                       # Tomorrow's forecast


# Current will respond to temperature, condition, humidity, and wind
# temperature in fahrenheit, pass false as a parameter for celsius
puts weather.current.temperature 
puts weather.current.condition              # Partly Cloudy
puts weather.current.humidity               # 0.39 
puts weather.current.wind                   # SE at 5 mph


# google weather uses 4 day forecast, can be accessed with: today, tomorrow,
# in_two_days, and in_three_days. Also can be accessed by day of the week:
# if today == tuesday, then weather.tuesday, weather.wednesday, etc
puts weather.tomorrow.high                   # get tomorrow's high, in F
puts weather.today.low                       # low temperature
puts weather.in_two_days.day                 # day of the week
puts weather.friday.condition                # Partly Cloudy
```


TODO:
+ add error response for bad input
+ make WeatherData objects print out nice
+ add comments
+ bundle as a gem