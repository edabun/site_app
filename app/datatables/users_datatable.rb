class UsersDatatable < ApplicationDatatable
  
  private
  
    def data
      users.map do |user|
        [].tap do |column|
          column << link_to(user.name, user)
          column << user.email

          links = []
          links << link_to('Show', user)
          links << link_to('Delete', user, method: :delete, data: { confirm: 'Are you sure?'} )
          column << links.join(' | ')
        end
      end
    end

    def count
      User.count
    end

    def total_entries
      users.total_entries
    end

    def users
      @users ||= fetch_users
    end

    def fetch_users
      search_string= []
      columns.each do |term|
        search_string << "#{term} like :search"
      end

      users = User.order("#{sort_column} #{sort_direction}")
      users = User.page(page).per_page(per_page)
      users = users.where(search_string.join(' or '), search: "%#{params[:search][:value]}%")
    end

    def columns
      %w(name email)
    end
end