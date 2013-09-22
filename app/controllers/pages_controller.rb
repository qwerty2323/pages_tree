class PagesController < ApplicationController
  before_filter :find_page, only:[:new, :show, :edit, :update]

  def index
    @pages = Page.cached_roots
  end
  def show
  end
  def new
    @page = @page ? @page.children.new : Page.new
  end
  def edit
  end
  def create
    @page = Page.new(params[:page])
    if @page.save
      # clear ancestors cache
      expire_fragment 'index'
      Rails.cache.delete 'roots' if @page.root?
      @page.ancestor_ids.each do |id|
        expire_fragment id
        Rails.cache.delete id
      end
      redirect_to @page, notice: 'Page was successfully created.'
    else
      render action: 'new'
    end
  end
  def update
    if @page.update_attributes(params[:page])
      # clear ancestors cache, only if data is changed
      expire_fragment 'index' if @page.title_changed?
      if @page.title_changed? or @page.content_changed?
        Rails.cache.delete 'roots' if @page.root?
        @page.ancestor_ids.each do |id|
          expire_fragment id
          Rails.cache.delete id
        end
      end
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
    redirect_to root_path unless @page
  end
end
