require_relative 'time_formatter'

class App

  def call(env)
    @request = Rack::Request.new(env)
    @formatter = TimeFormatter.new(@request)

    handle_request
  end

  private

  def handle_request

    if @formatter.valid_path? && @formatter.valid_method?
      get_responce
    else
      responce(404, 'Not found')
    end
  end

  def get_responce
    if @formatter.empty_format?
      responce(400,'Bad Request')
    elsif @formatter.valid?
      responce(200, @formatter.result)
    else
      responce(400, "Unknown time formats: #{@formatter.result}")
    end
  end

  def responce(status, body_text)
    [status, { 'Content-Type' => 'text\plain' }, ["#{body_text}\n"]]
  end

end
