require 'icalendar'
require './icalendar_extractor.rb'

calendar = Icalendar::Calendar.new
if ARGV[0]
  filename = ARGV[0]
  cal_file = File.open(filename)
  cals = Icalendar.parse(cal_file)
  calendar = cals.first
else
  puts "usage: ruby feature_extractor.rb ics_path"
  exit(1)
end

ical_extractor = IcalendarExtractor.new(calendar)

puts "summary_average\t: " + ical_extractor.summary_average.round(1).to_s
puts "event_count\t: " + ical_extractor.event_count.to_s
