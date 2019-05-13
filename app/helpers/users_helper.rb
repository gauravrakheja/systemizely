module UsersHelper
  def current_house
    @current_house ||= find_current_house
  end

  def find_current_house
    cookie_value = cookies.permanent[:current_house_id]
    if cookie_value.present?
      House.find(cookie_value)
    end
  end
end
