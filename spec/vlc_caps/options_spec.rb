RSpec.describe VlcCaps::Options do
  it 'uses default screen position when not specified' do
    opts = described_class.new('')
    expect(opts.screen_positions).to eq(described_class::DEFAULT_SCREEN_POSITIONS)
  end
end
