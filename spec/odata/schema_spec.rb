require 'spec_helper'

describe OData::Schema do
  let(:doc) { load_xml_document("#{RSPEC_ROOT}/fixtures/sample_service/metadata.xml") }
  let(:schema_xml) { doc.xpath("//Schema").first }
  let(:schema) { OData::Schema.new(schema_xml, nil) }

  it { expect(schema.namespace).to eq "ODataDemo" }

  it { expect(schema.entity_types).to eq ["Product", "FeaturedProduct", "ProductDetail", "Category", "Supplier", "Person", "Customer", "Employee", "PersonDetail", "Advertisement"] }
end