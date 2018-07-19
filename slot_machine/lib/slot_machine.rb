# Simplified SlotMachine with 3 identitcal or 2+joker rules.
class SlotMachine
  SYMBOLS = %w[joker star bell seven cherry].freeze
  SYMBOL_MULTIPLIER = {
    'joker' => 5,
    'star' => 4,
    'bell' => 3,
    'seven' => 2,
    'cherry' => 1
  }.freeze

  def pull_lever
    reels = generate_reels
    score(reels)
  end

  def score(reels)
    dup = reels.detect { |reel| reels.count(reel) > 1 }
    return 0 if dup.nil?

    dup_count = reels.count(dup)
    return 0 if dup_count == 2 && !reels.include?('joker')

    dup_count == 3 ? multiplier(dup, 2) : multiplier(dup)
  end

  private

  def generate_reels
    Array.new(3) do
      SYMBOLS.sample
    end
  end

  def multiplier(symbol, modifier = 1)
    SYMBOL_MULTIPLIER[symbol] * 5 * modifier
  end
end
