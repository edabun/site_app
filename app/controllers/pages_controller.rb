class PagesController < ApplicationController
  def home
  	if logged_in?
      @site = current_user.sites.build
      @sites_list = current_user.site_list.paginate(page: params[:page])
    # else
      # @sites = Site.all
    end
  end

  def about
  end
end
