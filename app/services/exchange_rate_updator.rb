# frozen_string_literal: true

class ExchangeRateUpdator
  def self.update
    payload = ExchangeRateApiClient.new.latest
    rates = payload.fetch(:rates)
    base_iso = payload.fetch(:base)

    results = rates.map do |target_iso, multiplier|
      ExchangeRate.add_rate(base_iso, target_iso, multiplier)
    end

    results.none?(&:nil?)
  end
end
