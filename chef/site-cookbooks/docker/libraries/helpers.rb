# Helpers module
module Helpers

  # Helpers::Docker module
  module Docker

    def cli_args(spec)
      cli_line = ''
      spec.each_pair do |arg, value|
        case value
        when Array
          cli_line += value.map { |a| " -#{arg} " + a }.join
        when Fixnum, Integer, String
          cli_line += " -#{arg} #{value}"
        when TrueClass
          cli_line += " -#{arg}"
        end
      end
      cli_line
    end

    def run(command)
      cmd = Mixlib::ShellOut.new(command)
      cmd.run_command
      return cmd.exitstatus == 0
    end

  end
end
