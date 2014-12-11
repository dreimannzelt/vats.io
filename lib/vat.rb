require 'json'

class Vat
  attr_accessor :code, :rates, :names

  class << self
    def rates
      JSON.parse( File.read "data/rates.json" )
    end

    def names
      JSON.parse( File.read "data/names.json" )
    end

    def from_code(code)
      self.new(code)
    end
  end

  #
  # ----
  #

  def initialize(code)
    @code = code
    @rates = self.class.rates[code]
    @names = self.class.names[code] || self.class.names["de"]
  end

  def rate
    rates["standard"].to_f
  end

  def abbr
    names[0][0]
  end

  def name
    names[0][1]
  end


  def to_json(options)
    {
      code: code,
      abbr: abbr,
      name: name,
      rate: rate
    }.to_json
  end
end
