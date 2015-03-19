#read data as a string
f = File.new("./allegan_weather_data.csv", "r")
weather_data_string = f.read
f.close

#convert string of data into an array of data
weather_data_points = weather_data_string.split("\n")

#get rid of the first row (titles) so it doesn't mess with calculations
first_row = weather_data_points.shift

#find the mean (by first splitting into another array)
sum = 0
weather_data_points.each do |data_point|
  weather_data_point_values = data_point.split(",")
  precipitation = weather_data_point_values[5].to_f
  sum = sum + precipitation
end

average = sum / weather_data_points.count

#output the average to user
puts "Average:"
puts average

#find the standard deviation
variance = 0
weather_data_points.each do |data_point|
  weather_data_point_values = data_point.split(",")
  precipitation = weather_data_point_values[5].to_f
  variance = variance + (precipitation - average)**2
end

standard_deviation = (variance / weather_data_points.count)**0.5

#output standard deviation to user
puts "Standard Deviation:"
puts standard_deviation

#find the z score and push it into an array
z_score_array = []
weather_data_points.each do |data_point|
  weather_data_point_values = data_point.split(",")
  precipitation = weather_data_point_values[5].to_f
  z_score_points = (precipitation - average) / standard_deviation
  z_score_array.push data_point.to_s + "," + z_score_points.to_s + ""
end

#return first row to top
z_score_array.unshift(first_row)

#change array into a traditional csv in a new file
f = File.open("./allegan_weather_data_new.csv", "w")
f.write z_score_array.join("\n")
f.close
