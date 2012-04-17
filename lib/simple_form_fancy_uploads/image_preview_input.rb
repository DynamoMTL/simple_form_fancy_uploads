module SimpleFormFancyUploads
  class ImagePreviewInput < SimpleForm::Inputs::FileInput
    def input
      version = input_html_options.delete(:preview_version)
      use_default_url = options.delete(:use_default_url) || false

      out = ''

      if object.respond_to? "#{attribute_name}?"
        has_attachment = object.send("#{attribute_name}?")
      else
        has_attachment = object.send("#{attribute_name}").present?
      end

      if has_attachment
        attribute = object.send(attribute_name)
        image = attribute

        if version
          if attribute.respond_to? :thumb
            image = attribute.send(:thumb, version)
          elsif attribute.respond_to version
            image = attribute.send(version)
          end
        end

        if defined?(Dragonfly)
        end

        if attribute || use_default_url
          out << template.image_tag(image.send('url'))
        end
      end
      (out << super).html_safe
    end
  end
end
