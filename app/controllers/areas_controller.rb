class AreasController < ApplicationController
  include Applicat::Mvc::Controller::Resource
  
  before_filter :find_area
  
  load_and_authorize_resource
  
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
  respond_to :html, :js, :json
  
  def index
    @areas = Area.roots
      
    respond_to do |format|
      format.html
      format.json { render json: @areas.tokens(params[:q]) }
    end
  end
  
  def show
    @areas = @area.children
    @projects = @area.projects
  end
  
  def new
    @area = Area.new(params[:area])
  end
  
  def create
    @area = Area.new(params[:area])
    
    if @area.save
      redirect_to @area, notice: t('general.form.successfully_created')
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @area.update_attributes(params[:area])
      redirect_to @area, notice: t('general.form.successfully_updated')
    else
      render :edit
    end
  end

  def destroy
    @area.destroy
    redirect_to areas_url, notice: t('general.form.destroyed')
  end
  
  def resource
    @area
  end
  
  private
  
  def not_found
    redirect_to areas_path, notice: t('areas.exceptions.not_found')
  end
  
  def find_area
    @area = Area.friendly.find(params[:id]) if params[:id].present?
  end
end