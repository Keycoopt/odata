require 'spec_helper'

RSpec.describe OData::Schema do
  let(:doc) { load_xml_document("#{RSPEC_ROOT}/fixtures/sample_service/metadata.xml") }
  let(:schema_xml) { doc.xpath("//Schema").first }
  let(:service) { OData::Service.new nil, metadata_file: "#{RSPEC_ROOT}/fixtures/sample_service/metadata.xml" }
  let(:schema) { OData::Schema.new(schema_xml, service) }
  let(:entity_types) { %w{Product FeaturedProduct ProductDetail Category Supplier Person Customer Employee PersonDetail Advertisement} }

  describe 'instance methods' do
    it { expect(schema).to respond_to(:namespace) }
    it { expect(schema).to respond_to(:entity_types) }
    it { expect(schema).to respond_to(:inspect) }
  end

  describe '#namespace' do
    it { expect(schema.namespace).to eq("ODataDemo") }
  end

  describe '#entity_types' do
    it { expect(schema.entity_types.size).to eq(10) }
    it { expect(schema.entity_types).to eq(entity_types) }
  end
end