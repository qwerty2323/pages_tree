# encoding: utf-8
require 'spec_helper'

# https://www.relishapp.com/rspec/rspec-rails/v/2-14/docs/controller-specs/anonymous-controller
describe "#root" do
  it "routes / to pages#index" do
    {get:'/'}.should route_to controller:'pages', action:'index'
  end
end