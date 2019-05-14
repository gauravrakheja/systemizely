class HttpResponse
  VALID   = "valid".freeze
  INVALID = "invalid".freeze

  attr_reader :status, :message, :flash

  def initialize(status, message, flash)
    @status  = status
    @message = message
    @flash   = flash
  end

  def valid?
    status.eql?(VALID)
  end
end