class HomeController < ApplicationController
	skip_filter :login_required, :only => [:index]
  def index
	if current_user
		redirect_to home_path
	else
		render :layout => 'welcome'
	end
  end

  def day
    @categories = @current_user.categories

    if params[:day]
      @current_date = Date.civil(params[:year].to_i, params[:month].to_i, params[:day].to_i)
       else
      @current_date = Date.today
    end

    start_time = Time.local(@current_date.year, @current_date.month, @current_date.mday).getutc
    end_time = 1.day.from_now(@current_date)
	end_time = Time.local(end_time.year, end_time.month, end_time.mday).getutc
    @activities = @current_user.records.find(:all, :conditions => ["records.created_at >= ? AND records.created_at < ?", start_time, end_time], :order => "records.created_at DESC")  
  end

  def month
    @current_date = Date.civil(params[:year].to_i, params[:month].to_i)
    @graph = open_flash_chart_object(500, 300, month_chart_path(@current_date.year, @current_date.month))
  end

  def year
    @current_date = Date.civil(params[:year].to_i)
    @graph = open_flash_chart_object(500, 300, year_chart_path(@current_date.year))
  end

  def range
    @current_date = Date.civil(params[:start_year].to_i, params[:start_month].to_i, params[:start_day].to_i)
    @end_date = Date.civil(params[:end_year].to_i, params[:end_month].to_i, params[:end_day].to_i)
    @end_date = 1.day.from_now(@end_date) if @current_date == @end_date
    @graph = open_flash_chart_object(500, 300, range_chart_path(@current_date.year, @current_date.month, @current_date.mday, @end_date.year, @end_date.month, @end_date.mday))
  end
  
  def calendar
    date = Date.civil(params[:year].to_i, params[:month].to_i)
    render :update do |page|
      page.replace_html "calendar_container", :partial => "calendar", :locals => {:date => date}
    end
  end

  def month_chart
    start_time_local = Time.local(params[:year].to_i, params[:month].to_i, 1)
    end_date_local = 1.month.from_now(Date.civil(start_time_local.year, start_time_local.month))
    end_date_local = Date.civil(end_date_local.year, end_date_local.month, 1)
    start_time = start_time_local.getutc
    end_time = Time.local(end_date_local.year, end_date_local.month).getutc

    categories = @current_user.records.find(:all, :select =>"sum(records.duration) as sum_duration, categories.*", :conditions => ["records.created_at >= ? AND records.created_at < ?", start_time, end_time], :group => "records.category_id")
    prepare_chart(I18n.l(start_time_local, :format=>"%B"), categories)
  end
  
  def year_chart
    start_time_local = Time.local(params[:year].to_i)
    start_time = start_time_local.getutc
    end_time = 1.year.from_now(start_time)

    categories = @current_user.records.find(:all, :select =>"sum(records.duration) as sum_duration, categories.*", :conditions => ["records.created_at >= ? AND records.created_at < ?", start_time, end_time], :group => "records.category_id")
    prepare_chart(start_time_local.year, categories)
  end

  def range_chart
    start_time_local = Time.local(params[:start_year].to_i, params[:start_month].to_i, params[:start_day].to_i)
    start_time = start_time_local.getutc
    end_time_local = Time.local(params[:end_year].to_i, params[:end_month].to_i, params[:end_day].to_i)
    end_time = end_time_local.getutc

    categories = @current_user.records.find(:all, :select =>"sum(records.duration) as sum_duration, categories.*", :conditions => ["records.created_at >= ? AND records.created_at < ?", start_time, end_time], :group => "records.category_id")
    prepare_chart("#{I18n.l(start_time_local.to_date, :format => '%e %B %Y')} → #{I18n.l end_time_local.to_date, :format => '%e %B %Y'}", categories)
  end

  private
  def prepare_chart(label, categories)
    names = categories.map{|category| category.title }
    durations = categories.map{|category| category.sum_duration.to_i }
    colors = categories.map{|category| category.color }

    g = Graph.new
    g.pie(70, '#505050', '{font-size: 12px; color: #404040;}')
    g.pie_values(durations, names)
    g.pie_slice_colors(colors)
    g.set_tool_tip("#x_label#<br>#val# хв")
    g.title(label, '{font-size:18px; color: #d01f3c}' )
    render :text => g.render
  end
end
