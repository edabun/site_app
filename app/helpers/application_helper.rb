module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'Site App'
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def redirect(title = '')
    if title == "Sign Up"
      signup_path
    else
      nil
    end
  end
end
