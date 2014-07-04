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

puts "### calendar ###"

puts "summary_average\t: " +
  ical_extractor.summary_average.round(1).to_s
puts "event_count\t: " +
  ical_extractor.event_count.to_s

puts "### event ###"
puts "average_days\t:" + ical_extractor.average_days_to_dtstart.to_s
puts "-1 day >\t:" + ical_extractor.num_of_events_held_within(-1).to_s
puts "0 day  >\t:" + ical_extractor.num_of_events_held_within(0).to_s
puts "1 day  >\t:" + ical_extractor.num_of_events_held_within(1).to_s
puts "1 week >\t:" + ical_extractor.num_of_events_held_within(7).to_s
puts "1 month >\t:" + ical_extractor.num_of_events_held_within(30).to_s
puts "2 months >\t:" + ical_extractor.num_of_events_held_within(30*2).to_s
puts "3 months >\t:" + ical_extractor.num_of_events_held_within(30*3).to_s
puts "6 months >\t:" + ical_extractor.num_of_events_held_within(30*6).to_s
