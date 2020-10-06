require 'spec_helper'

RSpec.describe OData::EntityContainer do
  let(:service) { OData::Service.new nil, metadata_file: "#{RSPEC_ROOT}/fixtures/sample_service/metadata.xml" }
  let(:doc) { load_xml_document("#{RSPEC_ROOT}/fixtures/sample_service/metadata.xml") }
  let(:entity_container_xml) { doc.xpath("//EntityContainer").first }
  let(:entity_container) { OData::EntityContainer.new(entity_container_xml, service) }

  describe 'instance methods' do
    it { expect(entity_container).to respond_to(:name) }
    it { expect(entity_container).to respond_to(:namespace) }
    it { expect(entity_container).to respond_to(:inspect) }
    it { expect(entity_container).to respond_to(:entity_sets) }
    it { expect(entity_container).to respond_to(:service) }
    it { expect(entity_container).to respond_to(:schema) }
  end

  describe '#name' do
    it { expect(entity_container.name).to eq "DemoService" }
  end

  describe '#namespace' do
    it { expect(entity_container.namespace).to eq "ODataDemo" }
  end

  describe '#entity_sets' do
    it { expect(entity_container.entity_sets.size).to eq(7) }
    it { expect(entity_container.entity_sets.keys).to eq(["Product", "ProductDetail", "Category", "Supplier", "Person", "PersonDetail", "Advertisement"]) }
    it { expect(entity_container.entity_sets.values).to eq(["Products", "ProductDetails", "Categories", "Suppliers", "Persons", "PersonDetails", "Advertisements"]) }
  end

  describe '#[]' do
    it { expect(entity_container['Products']).to be_a(OData::EntitySet) }
    it { expect {entity_container['Nonexistant']}.to raise_error(ArgumentError) }
  end
end