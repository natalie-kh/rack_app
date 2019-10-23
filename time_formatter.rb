class TimeFormatter

  ALLOWED_FORMATS = { year: '%Y',
              month: '%m',
              day: '%d',
              hour: '%H',
              minute: '%M',
              second: '%S'}.freeze

  def initialize(request)
    @request = request
    @formats = request.params['format']&.split(',')
  end

  def valid_path?
    @request.path_info == '/time'
  end

  def valid_method?
    @request.get?
  end

  def empty_format?
    @formats.nil?
  end

  def valid?
    wrong_formats.empty?
  end

  def result
    valid? ? get_time : wrong_formats
  end

  private

  def wrong_formats
    @formats.reject { |format| ALLOWED_FORMATS[format.to_sym]}
  end

  def get_time
    @formats.map { |format| Time.now.strftime(ALLOWED_FORMATS[format.to_sym])}.join('-')
  end

end
