module SitesHelper

  def api_setup
    api = UrlScan::API.new("817ef289-c89a-410f-bc00-6b0ed8a1753b")
  end

  def url_submit(url)
    res = api.submit(url)
  end

  def format_site(url)
    ext = %w[http:// https:// http://www https://www]
    site = url

    ext.each { |x| return site.sub!(x,"") }
  end

  def url_search(url)
    api = UrlScan::API.new("817ef289-c89a-410f-bc00-6b0ed8a1753b")

    return api.search(url)["results"]
  end

  def image(website)
    sc = Gastly.screenshot('http://' + website)
    sc.browser_width = 780 # Default: 1440px
    sc.browser_height = 780 # Default: 900px
    sc.timeout = 1000
    image = sc.capture
    image.format('png')
    image.save(Rails.root.join("app", "assets", "images", "output.png")) 
  end

end
