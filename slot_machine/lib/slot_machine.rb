# Simplified SlotMachine with 3 identitcal or 2+joker rules.
class SlotMachine
  SYMBOL_MULTIPLIER = {
    'joker' => 5,
    'star' => 4,
    'bell' => 3,
    'seven' => 2,
    'cherry' => 1
  }.freeze

  def score(reels)
    return 0 unless (dup = reels.detect { |reel| reels.count(reel) > 1 })
    dup_count = reels.count(dup)
    if dup_count == 3
      multiplier(dup, 2)
    elsif reels.include? 'joker'
      multiplier(dup)
    else
      0
    end
  end

  def multiplier(symbol, modifier = 1)
    SYMBOL_MULTIPLIER[symbol] * 5 * modifier
  end
end
