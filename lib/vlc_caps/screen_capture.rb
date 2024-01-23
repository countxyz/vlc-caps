module VlcCaps
  class ScreenCapture
    INTERFACE = '-I dummy screen://'
    OLDRC = '--extraintf oldrc --rc-host localhost:8082'
    TRANSCODE = '{vcodec=h264,vb=2048,acodec=none}'
    VIDEO_OPTIONS = "--no-video :screen-fps=30 :screen-caching=300"
    SCREEN = {
      browser: { left: 0, top: 1_120, width: 1_920, height: 1_350 },
      terminal: { left: 2_270, top: 110, width: 1_890, height: 960 }
    }.freeze
    SAVE_DIRECTORY = '/home/countxyz/Videos/screen_captures/'

    def initialize(application:, file_name:)
      @application = application
      @file_name = file_name
    end

    def get = Terrapin::CommandLine.new('vlc', vlc_options).run

    private

    def vlc_options = "#{INTERFACE} #{OLDRC} #{capture_location} #{VIDEO_OPTIONS} #{stream_output}"

    def capture_location = "#{screen_location} #{screen_size}"

    def screen_location = "--screen-left=#{screen_application[:left]} --screen-top=#{screen_application[:top]}"

    def screen_size = "--screen-width=#{screen_application[:width]} --screen-height=#{screen_application[:height]}"

    def stream_output = "--sout \"#transcode#{TRANSCODE}:duplicate#{duplicate}\""

    def duplicate = "{dst=std{access=file,mux=mp4,dst='#{file_path}'}}"

    def file_path = "#{SAVE_DIRECTORY}#{@file_name}"

    def screen_application = SCREEN[@application]
  end
end
