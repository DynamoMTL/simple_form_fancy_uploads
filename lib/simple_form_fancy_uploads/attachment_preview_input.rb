module SimpleFormFancyUploads
  class AttachmentPreviewInput < SimpleForm::Inputs::FileInput
    def input
      out = ''

      if object.respond_to? "#{attribute_name}?"
        has_attachment = object.send("#{attribute_name}?")
      else
        has_attachment = object.send("#{attribute_name}").present?
      end

      if has_attachment
        attachment = object.send("#{attribute_name}")
        url = attachment.url

        if attachment.respond_to? :filename
          filename = attachment.filename
        elsif attachment.respond_to? :name
          filename = attachment.name
        else
          filename = File.basename(url)
        end
        out << template.link_to(filename, url)
      end
      (out << super).html_safe
    end
  end
end
