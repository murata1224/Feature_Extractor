require './icalendar_extractor.rb'

filename = ""
if ARGV[0]
  filename = ARGV[0]
else
  puts "usage: ruby feature_extractor.rb ics_path"
  exit(1)
end

ics_string = File.open(filename)
ical_extractor = IcsExtractor.new(ics_string)


puts "summary_average\t: " + ical_extractor.summary_average.round(1).to_s
puts "event_count\t: " + ical_extractor.event_count.to_s
