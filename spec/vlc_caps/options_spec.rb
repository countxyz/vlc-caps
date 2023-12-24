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

  describe 'program options' do
    it 'saves file with name passed in with -f flag' do
      file_name = 'test.mp4'
      options = described_class.new(['-f', file_name])
      expect(options.get).to include("#{described_class::SAVE_DIRECTORY}#{file_name}")
    end
  end
end
