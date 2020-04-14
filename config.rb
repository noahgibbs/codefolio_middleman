###
# Page options, layouts, aliases and proxies
###

set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true, :smartypants => true

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false
page '/*.pdf', layout: false
page '/links/*', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  # blog.prefix = "blog"

  blog.permalink = "posts/{slug}.html"
  # Matcher for blog source files
  blog.sources = "posts/{year}-{month}-{day}-{slug}.html"
  # blog.summary_separator = /\<\!\-\-\ more\ \-\-\>/
  # blog.summary_length = 250
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  # blog.default_extension = ".markdown"

  # Generally speaking, I want future-dated posts to *exist*,
  # but not to put them on the front page or in RSS.
  # So they have to count as published for Middleman, but
  # I have to not put them on the front page.
  blog.publish_future_dated = true

  blog.layout = "horace_post"

  blog.tag_template = "tag.html"
  blog.calendar_template = "calendar.html"

  # Enable pagination
  blog.paginate = true
  blog.per_page = 10
  blog.page_link = "page/{num}"
end

activate :directory_indexes

page "/feed.xml", layout: false
# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

# Methods defined in the helpers block are available in templates
helpers do
  def is_published(article)
     return false if article.data.front_page == false
     return false if article.date > Time.now
     return false unless article.published?
     true
  end
  def next_published(cur)
    return nil if cur.nil?
    cur.blog_data.articles.select { |a| is_published(a) && a != cur }.reverse.find { |a| a.date >= cur.date }
  end
  def prev_published(cur)
    return nil if cur.nil?
    cur.blog_data.articles.select { |a| is_published(a) && a != cur }.find { |a| a.date <= cur.date }
  end
end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript
end

# Middleman-syntax, which uses Rouge under the hood
activate :syntax
