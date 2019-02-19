class SitesDatatable < ApplicationDatatable
  # delegate :edit_user_path, to: :@view

  private

    def data
      sites.map do |site|
        [].tap  do |column|
          column << site.name

          links = []
          links << link_to('Show', site)
          links << link_to('Delete', site, method: :delete, data: { confirm: 'Are you sure?'} )
          column << links.join(' | ')
        end
      end
    end

    def count
      Site.count
    end

    def total_entries
      sites.total_entries
    end

    def sites
      @sites ||= fetch_sites
    end

    def fetch_sites
      search_string = []
      columns.each do |term|
        search_string << "#{term} like :search"
      end

      sites = Site.order("#{sort_column} #{sort_direction}")
      sites = Site.page(page).per_page(per_page)
      sites = sites.where(search_string.join(' or '), search: "%#{params[:search][:value]}%")
    end

    def columns
      %w(name)
    end
end