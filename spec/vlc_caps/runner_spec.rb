RSpec.describe VlcCaps::Runner do
  it 'runs vlc program with options' do
    argv = ['-f', 'test.mp4']
    vlc = double('vlc')
    options = instance_double('option', get: '')

    allow(VlcCaps::Options).to receive(:new).with(argv) { options }
    allow(Terrapin::CommandLine).to receive(:new).with('vlc', options.get) { vlc }
    expect(vlc).to receive(:run)

    described_class.new(argv).run
  end

  it 'provides instructions on how to stop capture' do
    argv = ['-f', 'test.mp4']
    vlc = double('vlc')
    options = instance_double('option', get: '')

    allow(VlcCaps::Options).to receive(:new).with(argv) { options }
    allow(Terrapin::CommandLine).to receive(:new).with('vlc', options.get) { vlc }
    allow(vlc).to receive(:run)

    expect { described_class.new(argv).run }.to output("Enter CTRL + c to stop capturing\n").to_stdout
  end
end
