class Page < ActiveRecord::Base
  has_ancestry cache_depth:true, orphan_strategy: :rootify
  attr_accessible :slug, :title, :content, :ancestry

  def to_param
    self.parent ? "#{self.parent.to_param}/#{self.slug}" : self.slug
  end
end
