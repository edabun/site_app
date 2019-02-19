class SitesDatatable < ApplicationDatatable
  # delegate :edit_user_path, to: :@view

  private

    def data
      sites.map do |site|
        [].tap  do |column|
          column << site.name
          column << site.user.name

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
      # sites.total_count # kaminari
      sites.total_entries # (will_paginate)
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
      # sites = sites.page(page).per(per_page)  # kaminari
      sites = sites.where(search_string.join(' or '), search: "%#{params[:search][:value]}%")
      sites = Site.page(page).per_page(per_page) # will_paginate
    end

    def columns
      %w(name user.name)
    end
end