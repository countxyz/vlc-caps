module VlcCaps
  class Options
    INTERFACE = '-I dummy screen://'
    TRANSCODE = '{vcodec=h264,vb=800,fps=5,scale=1,acodec=none}'
    SCREEN = { top: 1_080, width: 1_800, height: 1_440 }.freeze
    SAVE_DIRECTORY = '/home/countxyz/Videos/screen_captures/'

    def initialize(argv)
      @file_path = "#{SAVE_DIRECTORY}#{argv[0]}"
      @screen = { top: 1_080, width: 1_800, height: 1_440 }
    end

    def get = "#{INTERFACE} #{screen_position} #{video_options} #{stream_output}"

    private

    def screen_position
      "--screen-top=#{@screen[:top]} --screen-width=#{@screen[:width]} --screen-height=#{@screen[:height]}"
    end

    def video_options = "--no-video :screen-fps=#{screen_fps} :screen-caching=#{screen_caching}"

    def stream_output = "--sout \"#transcode#{TRANSCODE}:duplicate#{duplicate}\""

    def duplicate = "{dst=std{access=file,mux=mp4,dst='#{@file_path}'}}"

    def screen_fps = @screen.fetch(:fps, 30)

    def screen_caching = @screen.fetch(:caching, 300)
  end
end
