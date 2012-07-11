
Gem::Specification do |s|
  s.name        = 'gweather'
  s.version     = '0.0.1'
  s.date        = '2012-07-10'
  s.summary     = 'a ruby api wrapper for google weather'
  s.description = 'gweather is a google weather api wrapper for ruby'
  s.authors     = ["Patrick Dean"]
  s.email       = 'patrick.l.dean@gmail.com'
  s.files       = ['lib/gweather/current_conditions.rb',
                   'lib/gweather/forecast_conditions.rb',
                   'lib/gweather/weather_data.rb',
                   'lib/gweather.rb',
                   'spec/current_condition_spec.rb',
                   'spec/forecast_conditions_spec.rb',
                   'spec/weather_data_spec.rb',
                   'spec/spec_helper.rb',
                   'spec/example.xml',
                   'gweather.gemspec']
  s.homepage    = ''
end