module HomeHelper
  def link_to_prev_day(text, date)
    prev_day = 1.day.ago(date)
    link_to text, day_path(prev_day.year, prev_day.month, prev_day.mday)
  end

  def link_to_next_day(text, date)
    next_day = 1.day.from_now(date)
    if next_day <= Date.today
      link_to text, day_path(next_day.year, next_day.month, next_day.mday)
    else
      text
    end
  end

  def day_navigation(date)
    day = I18n.l date, :format => "%A, %e"
    day + link_to(I18n.l(date, :format=>" %B"), month_path(date.year, date.month)) + " " + link_to(date.year, year_path(date.year))
  end

  def month_navigation(date)
    I18n.l(date, :format=>" %B") + " " + link_to(date.year, year_path(date.year))
  end

  def link_to_prev_month(text, date)
    prev_month = 1.month.ago(date)
    link_to text, month_path(prev_month.year, prev_month.month)
  end

  def link_to_next_month(text, date)
    next_month = 1.month.from_now(date)
    if next_month <= Date.today
      link_to text, month_path(next_month.year, next_month.month)
    else
      text
    end
  end

  def link_to_prev_year(text, date)
    prev_year = 1.year.ago(date)
    link_to text, year_path(prev_year.year)
  end

  def link_to_next_year(text, date)
    next_year = 1.year.from_now(date)
    if next_year <= Date.today
      link_to text, year_path(next_year.year)
    else
      text
    end
  end
  
  def link_to_prev_calendar(text, date)
	prev_month = 1.month.ago(date)
	link_to_remote(text, :url => {:action => 'calendar', :year => prev_month.year, :month => prev_month.month})
  end
  
  def link_to_next_calendar(text, date)
    next_month = 1.month.from_now(date)
    if next_month <= Date.today
      link_to_remote(text, :url => {:action => 'calendar', :year => next_month.year, :month => next_month.month})
    else
      text
    end
  end  

  def separate_hours(minutes)
    if minutes > 60
      result = (minutes / 60).to_s + " год"
      minutes %= 60
      if minutes != 0
        result = result + " " + minutes.to_s + " хв"
      end
      result
    else
      minutes.to_s + " хв"
    end
  end
end