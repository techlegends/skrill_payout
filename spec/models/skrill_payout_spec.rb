require 'spec_helper'

describe SkrillPayout do

  before do
    @payout = Payout.new

    @prepare_success_response = '<?xml version="1.0" encoding="UTF-8"?>' \
      '<response><sid>5e281d1376d92ba789ca7f0583e045d4</sid> </response>'
    @prepare_error_response   = '<?xml version="1.0" encoding="UTF-8"?> ' \
      '<response><error><error_msg>M_AMOUNT</error_msg></error></response>'
    @execute_success_response = '<?xml version="1.0" encoding="UTF-8"?> ' \
    '<response> <transaction><amount>1.20</amount> <currency>EUR</currency>' \
    '<id>497029</id><status>2</status> <status_msg>processed</status_msg> ' \
    '</transaction></response>'
    @execute_error_response   = '<?xml version="1.0" encoding="UTF-8"?> ' \
    '<response><error><error_msg>M_AMOUNT</error_msg></error></response>'
  end

  describe '#pay!' do

    it 'raise error -> Prepare transfer error' do

      stub_request(:get, /action=prepare/).
        with(headers: { 'Accept'=>'*/*' }).
        to_return(status: 200, body: @prepare_error_response, headers: {})

      expect{ @payout.pay! }.to raise_error(SkrillPayoutException)
    end

    it 'raise error -> Execute transfer error' do

      stub_request(:get, /action=prepare/).
        with(headers: { 'Accept'=>'*/*' }).
        to_return(status: 200, body: @prepare_success_response, headers: {})

      stub_request(:get, /action=transfer/).
        with(headers: { 'Accept'=>'*/*' }).
        to_return(status: 200, body: @execute_error_response, headers: {})

      expect{ @payout.pay! }.to raise_error(SkrillPayoutException)
    end

    context 'success responses' do

      before do

        stub_request(:get, /action=prepare/).
          with(headers: { 'Accept'=>'*/*' }).
          to_return(status: 200, body: @prepare_success_response, headers: {})

        stub_request(:get, /action=transfer/).
          with(headers: { 'Accept'=>'*/*' }).
          to_return(status: 200, body: @execute_success_response, headers: {})
      end

      it 'returns true' do
        expect(@payout.pay!).to eq true
      end

      it 'set attribute sid for payout' do

        @payout.pay!

        expect(@payout.sid).to_not eq nil
      end
    end
  end
end
