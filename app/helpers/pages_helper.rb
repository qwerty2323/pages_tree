module PagesHelper
  def nested_pages(pages)
    return if pages.blank?
    html = ''
    pages.collect do |page, subpages|
      html << "
        <li>
          #{link_to page.title, page}
          <sup>
            #{link_to 'e', edit_page_path(page)}
            #{link_to '+', new_page_path(page)}
          </sup>
          #{nested_pages subpages}
        </li>
      "
    end
    content_tag :ul, html.html_safe
  end
end
