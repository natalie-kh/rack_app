class TimeFormat

  ALLOWED_FORMATS = { year: '%Y',
              month: '%m',
              day: '%d',
              hour: '%H',
              minute: '%M',
              second: '%S'}.freeze

  def initialize(formats_string)
    @formats = formats_string.split(',')
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
