# encoding: utf-8
require "spec_helper"

describe PagesController do
  describe "GET #index" do
    it "all is OK" do
      get :index
      response.should be_success
      response.status.should eq 200
      response.should render_template :index
    end
    it "load @pages" do
      page1 = Page.create(slug:'page1', title:'page1')
      page2 = Page.create(slug:'page2', title:'page2')
      subpage1 = Page.create(slug:'subpage1', title:'subpage1', ancestry:page1.id)
      subpage2 = Page.create(slug:'subpage2', title:'subpage2', ancestry:page2.id)
      get :index
      assigns(:pages).should match_array [page1, page2]
    end
  end

  describe "GET #show" do
    it "status 200 OK" do
      Page.create(slug:'пример', title:'пример')
      get :show, slugs:'пример'
      response.should be_success
      response.status.should eq 200
      response.should render_template :show
    end
    it "load @page" do
      page1 = Page.create(slug:'пример', title:'пример')
      get :show, slugs:'пример'
      assigns(:page).should eq page1
    end
  end

  describe "GET #new" do
    it "could be subpage" do
      page1 = Page.create(slug:'пример', title:'пример')
      get :new, slugs:'пример'
      assigns(:page).parent.should eq page1
    end
  end

  # Совсем уж издеваться и покрывать все дырки не буду, смысл ясен.
  # Примеры покрытия остальными спеками есть в сети, например:
  # https://www.relishapp.com/rspec/rspec-rails/v/2-14/docs/gettingstarted
  # http://everydayrails.com/2012/04/07/testing-series-rspec-controllers.html
end