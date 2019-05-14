class HttpSuccessResponse < HttpResponse
  def initialize(message, flash = "success")
    super(VALID, message, flash)
  end
end