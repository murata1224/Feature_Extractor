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

puts "summary_average:\t " +
  ical_extractor.summary_average.round(1).to_s
puts "event_count:\t\t " +
  ical_extractor.event_count.to_s
cal_start, cal_end = ical_extractor.duration_of_using_calendar
puts "duration:\t\t" + cal_start.to_s + "," + cal_end.to_s
puts "days of duration:\t" + (cal_end - cal_start).to_s

puts "### event ###"
puts "average_all_events\t:" +
  ical_extractor.average_all_events_to_dtstart.to_s
puts "average_genuine_events\t:" +
  ical_extractor.average_genuine_events_to_dtstart.to_s

puts "distribution of days from CREATED to DTSTART"
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

