module VlcCaps
  class ScreenCapture
    INTERFACE = '-I dummy screen://'
    OLDRC = '--extraintf oldrc --rc-host localhost:8082'
    TRANSCODE = '{vcodec=h264,vb=800,fps=5,scale=1,acodec=none}'
    SCREEN = { top: 1_080, width: 1_920, height: 1_440, fps: 30, caching: 300 }.freeze
    SAVE_DIRECTORY = '/home/countxyz/Videos/screen_captures/'

    def initialize(file_name)
      @file_name = file_name
    end

    def get = Terrapin::CommandLine.new('vlc', vlc_options).run

    private

    def vlc_options = "#{INTERFACE} #{OLDRC} #{screen_position} #{video_options} #{stream_output}"

    def screen_position
      "--screen-top=#{SCREEN[:top]} --screen-width=#{SCREEN[:width]} --screen-height=#{SCREEN[:height]}"
    end

    def video_options = "--no-video :screen-fps=#{SCREEN[:fps]} :screen-caching=#{SCREEN[:caching]}"

    def stream_output = "--sout \"#transcode#{TRANSCODE}:duplicate#{duplicate}\""

    def duplicate = "{dst=std{access=file,mux=mp4,dst='#{file_path}'}}"

    def file_path = "#{SAVE_DIRECTORY}#{@file_name}"
  end
end
