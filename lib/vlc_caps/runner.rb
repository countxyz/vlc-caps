require 'socket'
require 'io/console'

module VlcCaps
  class Runner
    def initialize(argv)
      @options = Options.new(argv)
    end

    def run
      capture_video
      convert_video_to_gif
    end

    private

    def capture_video
      threads = []
      threads << Thread.new { ScreenCapture.new(file_name).get } << Thread.new { stop_capture }
      threads.each(&:join)
    end

    def stop_capture
      sleep 3
      wait_for_user_to_finish_capturing
      Thread.new { open_file_browser }
      gracefully_shutdown_vlc
    end

    def convert_video_to_gif = Terrapin::CommandLine.new('ffmpeg', "-i #{file_path} #{gif_file_path}").run

    def open_file_browser = Terrapin::CommandLine.new('dolphin', "#{ScreenCapture::SAVE_DIRECTORY} &").run

    def file_name = @options.file_name

    def gif_file_path = file_path.gsub('.mp4', '.gif')

    def file_path = "#{ScreenCapture::SAVE_DIRECTORY}#{file_name}"

    def wait_for_user_to_finish_capturing
      puts 'Press q to stop capture'

      loop do
        char = STDIN.getch
        break if char == 'q'
      end
    end

    def gracefully_shutdown_vlc
      puts 'Converting to gif...'

      client = TCPSocket.new('127.0.0.1', 8_082)
      client.send("quit\n", 0)
      client.close
    end
  end
end
