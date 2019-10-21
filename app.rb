require_relative 'time_format'

class App

  def call(env)
    @request = Rack::Request.new(env)

    handle_request(env['PATH_INFO'])
  end

  private

  def handle_request(path)

    if path == '/time' && @request.get?
      get_responce
    else
      responce(404, 'Not found')
    end
  end

  def get_responce

    return responce(400,'Bad Request') if @request.params['format'].nil? || @request.params['format'].empty?

    time_format = TimeFormat.new(@request.params['format'])

    time_format.valid? ? responce(200, time_format.result) : responce(400, "Unknown time formats: #{time_format.result}")

  end

  def responce(status, body_text)
    [status, { 'Content-Type' => 'text\plain' }, ["#{body_text}\n"]]
  end

end
