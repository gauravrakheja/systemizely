class HttpFailedResponse < HttpResponse
  def initialize(message, flash =  "danger")
    super(INVALID, message, flash)
  end
end