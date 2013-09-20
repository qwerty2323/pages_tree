# encoding: utf-8
class Page < ActiveRecord::Base
  has_ancestry cache_depth:true, orphan_strategy: :rootify
  attr_accessible :slug, :title, :content, :ancestry
  validates :slug, format:{with:/[\wа-яА-Я]+/i, message:'Chars, digits and underscore only'}

  before_save :setup_before_save



  def formatted_content
    return '' unless self.content
    self.content.gsub!(/\<b\>(.+?)\<\/b\>/im){"**#{$1}**"} # <b>[строка]</b> => **[строка]**
    self.content.gsub!(/\<i\>(.+?)\<\/i\>/im){"\\\\#{$1}\\\\"} # <i>[строка]</i> => \\[строка]\\
    self.content.gsub!(/\<a\s+?href="\/([\wа-яА-Я\/]+?)"\>(.+?)\<\/a\>/im){"((#{$1} #{$2}))"} # <a href="/name1/name2/name3">[строка]</a> => ((name1/name2/name3 [строка]))
  end
  def to_param
    self.parent ? "#{self.parent.to_param}/#{self.slug}" : self.slug
  end



  private

  def setup_before_save
    if self.content
      self.content.gsub!(/\*\*(.+?)\*\*/im){"<b>#{$1}</b>"} # **[строка]** => <b>[строка]</b>
      self.content.gsub!(/\\\\(.+?)\\\\/im){"<i>#{$1}</i>"} # \\[строка]\\ => <i>[строка]</i>
      self.content.gsub!(/\(\(([\wа-яА-Я\/]+?)\s(.+?)\)\)/im){"<a href=\"/#{$1}\">#{$2}</a>"} # ((name1/name2/name3 [строка])) => <a href="/name1/name2/name3">[строка]</a>
    end
  end
end
