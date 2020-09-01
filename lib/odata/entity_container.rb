module OData
  class EntityContainer

    # The EntityContainer's XML metadata
    attr_reader :metadata
    # The OData::Service containing the EntityContainer
    attr_reader :service

    def initialize(metadata, service)
      @metadata = metadata
      @service = service
    end

    # The EntityContainer's name
    # @return [String]
    def name
      @name ||= metadata.attributes["Name"].value
    end

    def schema
      @schema ||= OData::Schema.new(metadata.ancestors("Schema").first, service)
    end

    # The EntityContainer's namespace
    def namespace
      schema.namespace
    end

    # Returns a hash of EntitySet names and their respective EntityTypes.
    # @return [Hash<String, String>]
    def entity_sets
      @entity_sets ||= metadata.xpath('.//EntitySet').map do |entity|
        [
          entity.attributes['Name'].value,
          entity.attributes['EntityType'].value
        ]
      end.to_h
    end

    # Retrieves the EntitySet associated with a specific EntityType by name
    #
    # @param entity_set_name [to_s] the name of the EntitySet desired
    # @return [OData::EntitySet] an OData::EntitySet to query
    def [](entity_set_name)
      xpath_query = ".//EntitySet[@Name='#{entity_set_name}']"
      entity_set_node = metadata.xpath(xpath_query).first

      raise ArgumentError, "Unknown Entity Set: #{entity_set_name}" if entity_set_node.nil?

      entity_type = entity_set_node.attributes['EntityType'].value

      OData::EntitySet.new(name: entity_set_name,
                           namespace: namespace,
                           type: entity_type,
                           service_name: service.name,
                           container: name)
    end

    # Returns a more compact inspection of the EntityContainer object
    def inspect
      "#<#{self.class.name}:#{self.object_id} name='#{name}'>"
    end
  end
end