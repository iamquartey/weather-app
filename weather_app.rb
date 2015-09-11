# weather_app.rb - Adnan Quartey - 09-09-2015
require 'yahoo_weatherman'

print "\n+-+-+-+-+-+-+-+-+\n+  Weather App  +\n+-+-+-+-+-+-+-+-+\n\n"
print "Please enter your postal zip code: "
zip_code = gets.to_s

client = Weatherman::Client.new(unit: 'f')
locale = client.lookup_by_location(zip_code)
current_temp = locale.condition['temp']
current_condition = locale.condition['text']

puts "\nIt's currently #{current_temp}ᵒ F and #{current_condition}"

day_increment = 0
while (day_increment < 5)
	forecast_data = locale.forecasts[day_increment]
	forecast_date = forecast_data.fetch("date").to_s
	forecast_int = Time.new(forecast_date[0..3], forecast_date[5..6], forecast_date[8..9]).strftime("%w")
	today_int = Time.now.strftime("%w")
	
	if (today_int == forecast_int)
			forecast_day = "Today's forecast"; next_day = day_increment+1
		elsif (next_day == day_increment)
			forecast_day = "Tomorrow's forecast"
		else forecast_day = forecast_data.fetch("day")
	end
	forecast_text = forecast_data.fetch("text")
	forecast_low = forecast_data.fetch("low")
	forecast_high = forecast_data.fetch("high")
	puts "\n#{forecast_day} is going to be #{forecast_text} with a low of #{forecast_low} and a high of #{forecast_high}ᵒ F."
	day_increment+=1
end