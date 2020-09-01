require 'spec_helper'

describe OData::Schema do
  let(:doc) { File.open("#{RSPEC_ROOT}/fixtures/sample_service/metadata.xml") { |f| Nokogiri::XML(f) }.remove_namespaces! }
  let(:schema_xml) { doc.xpath("//Schema").first }
  let(:schema) { OData::Schema.new(schema_xml, nil) }

  it { expect(schema.namespace).to eq "ODataDemo" }
end