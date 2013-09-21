# encoding: utf-8
require 'spec_helper'

describe Page do
  describe '#slug' do
    it 'invalid if empty' do
      Page.create(slug:nil, title:'title').should_not be_valid
      Page.create(slug:'', title:'title').should_not be_valid
    end
    it 'invalid if not unique' do
      Page.create(slug:'slug', title:'title').should be_valid
      Page.create(slug:'slug', title:'title').should_not be_valid
    end
    it 'invalid format' do
      Page.create(slug:'пример страницы', title:'title').should_not be_valid
      Page.create(slug:'sample-page', title:'title').should_not be_valid
    end
    it 'valid format' do
      Page.create(slug:'пример_страницы_some_page_123', title:'title').should be_valid
    end
  end

  describe '#title' do
    it 'invalid if empty' do
      Page.create(slug:'page1', title:nil).should_not be_valid
      Page.create(slug:'page2', title:'').should_not be_valid
    end
  end

  describe '#content' do
    it 'bold format' do
      p = Page.create(slug:'пример', title:'пример', content:'**[строка]**')
      p.content.should eq '<b>[строка]</b>'
      p.formatted_content.should eq '**[строка]**'
    end
    it 'italic format' do
      p = Page.create(slug:'пример', title:'пример', content:'\\\\[строка]\\\\')
      p.content.should eq '<i>[строка]</i>'
      p.formatted_content.should eq '\\\\[строка]\\\\'
    end
    it 'link format' do
      p = Page.create(slug:'пример', title:'пример', content:'((name1/name2/name3 [строка]))')
      p.content.should eq '<a href="/name1/name2/name3">[строка]</a>'
      p.formatted_content.should eq '((name1/name2/name3 [строка]))'
    end
  end

  describe '#ancestry' do
    it 'default is empty' do
      Page.create(slug:'пример', title:'пример').ancestry.should be_nil
    end
    it 'valid root' do
      root = Page.create(slug:'корневая_страница', title:'корневая_страница')
      Page.create(slug:'дочерняя_страница', title:'дочерняя_страница', ancestry:root.id).parent.should eq root
    end
  end

  describe '#to_param' do
    it 'valid url' do
      root = Page.create(slug:'корневая_страница', title:'корневая_страница')
      child = Page.create(slug:'дочерняя_страница', title:'дочерняя_страница', ancestry:root.id)
      root.to_param.should eq 'корневая_страница'
      child.to_param.should eq 'корневая_страница/дочерняя_страница'
    end
  end
end
