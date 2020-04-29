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

    def asset_image(asset_name, size: :thumbnail, image_classes: [], direction: :none, caption: nil, disappear_on_mobile: false)
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
        })
    end

    def asset_properties(asset_name)
        asset_dir = File.join(__dir__, "..", "assets")
        asset_gen = File.join(asset_dir, "#{asset_name}.gen_json")
        props = JSON.load(File.read asset_gen)
    end
end
