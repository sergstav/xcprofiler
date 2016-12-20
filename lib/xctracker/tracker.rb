require 'terminal-table'

module Xctracker
  class Tracker
    class << self
      def report(product_name, options)
        pattern = File.join(derived_data_root, "#{product_name}-*", "Logs", "Build", "*.xcactivitylog")
        derived_data = Dir.glob(pattern).map { |path|
          DerivedData.new(path)
        }
        f = formatter(derived_data.first.parse_executions)
        puts f.table
      end

      private

      def formatter(executions)
        Formatter.new(executions)
      end

      def derived_data_root
        File.expand_path('~/Library/Developer/Xcode/DerivedData')
      end
    end
  end
end
