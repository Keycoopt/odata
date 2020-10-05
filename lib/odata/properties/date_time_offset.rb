module OData
  module Properties
    # Defines the DateTimeOffset OData type.
    class DateTimeOffset < OData::Properties::DateTime
      # The OData type name
      def type
        'Edm.DateTimeOffset'
      end

      private

      def strptime_format
        '%Y-%m-%dT%H:%M:%S%:z'
      end
    end
  end
end