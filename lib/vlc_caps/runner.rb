require 'terrapin'

module VlcCaps
  class Runner
    def initialize(argv)
      @options = Options.new(argv)
    end

    def run
      vlc = Terrapin::CommandLine.new('vlc', @options.get)
      puts 'Enter CTRL + c to stop capturing'
      vlc.run
    rescue Interrupt => e
      dolphin = Terrapin::CommandLine.new('dolphin', Options::SAVE_DIRECTORY)
      dolphin.run
    end
  end
end
