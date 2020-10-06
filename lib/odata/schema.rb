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

    # The Schema's namespace
    # @return [String]
    def namespace
      @namespace ||= metadata.attributes['Namespace'].value
    end

    # The Schema's entity types
    # @return [Array<String>]
    def entity_types
      @entity_types ||= metadata.xpath('./EntityType').collect do |entity_type|
        entity_type.attributes['Name'].value
      end
    end

    # Returns a more compact representation of the Schema object
    def inspect
      "#<#{self.class.name}:#{self.object_id} namespace='#{namespace}'>"
    end
  end
end