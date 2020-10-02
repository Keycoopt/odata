module OData
  class Schema
    attr_reader :service

    attr_reader :metadata

    def initialize(schema_xml, service)
      @metadata = schema_xml
      @service = service
    end

    def namespace
      @namespace ||= metadata.attributes['Namespace'].value
    end

    def entity_types
      @entity_types ||= metadata.xpath('.//EntityType').map do |entity|
        entity.attributes['Name'].value
      end
    end

    def complex_types
      @complex_types ||= metadata.xpath('.//ComplexType').map do |complex_type|
        [
          complex_type.attributes['Name'].value,
          OData::ComplexType.new(name: complex_type.attributes['Name'].value, schema: self)
        ]
      end.to_h
    end

    # Returns a more compact inspection of the schema object
    def inspect
      "#<#{self.class.name}:#{self.object_id} namespace='#{namespace}'>"
    end

  end
end