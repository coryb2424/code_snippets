# Simplified SlotMachine with 3 identitcal or 2+joker rules.
class SlotMachine
  attr_reader :credits

  PLAY_COST = 5
  SYMBOLS = %w[joker star bell seven cherry].freeze
  SYMBOL_MULTIPLIER = {
    'joker'  => 5,
    'star'   => 4,
    'bell'   => 3,
    'seven'  => 2,
    'cherry' => 1
  }.freeze

  def initialize(credits)
    @credits = credits
  end

  def pull_lever
    return "Not enough credits - #{@credits} remaining" if @credits < 2
    @credits -= PLAY_COST
    reels = generate_reels
    score = calculate_score(reels)
    display(reels, score)
  end

  private

  def calculate_score(reels)
    dup = reels.detect { |reel| reels.count(reel) > 1 }
    return 0 if dup.nil?
    dup_count = reels.count(dup)
    return 0 if dup_count == 2 && !reels.include?('joker')
    @credits += if dup_count == 3
                  score = multiplier(dup, 2)
                else
                  score = multiplier(dup)
                end
    score
  end

  def display(reels, score)
    string = '|'
    reels.each do |reel|
      string << " #{reel} |"
    end
    string << "\nScore: #{score}\nCredits Remaining: #{@credits}"
  end

  def generate_reels
    Array.new(3) do
      SYMBOLS.sample
    end
  end

  def multiplier(symbol, modifier = 1)
    SYMBOL_MULTIPLIER[symbol] * 5 * modifier
  end
end
