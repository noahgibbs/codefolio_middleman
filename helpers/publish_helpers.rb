module PublishHelpers
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

  def published_and_sorted(art)
    art.select { |a| is_published(a) }.sort { |a| a.date }
  end

  def next_in_tag(cur, tag)
    return nil if cur.nil?
    raise "No such tag as #{tag.inspect} in #{blog.tags.keys.inspect}!" unless blog.tags[tag]

    published_and_sorted(blog.tags[tag]).detect { |a| a.date > cur.date }
  end

  def prev_in_tag(cur, tag)
    return nil if cur.nil?
    raise "No such tag as #{tag.inspect} in #{blog.tags.keys.inspect}!" unless blog.tags[tag]

    published_and_sorted(blog.tags[tag]).reverse.detect { |a| a.date < cur.date }
  end

  def other_relevant(cur)
    t = cur.tags
    rele = t.flat_map do |tag|
        [next_in_tag(cur, tag), prev_in_tag(cur, tag)]
    end
    rele += [next_published(cur), prev_published(cur)]

    rele.compact.uniq
  end
end
