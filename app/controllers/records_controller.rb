class RecordsController < ApplicationController
  # GET /records
  # GET /records.xml
  def index
    @records = Record.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @records }
    end
  end

  # GET /records/1
  # GET /records/1.xml
  def show
    @record = Record.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @record }
    end
  end

  # GET /records/new
  # GET /records/new.xml
  def new
    @record = Record.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @record }
    end
  end

  # GET /records/1/edit
  def edit
    @record = Record.find(params[:id])
  end

  # POST /records
  # POST /records.xml
  def create
    @record = Record.new(params[:record])
    @record.category = Category.find_by_id params[:category_id]
    duration = params[:record][:duration].split(':', -1)
    if duration.size > 1
      @record.duration = duration[0].to_i * 60 + duration[1].to_i
    end

    render :update do |page|
      if @record.save
        page.insert_html :top, "activities", :partial => "home/record_show", :locals => {:activity => @record}
        page.visual_effect :highlight, "record_show_#{@record.id}", :duration => 3
      end

      page.replace_html "record_add_form_#{@record.category.id}", :partial => "home/record_add_form", :locals => {:category => @record.category}
    end
  end

  # PUT /records/1
  # PUT /records/1.xml
  def update
    @record = Record.find(params[:id])

    respond_to do |format|
      if @record.update_attributes(params[:record])
        flash[:notice] = 'Record was successfully updated.'
        format.html { redirect_to(@record) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @record.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /records/1
  # DELETE /records/1.xml
  def destroy
    @record = Record.find(params[:id])
    @record.destroy

    render :update do |page|
      page.visual_effect :fade, "record_show_#{params[:id]}"
#      page.remove "record_show_#{params[:id]}"
	end
  end
end
