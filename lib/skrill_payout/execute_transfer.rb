class ExecuteTransfer < Api

  ATTRIBUTES = [:sid]

  def initialize(payout, account = {})
    @payout = payout
    @account = account
  end

  def params
    super(payout, ATTRIBUTES)
  end

  def default_params
    {
      action: 'transfer'
    }.merge(super)
  end

end
