require 'open-uri'

module MAVLink
  module Log

    class File

      attr_reader :entries, :messages

      # Determines if the file at the given URI is a MAVLink telemetry log file.
      #
      # @param uri URI to file to read
      # @return [MAVLink::Log::File] loaded file if the file is a MAVLink log file, nil otherwise
      def self.mavlink?(uri)
        File.new(uri) rescue nil
      end

      def initialize(uri)
        @entries = []
        @messages = []
        open(uri, 'rb') do |file|
          loop do
            raw_time = file.read(8)
            break if raw_time.nil?

            header = Header.new(file.read(6))
            raise "Unexpected magic number (#{header.magic})" unless header.magic == 0xFE

            payload = file.read(header.length)
            raw_crc = file.read(2)
            @entries << Entry.new(raw_time, header, payload, raw_crc)
            @messages << Messages::Factory.build(@entries.last)
          end
        end

        if @entries.empty?
          raise 'No entries found in file'
        end

        #puts @messages.inspect
      rescue => e
        raise ArgumentError, "File does not appear to be an MAVLink log (#{e})"
      end

      # Gets the duration of the session, in seconds.
      #
      # @return [Float] duration of the session, in seconds
      def duration
        return 0 if @entries.empty?
        (@entries.last.time - @entries.first.time) / 1000000.0
      end

      def started_at
        Time.at(@entries.first.time / 1000000.0)
      end

      def ended_at
        Time.at(@entries.last.time / 1000000.0)
      end

    end

  end
end
