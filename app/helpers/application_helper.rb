module ApplicationHelper
  def with_protocol(url)
    if url && !url_protocol_present?(url)
      "http://#{url}"
    else
      url
    end
  end

  def url_protocol_present?(url)
    url[/\Ahttp:\/\//] || url[/\Ahttps:\/\//]
  end
end
