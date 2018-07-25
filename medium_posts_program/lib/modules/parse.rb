module ParseModule
   def parse_post(post_path)
    html_file = open(MEDIUM_BASE_URL + post_path)
    html_doc = Nokogiri::HTML(html_file)

    attributes = {}
    attributes[:path] = post_path
    attributes[:title] = html_doc.at('.graf--title').text.strip
    attributes[:author] = html_doc.at('.ds-link', '.ds-link--styleSubtle').text.strip
    attributes[:text] = html_doc.at('.section-content').children.last.search('p').to_a.map do |sentence|
      sentence.text + "\n"
    end.join
    return attributes
  end
end
