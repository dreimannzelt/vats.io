require 'bigdecimal'

class BigDecimal
  def to_json(options)
    self.to_f.round(2).to_json
  end
end

class Conversion
  attr_accessor :from, :to, :amount, :options

  class << self
    def convert(from, to, amount, opts={})
      self.class.new(from, to, amount, opts)
    end
  end

  def initialize(from, to, amount, opts={})
    @from   = Vat.from_code( from )
    @to     = Vat.from_code( to )
    @amount = BigDecimal.new amount

    @options = {
      is_net: true,
      needs_net: false
    }.merge(opts)
  end

  def net
    is_net? ?
      (@amount) :
      (@amount / (100 + from.rate) * 100)
  end

  def gross
    is_net? ?
      (@amount * (100 + to.rate) / 100) :
      (@amount / (100 + from.rate) * (100 + to.rate))
  end

  def amount
    needs_net? ?
      (net) :
      (gross)
  end

  def vat_amount
    is_net? ?
      (gross - net) :
      (gross - net)
  end

  def is_net?
    options[:is_net]
  end

  def needs_net?
    options[:needs_net]
  end
end
