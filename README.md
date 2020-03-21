# SkrillPayout

Based on SkrillPayments by macejmic

## Installation

Add this line to your application's Gemfile:

    gem 'skrill_payout'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install skrill_payout

Create a configuration file for Skrill Payout.

    $ touch config/initializers/skrill_payout.rb

With following content.

    SkrillPayout.configure do |config|
      config.email     = 'user@domain.com'
      config.password  = 'md5skrillapipassword'
    end

## Usage

### SEND MONEY USING AN HTTPS REQUEST

Put this code into your Payout class.

    include SkrillPayout

Your Payout class must contain all attributes/methods which is required for transfer money.

    [:amount, :currency, :recipient_email, :subject, :note, :reference_id]
    # :reference_id is optional attribute

For example:

    class Payout

      include SkrillPayout

      def amount
        price + fees
      end

      def currency
        bank.czech? ? 'CZK' : 'ENG'
      end

      def recipient_email
        client.email
      end

      def subject
        'My super subject'
      end

      def note
        'Money for your service'
      end

      def reference_id
        id
      end

    end

  And in your controller just put the following code:

    def pay_for_service
      payout = Payout.find(params[:id])
      begin
        payout.pay!
      rescue SkrillPayoutException => e
        # do stuff
      end
      redirect_to payments_path
    end

### SEND MONEY FROM DIFFERENT SKRILL ACCOUNT

If you want to send money from different Skrill account (different email and password than from the config). Just add following params in pay! method.
  
    def pay_for_service
      payout = Payout.find(params[:id])
      begin
        payout.pay!(email: 'account_2@macejko.sk', password: 'sadnuasndasdasd')
      rescue SkrillPayoutException => e
        # do stuff
      end
      redirect_to payments_path
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
