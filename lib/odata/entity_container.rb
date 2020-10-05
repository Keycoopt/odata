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

    # The EntityContainer's namespace
    def namespace
      service.namespace
    end

    # Returns a more compact inspection of the EntityContainer object
    def inspect
      "#<#{self.class.name}:#{self.object_id} name='#{name}'>"
    end
  end
end