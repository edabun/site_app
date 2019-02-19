module SitesHelper

  def api_setup
    api = UrlScan::API.new("817ef289-c89a-410f-bc00-6b0ed8a1753b")
  end

  def url_submit(url)
    res = api.submit(url)
  end

  def url_search(url)
    api = UrlScan::API.new("817ef289-c89a-410f-bc00-6b0ed8a1753b")
    ext = %w[http:// https://]
    site = url

    ext.each { |x| site.sub!(x,"") }
    return api.search(site)["results"]
  end
end
