module PostHelpers
    def aside_content(content, direction: :right, disappear_on_mobile: true)
        classes = "inset"
        classes += " d-none d-sm-block" if disappear_on_mobile
        if direction == :right
          classes += " pull-right"
        elsif direction == :left
          classes += " pull-left"
        else
          raise "Unrecognized aside_image direction: #{direction.inspect}"
        end

        <<HTML
<div class=#{classes.inspect}>
  #{content}
</div>
HTML
    end

    def aside_image(url, alt:, width: nil, height: nil, caption: nil, direction: :right, disappear_on_mobile: false)
        properties = { src: escape_html(url), alt: escape_html(alt) }
        properties[:width] = width.to_i.to_s unless width.nil?
        properties[:height] = height.to_i.to_s unless height.nil?
        props = properties.map { |name, val| "#{name}=\"#{val}\"" }.join(" ")
        image_html = <<HTML
<img #{props} />
#{caption}
HTML
        aside_content(image_html, direction: direction, disappear_on_mobile: disappear_on_mobile)
    end

end
