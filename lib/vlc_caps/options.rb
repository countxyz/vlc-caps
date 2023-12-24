require 'optparse'

module VlcCaps
  class Options
    INTERFACE = '-I dummy screen://'
    TRANSCODE = '{vcodec=h264,vb=800,fps=5,scale=1,acodec=none}'
    SCREEN = { top: 1_080, width: 1_800, height: 1_440, fps: 30, caching: 300 }.freeze
    SAVE_DIRECTORY = '/home/countxyz/Videos/screen_captures/'

    def initialize(argv) = parse(argv)

    def get = "#{INTERFACE} #{screen_position} #{video_options} #{stream_output}"

    private

    def parse(argv)
      OptionParser.new do |opts|
        opts.banner = 'Usage: vlc_caps [ options ]'

        opts.on('-f', '--file_name file_name', String, 'Name to save file as') do |file_name|
          @file_path = "#{SAVE_DIRECTORY}#{file_name}"
        end

        opts.on('-h', '--help', 'Show this message') do
          puts opts
          exit
        end

        begin
          argv = ['-h'] if argv.empty?
          opts.parse!(argv)
        rescue OptionParser::ParseError => e
          warn e.message, '\n', opts
          exit(-1)
        end
      end
    end

    def screen_position
      "--screen-top=#{SCREEN[:top]} --screen-width=#{SCREEN[:width]} --screen-height=#{SCREEN[:height]}"
    end

    def video_options = "--no-video :screen-fps=#{SCREEN[:fps]} :screen-caching=#{SCREEN[:caching]}"

    def stream_output = "--sout \"#transcode#{TRANSCODE}:duplicate#{duplicate}\""

    def duplicate = "{dst=std{access=file,mux=mp4,dst='#{@file_path}'}}"
  end
end
