module ApplicationHelper

    def urls_to_links(s)
        s.gsub! /\s(http:\/\/.*?)\s/,
            '<p><a href="\1">\1</a></p>'
            
        s.html_safe
    end

end
