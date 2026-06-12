# frozen_string_literal: true

def stock_picker(prices)
  best_profit = 0
  best_days = [0, 1]
  min_price = prices[0]
  min_day = 0

  prices.each_with_index do |price, day|
    if price < min_price
      min_price = price
      min_day = day
    end
    profit = price - min_price
    if profit > best_profit
      best_profit = profit
      best_days = [min_day, day]
    end
  end

  best_days
end
