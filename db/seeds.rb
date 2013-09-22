# encoding: utf-8

Page.delete_all
content = '**Этот текст выделен жирным**, \\\\этот текст выделен курсивом\\\\, ((страница1 этот текст сделан ссылкой))'
1000.times do |i|
  p = Page.create slug:"страница#{i}", title:"Страница #{i}", content:content
  3.times do |j|
    pp = p.children.create slug:"страница#{i}_#{j}", title:"Страница #{i}-#{j}", content:content
    3.times do |k|
      ppp = pp.children.create slug:"страница#{i}_#{j}_#{k}", title:"Страница #{i}-#{j}-#{k}", content:content
      ppp.children.create slug:"страница#{i}_#{j}_#{k}_1", title:"Страница #{i}-#{j}-#{k}_1", content:content
    end
  end
end