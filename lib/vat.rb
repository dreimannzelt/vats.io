require 'json'

class Vat
  attr_accessor :locale, :rates, :names

  class << self
    def rates
      JSON.parse( File.read "data/rates.json" )
    end

    def names
      JSON.parse( File.read "data/names.json" )
    end

    def from_locale(locale)
      self.new(locale)
    end
  end

  #
  # ----
  #

  def initialize(locale)
    @locale = locale
    @rates = self.class.rates[locale]
    @names = self.class.names[locale] || self.class.names["de"]
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
      abbr: abbr,
      name: name,
      rate: rate,
      rates: rates,
      names: names
    }.to_json
  end
end
