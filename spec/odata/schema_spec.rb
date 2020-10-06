require 'spec_helper'

RSpec.describe OData::Schema do
  let(:doc) { load_xml_document("#{RSPEC_ROOT}/fixtures/sample_service/metadata.xml") }
  let(:schema_xml) { doc.xpath("//Schema").first }
  let(:service) { OData::Service.new nil, metadata_file: "#{RSPEC_ROOT}/fixtures/sample_service/metadata.xml" }
  let(:schema) { OData::Schema.new(schema_xml, service) }

  describe 'instance methods' do
    it { expect(schema).to respond_to(:namespace) }
  end

  describe '#namespace' do
    it { expect(schema.namespace).to eq("ODataDemo") }
  end
end