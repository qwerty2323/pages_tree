class PagesController < ApplicationController
  before_filter :find_page, only:[:new, :show, :edit, :update]

  def index
    @pages = Page.roots
  end
  def show
  end
  def new
    @page = @page ? Page.new(ancestry:@page.id) : Page.new
  end
  def edit
  end
  def create
    @page = Page.new(params[:page])
    if @page.save!
      redirect_to @page, notice: 'Page was successfully created.'
    else
      render action: 'new'
    end
  end
  def update
    if @page.update_attributes(params[:page])
      redirect_to @page, notice: 'Page was successfully updated.'
    else
      render action: 'edit'
    end
  end



  protected
  def find_page
    slug = params[:slugs].split('/').last if params[:slugs]
    slug ||= params[:slug]
    @page = Page.find_by_slug(slug)
  end
end
