require 'spec_helper'

class Dummie < SkrillApi;

  def initialize(payout, account = {})
    @payout = payout
    @account = account
  end

end

describe Api do

  it 'creates params -> values from object, keys from attributes' do

    object      = double('Payout', currency: 'CZK', amount: 10, user_id: 20)
    attributes  = [:currency, :amount]
    dummie      = Dummie.new(Payout.new)
    params      = dummie.send(:params, object, attributes)

    expect(params).to eq({ currency: 'CZK', amount: 10 })
  end

  it 'creates default params from config' do

    params = Dummie.new(Payout.new).send(:default_params)

    expect(params).to eq(
      {
        email:    'michal.macejko1@gmail.com',
        password: '2347237842346234623476276'
      }
    )
  end

  it 'creates default params from account parameter' do

    account = { email: 'michal@macejko.sk', password: 'stefan' }
    params  = Dummie.new(Payout.new, account).send(:default_params)

    expect(params).to eq(
      {
        email:    'michal@macejko.sk',
        password: 'stefan'
      }
    )
  end
end
