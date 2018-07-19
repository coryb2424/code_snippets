require_relative '../lib/slot_machine'

def test_scenario_reels(reels, expected_score)
  it "returns #{expected_score} for #{reels[0]}/#{reels[1]}/#{reels[2]}" do
    expect(slot_machine.send(:calculate_score, reels)).to eq expected_score
  end
end

describe SlotMachine do
  let(:slot_machine) { SlotMachine.new(100) }

  describe '#calculate_score' do
    describe '- zero' do
      test_scenario_reels(%w[joker star cherry], 0)
      test_scenario_reels(%w[star star bell], 0)
      test_scenario_reels(%w[star star seven], 0)
      test_scenario_reels(%w[star star cherry], 0)
      test_scenario_reels(%w[bell bell star], 0)
      test_scenario_reels(%w[bell bell seven], 0)
      test_scenario_reels(%w[bell bell cherry], 0)
      test_scenario_reels(%w[seven seven star], 0)
      test_scenario_reels(%w[seven seven bell], 0)
      test_scenario_reels(%w[seven seven cherry], 0)
      test_scenario_reels(%w[cherry cherry star], 0)
      test_scenario_reels(%w[cherry cherry bell], 0)
      test_scenario_reels(%w[cherry cherry seven], 0)
    end

    describe '- one joker' do
      test_scenario_reels(%w[star star joker], 20)
      test_scenario_reels(%w[bell bell joker], 15)
      test_scenario_reels(%w[seven seven joker], 10)
      test_scenario_reels(%w[cherry cherry joker], 5)
    end

    describe '- two jokers' do
      test_scenario_reels(%w[joker joker star], 25)
      test_scenario_reels(%w[joker joker bell], 25)
      test_scenario_reels(%w[joker joker seven], 25)
      test_scenario_reels(%w[joker joker cherry], 25)
    end

    describe '- three of the same' do
      test_scenario_reels(%w[joker joker joker], 50)
      test_scenario_reels(%w[star star star], 40)
      test_scenario_reels(%w[bell bell bell], 30)
      test_scenario_reels(%w[seven seven seven], 20)
      test_scenario_reels(%w[cherry cherry cherry], 10)
    end
  end

  describe '#generate_reels' do
    it 'generates different reels' do
      reels1 = slot_machine.send(:generate_reels)
      reels2 = slot_machine.send(:generate_reels)

      expect(reels1).to_not eq reels2
    end
  end

  describe '#credits' do
    let(:slot_machine) { SlotMachine.new(2) }

    it 'should increase/decrease' do
      expect(slot_machine.pull_lever).to_not eq 2
    end

    let(:empty_slot_machine) { SlotMachine.new(0) }
    it 'returns message if there aren\'t enough credits' do
      expect(empty_slot_machine.pull_lever).to eq 'Not enough credits - 0 remaining'
    end
  end
end
