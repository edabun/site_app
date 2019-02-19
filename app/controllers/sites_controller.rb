class SitesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy] 
  before_action :correct_user,   only: [:destroy]
  # before_action :admin_user,   only: [:index, :destroy]
  before_action :admin_user,     only: :index

  def show
    @site = Site.find(params[:id])
  end
  
  def index
    # @sites = Site.paginate(page: params[:page])
    # if params[:name]
    #   @site = Site.where('name LIKE ?', "%#{params[:name]}%")
    # else
    #   @site = Site.all
    # end
    respond_to do |format|
      format.html
      format.json { render json: SitesDatatable.new(view_context) }
    end
  end

  def create
    @site = current_user.sites.build(site_params)
    if @site.save
      flash[:success] = "Site created!"
      redirect_to root_url
    else
      @sites_list = []
      render 'pages/home'
    end
  end

  def destroy
    @site.destroy
    flash[:success] = "Site deleted"
    redirect_to request.referrer || root_url
  end

  private

    def site_params
      params.require(:site).permit(:name)
    end

    def correct_user
      @site = current_user.sites.find_by(id: params[:id])
      redirect_to root_url if @site.nil?
    end

    def admin_user
      unless current_user.present? && current_user.admin?
        # flash[:danger] = "Please log in."
        # redirect_to login_url
        redirect_to root_url
      end
    end
end
