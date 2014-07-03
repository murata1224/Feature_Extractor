class IcalendarExtractor

  def initialize(cal)
    @calendar = cal
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
