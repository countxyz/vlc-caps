RSpec.describe VlcCaps::Options do
  describe 'early exit' do
    it 'when no options are set' do
      expect { described_class.new([]) }.to raise_error SystemExit
    end

    it 'when unrecognized option is set' do
      expect { described_class.new(['-x']) }.to raise_error SystemExit
    end

    it 'when missing arguments' do
      expect { described_class.new(['-f']) }.to raise_error SystemExit
    end
  end
end
