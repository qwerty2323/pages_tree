require "spec_helper"

describe PagesController do
  describe "GET #index" do
    it "status 200 OK" do
      get :index
      response.should be_success
      response.status.should == 200
    end
    it "render template" do
      get :index
      # expect(response).to render_template("index")
      response.should render_template :index
    end
    it "load @pages" do
      page1 = Page.create(slug:'page1', title:'page1')
      page2 = Page.create(slug:'page2', title:'page2')
      subpage1 = Page.create(slug:'subpage1', title:'subpage1', ancestry:page1.id)
      subpage2 = Page.create(slug:'subpage2', title:'subpage2', ancestry:page2.id)
      get :index
      expect(assigns(:pages)).to match_array [page1, page2]
    end
  end
end