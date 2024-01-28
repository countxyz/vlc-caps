RSpec.describe VlcCaps::ScreenCapture do
  it 'assembles command to run with VLC to capture screen' do
    application = :browser
    command = "#{INTERFACE} #{OLDRC} #{capture_location} #{VIDEO_OPTIONS} #{stream_output}"
    vlc_options = double('vlc_options', command: command)
    expect(Terrapin::CommandLine).to receive(:new).with('vlc', vlc_options.command)

    described_class.new(application: application, file_name: 'test.mp4').get
  end
end
