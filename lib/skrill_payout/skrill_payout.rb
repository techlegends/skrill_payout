module SkrillPayout

  attr_accessor :sid

  def bnf_email
    recipient_email
  end

  def frn_trn_id
    reference_id
  end

  def pay!(account = {})
    prepare_transfer = PrepareTransfer.new(self, account).call

    self.sid = prepare_transfer['sid'][0]

    !!ExecuteTransfer.new(self, account).call
  end

end
