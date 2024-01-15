require 'optparse'

module VlcCaps
  class Options
    attr_reader :application, :file_name

    def initialize(argv) = parse(argv)

    private

    def parse(argv)
      OptionParser.new do |opts|
        opts.banner = 'Usage: vlc_caps [ options ]'

        opts.on('-a', '--application application', String, 'What to capture') do |application|
          @application = application.downcase.to_sym
        end

        opts.on('-f', '--file_name file_name', String, 'Name to save file as') do |file_name|
          @file_name = file_name
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
  end
end
