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

puts "\n### Calendar ###"
cal_start, cal_end = ical_extractor.duration_of_using_calendar
puts "duration:\t\t" + cal_start.to_s + "," + cal_end.to_s
puts "num of days in duration:" + (cal_end - cal_start).to_i.to_s
puts "num of events:\t\t" +
  ical_extractor.event_count.to_s
puts "AVG of summary's chars:\t" +
  ical_extractor.summary_average.round(1).to_s

puts "\n### Event ###"
puts "AVG of days until expected date in all events:\t\t" +
  ical_extractor.average_all_events_to_dtstart.round(2).to_s
puts "AVG of days until expected date in genuine events:\t" +
  ical_extractor.average_genuine_events_to_dtstart.round(2).to_s

puts "distribution of days from CREATED to DTSTART:"
puts "|more before\t|0d\t|1d\t|1w\t|2w\t|1m\t|2m\t|3m\t|6m\t|more after\t|"
puts "|" + ical_extractor.events_held_within(-999,-1).count.to_s + "\t\t|" +
  ical_extractor.events_held_within(-1,  0).count.to_s + "\t|" +
  ical_extractor.events_held_within(0,   1).count.to_s + "\t|" +
  ical_extractor.events_held_within(1,   7).count.to_s + "\t|" +
  ical_extractor.events_held_within(7,   7*2).count.to_s + "\t|" +
  ical_extractor.events_held_within(7*2, 30).count.to_s + "\t|" +
  ical_extractor.events_held_within(30,  30*2).count.to_s + "\t|" +
  ical_extractor.events_held_within(30*2,30*3).count.to_s + "\t|" +
  ical_extractor.events_held_within(30*3,30*6).count.to_s + "\t|" +
  ical_extractor.events_held_within(30*6,999).count.to_s + "\t\t|"

