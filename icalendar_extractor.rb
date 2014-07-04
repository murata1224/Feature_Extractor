# -*- coding: utf-8 -*-

require 'icalendar'

class IcsExtractor

  def initialize(ics_string)
    @calendar = Icalendar.parse(ics_string).first
  end

  def event_count
    @calendar.events.count
  end

  def summary_average
    summary_sum = 0
    @calendar.events.each do |e|
      summary_sum += e.summary.length
    end
    return (summary_sum.to_f / self.event_count)
  end

end
