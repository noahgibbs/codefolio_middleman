xml.instruct!
xml.feed "xmlns" => "http://www.w3.org/2005/Atom" do
  site_url = "http://codefol.io/"
  xml.title "Codefol.io"
  xml.subtitle "Ruby and Rails Stuff"
  xml.id URI.join(site_url, blog.options.prefix.to_s)
  xml.link "href" => URI.join(site_url, blog.options.prefix.to_s)
  xml.link "href" => URI.join(site_url, current_page.path), "rel" => "self"
  xml.updated(blog.articles.first.date.to_time.iso8601) unless blog.articles.empty?
  xml.author { xml.name "Noah Gibbs" }

  to_publish = 6
  blog.articles.each do |article|
    next unless is_published(article)

    xml.entry do
      xml.title article.title
      xml.link "rel" => "alternate", "href" => URI.join(site_url, article.url)
      xml.id URI.join(site_url, article.url)
      xml.published article.date.to_time.iso8601
      xml.updated File.mtime(article.source_file).iso8601
      xml.author { xml.name "Noah Gibbs" }
      # xml.summary article.summary, "type" => "html"
      xml.content article.body, "type" => "html"
    end

    to_publish -= 1
    break if to_publish == 0
  end
end
