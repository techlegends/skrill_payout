class PrepareTransfer < Api

  ATTRIBUTES = [:amount, :currency, :bnf_email, :subject, :note, :frn_trn_id]

  def initialize(payout, account = {})
    @payout = payout
    @account = account
  end

  def params
    super(payout, ATTRIBUTES)
  end

  def default_params
    {
      action: 'prepare'
    }.merge(super)
  end

end
