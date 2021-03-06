require 'test_helper'

class StockTest < ActiveSupport::TestCase
  def setup
    @stock = stocks(:one)
  end

  test 'valid stock' do
    assert @stock.valid?
  end

  test 'invalid without stock' do
    @stock.symbol = nil
    refute @stock.valid?
    assert_not_nil @stock.errors[:stock]
  end

  test 'valid quote' do
    $redis.del(@stock.symbol)
    assert @stock.quote
  end
end
