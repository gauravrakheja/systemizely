class CurrentHouseService
  attr_reader :house_id, :session, :house

  def initialize(house_id:, session:)
    @house_id = house_id
    @session  = session
    set_house
  end

  def run
    session[:current_house_id] = house.id
    HttpSuccessResponse.new("Current House Updated")
  end

  private
  attr_writer :house

  def set_house
    self.house = House.find(house_id)
  rescue ActiveRecord::RecordNotFound
    raise ResponseError.new("House could not be set")
  end
end