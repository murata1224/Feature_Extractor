# -*- coding: utf-8 -*-

require 'icalendar'

class Array
  def average
    inject(0.0) { |sum, i| sum += i } / size
  end

  def variance
    ave = average
    inject(0.0) { |sum, i| sum += (i - ave)**2 } / size
  end

  def standard_devitation
    Math::sqrt(variance)
  end
end

module Icalendar
  class Event
    # iCalendar::Values::DateTime　クラスは，
    # なぜかオブジェクト同士の加減算ができない
    # このため，Ruby組み込みのDate型を使う
    attr_accessor :my_created, :my_dtstart
  end
end


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


  def average_days_to_dtstart
    distances = distances_from_created_to_dtstart
    return distances.average
  end

  # 予定作成からdays以内に実施される予定の数
  def num_of_events_held_within(days)
    distances = distances_from_created_to_dtstart
    return (distances.select {|d| d <= days }).count
  end

  private
  def distances_from_created_to_dtstart
    distances = Array.new
    @calendar.events.each do |e|
      # iCalendar::Values::DateTime　クラスは，
      # なぜかオブジェクト同士の加減算ができない
      dtstart =
        Date.new(e.dtstart.year, e.dtstart.month, e.dtstart.day)
      created =
        Date.new(e.created.year, e.created.month, e.created.day)
      distances << (dtstart - created).to_i
    end
    return distances
  end

end
