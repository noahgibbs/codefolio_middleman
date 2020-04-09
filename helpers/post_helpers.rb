module PostHelpers
    def aside_image(url, alt:, image_classes: [], width: nil, height: nil, direction: :none, caption: nil, disappear_on_mobile: false)
        figure_classes = ""
        if direction == :right
            figure_classes = "aside-right"
        elsif direction == :left
            figure_classes = "aside-left"
        elsif direction == :none
            # Nothing
        else
            raise "Unknown direction: #{direction.inspect}"
        end

        image_classes += ["d-none", "d-md-block"] if disappear_on_mobile
        partial("image-caption", locals: {
            imageurl: url,
            alt: alt,
            width: width,
            height: height,
            imageclasses: image_classes.join(" "),
            figureclasses: figure_classes,
            caption: caption,
            direction: direction,
        })
    end

#    def lightbox_image(url, thumbnail, alt:, image_classes: ["no-border", "img-fluid"], width: nil, height: nil)
#        properties = { src: escape_html(url), alt: escape_html(alt) }
#        properties[:width] = width.to_i.to_s unless width.nil?
#        properties[:height] = height.to_i.to_s unless height.nil?
#        properties[:class] = image_classes.join(" ") unless image_classes.empty?
#        props = properties.map { |name, val| "#{name}=\"#{val}\"" }.join(" ")
#        image_html = <<HTML
#<a href="#{escape_html(thumbnail)}" data-toggle="lightbox">
#<img #{props} /></a>
#HTML
#    end
end
