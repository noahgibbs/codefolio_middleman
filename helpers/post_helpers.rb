module PostHelpers
    def pull_quote(quote, attribution = nil, aside_classes: [], width: 8, direction: :right)
        classes = aside_classes + ["pull-quote", "col-#{width}"]
        classes = classes.join(" ")
        if direction == :right
          classes += " pull-right"
        elsif direction == :left
          classes += " pull-left"
        elsif direction == :none
        else
          raise "Unrecognized aside_image direction: #{direction.inspect}"
        end
        footer = ""
        if attribution
            footer = <<HTML
        <footer>
          - #{attribution}
        </footer
HTML
        end

        <<HTML
<aside class="#{classes}">
    <blockquote>
        <p>&quot;#{quote}&quot;</p>
#{footer}
    </blockquote>
}
</aside>
HTML
    end

    def aside_content(content, div_classes: [], direction: :right, disappear_on_mobile: true)
        classes = (div_classes + [ "inset" ]).join(" ")
        classes += " d-none d-md-block" if disappear_on_mobile
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

    def aside_image(url, alt:, image_classes: ["no-border"], div_classes: [], width: nil, height: nil, caption: nil, direction: :right, disappear_on_mobile: false)
        properties = { src: escape_html(url), alt: escape_html(alt) }
        properties[:width] = width.to_i.to_s unless width.nil?
        properties[:height] = height.to_i.to_s unless height.nil?
        properties[:class] = image_classes.join(" ") unless image_classes.empty?
        props = properties.map { |name, val| "#{name}=\"#{val}\"" }.join(" ")
        image_html = <<HTML
<img #{props} />
#{caption}
HTML
        aside_content(image_html, div_classes: div_classes, direction: direction, disappear_on_mobile: disappear_on_mobile)
    end

end
