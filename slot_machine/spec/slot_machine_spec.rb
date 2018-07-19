require_relative '../lib/slot_machine'

def test_scenario(reels, expected_score)
  it "returns #{expected_score} for #{reels[0]}/#{reels[1]}/#{reels[2]}" do
    expect(slot_machine.score(reels)).to eq expected_score
  end
end

describe SlotMachine do
  let(:slot_machine) {SlotMachine.new}
  describe '#score' do
    describe '#zero condition' do
      test_scenario(%w[joker star cherry], 0)
      test_scenario(%w[star star bell], 0)
      test_scenario(%w[star star seven], 0)
      test_scenario(%w[star star cherry], 0)
      test_scenario(%w[bell bell star], 0)
      test_scenario(%w[bell bell seven], 0)
      test_scenario(%w[bell bell cherry], 0)
      test_scenario(%w[seven seven star], 0)
      test_scenario(%w[seven seven bell], 0)
      test_scenario(%w[seven seven cherry], 0)
      test_scenario(%w[cherry cherry star], 0)
      test_scenario(%w[cherry cherry bell], 0)
      test_scenario(%w[cherry cherry seven], 0)
    end

    describe '#one joker condition' do
      test_scenario(%w[star star joker], 20)
      test_scenario(%w[bell bell joker], 15)
      test_scenario(%w[seven seven joker], 10)
      test_scenario(%w[cherry cherry joker], 5)
    end

    describe '#two jokers condition' do
      test_scenario(%w[joker joker star], 25)
      test_scenario(%w[joker joker bell], 25)
      test_scenario(%w[joker joker seven], 25)
      test_scenario(%w[joker joker cherry], 25)
    end

    describe '#three of the same condition' do
      test_scenario(%w[joker joker joker], 50)
      test_scenario(%w[star star star], 40)
      test_scenario(%w[bell bell bell], 30)
      test_scenario(%w[seven seven seven], 20)
      test_scenario(%w[cherry cherry cherry], 10)
    end
  end
end
