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
    set_my_variables
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


  # 事前に登録された(dtstart - created がプラス)eventの
  # CREATEDからDTSTARTまでの平均日数
  def average_genuine_events_to_dtstart
    distances = Array.new
    @calendar.events.each do |e|
      if (e.my_dtstart - e.my_created) > 0
        distances << (e.my_dtstart - e.my_created).to_i
      end
    end
    return distances.average
  end

  # 予定作成から from_day から to_day の間に実施される予定
  # from_dayが-999なら負方向に無限，
  # to_dayが999なら正方向に無限
  def events_held_within(from_day = -999, to_day = 999)
    @calendar.events.select do |e|
      (from_day == -999 && to_day === 999) ||
      (from_day == -999 && 
       (e.my_dtstart - e.my_created) <= to_day ) ||
        (to_day == 999 && 
         (e.my_dtstart - e.my_created) > from_day ) ||
        ((e.my_dtstart - e.my_created) > from_day &&
         (e.my_dtstart - e.my_created) <= to_day )
    end
  end
  end

  private

  def set_my_variables
    @calendar.events.each do |e|
      e.my_created =
        Date.new(e.created.year, e.created.month, e.created.day)
      e.my_dtstart =
        Date.new(e.dtstart.year, e.dtstart.month, e.dtstart.day)
    end
  end

end
