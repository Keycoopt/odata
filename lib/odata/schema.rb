module OData
  class Schema
    # The schema's XML metadata
    attr_reader :metadata
    # The OData::Service containing the schema
    attr_reader :service

    def initialize(metadata, service)
      @metadata = metadata
      @service = service
    end

    def namespace
      @namespace ||= metadata.attributes['Namespace'].value
    end
  end
end