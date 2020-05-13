class SkrillApi

  BASE_URL = 'https://www.moneybookers.com/app/pay.pl'

  attr_reader :payout, :account

  def call
    response  = connection.get '', params.merge(default_params)
    data      = XmlSimple.xml_in(response.body)

    if data['error']
      raise SkrillPayoutException, data['error']
    end

    data
  end

  protected

  def params(object, attributes)
    request_params = {}
    attributes.each do |attribute|
      request_params[attribute] = object.send(attribute)
    end
    request_params
  end

  def default_params
    {
      email:    account[:email]    || SkrillPayout.configuration.email,
      password: account[:password] || SkrillPayout.configuration.password
    }
  end

  private

  def connection
    if ENV.has_key?('QUOTAGUARDSTATIC_URL')
      Faraday.new(url: BASE_URL, proxy: ENV['QUOTAGUARDSTATIC_URL'])
    else
      Faraday.new(url: BASE_URL)
    end
  end

end
