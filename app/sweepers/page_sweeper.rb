class PageSweeper < ActionController::Caching::Sweeper
  observe Page

  # http://softwareas.com/rails-cache-sweeper-gotchas
  def after_save(page)
    Rails.cache.delete 'roots' if page.root?
    ActionController::Base.new.expire_fragment 'index' if page.new_record? or page.title_changed?
    if page.new_record? or page.title_changed? or page.content_changed?
      page.ancestor_ids.each do |id|
        ActionController::Base.new.expire_fragment id
        Rails.cache.delete id
      end
    end
  end

end
