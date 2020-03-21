require 'spec_helper'

describe PrepareTransfer do

  before do
    @payout           = Payout.new
    @prepare_transfer = PrepareTransfer.new(@payout)
  end

  it 'returns all required params' do

    params = @prepare_transfer.params

    PrepareTransfer::ATTRIBUTES.each do |attribute|
      expect(params.include?(attribute)).to eq true
    end
  end

  it 'merge parent default params' do

    expect(@prepare_transfer.default_params.include?(:email)).to eq true
  end

  it 'must contain specified attributes' do

    expect(PrepareTransfer::ATTRIBUTES).to_not eq nil
  end
end
