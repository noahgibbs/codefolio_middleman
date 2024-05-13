module PostHelpers
    def aside_image(url, alt:, size: :aside, image_classes: [], width: nil, height: nil, direction: :none, caption: nil, disappear_on_mobile: false, lightbox: true)
        figure_classes = ""
        if direction == :right
            figure_classes = "#{size}-right"
        elsif direction == :left
            figure_classes = "#{size}-left"
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
            lightbox: lightbox,
        })
    end

    def full_size_image(url, alt:, image_classes: [], width: nil, height: nil, caption: nil, disappear_on_mobile: false, lightbox: true)
      aside_image(url, alt:, image_classes:, width:, height:, direction: :none, caption:, disappear_on_mobile:, lightbox:, size: :full)
    end

    def asset_image(asset_name, size:, image_classes: [], direction: :none, caption: nil, disappear_on_mobile: true, lightbox: false)
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

        props = asset_properties(asset_name)

        image_classes += ["d-none", "d-md-block"] if disappear_on_mobile
        partial("image-asset", locals: {
            asset: props,
            size: size,
            imageclasses: image_classes.join(" "),
            figureclasses: figure_classes,
            caption: caption,
            lightbox: lightbox,
        })
    end

    def asset_properties(asset_name)
        asset_dir = File.join(__dir__, "..", "assets")
        asset_gen = File.join(asset_dir, "#{asset_name}.gen_json")
        props = JSON.load(File.read asset_gen)
    end

    def asset_img_tag(asset_name, size:, classes: [])
        props = asset_properties(asset_name)
        raise "No such asset found as #{asset_name}!" unless props

        image_url = props["#{size}_dims_url"]
        raise "No such asset URL found as #{size}_dims_url!" unless image_url
        image_width = props["#{size}_w"]
        image_height = props["#{size}_h"]
        image_alt = props["alt"]

        tag_props = "src=\"#{escape_html(image_url)}\" "
        tag_props += "height=\"#{image_height}\"" if image_height
        tag_props += "width=\"#{image_width}\"" if image_width
        tag_props += "alt=#{image_alt}" if image_alt
        tag_props += "class=\"#{classes.join(" ")}\"" unless classes.empty?

        "<img #{tag_props} />"
    end
end
