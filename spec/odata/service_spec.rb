require 'spec_helper'

describe OData::Service, vcr: {cassette_name: 'service_specs'} do
  let(:subject) { OData::Service.open('http://services.odata.org/OData/OData.svc', name: 'ODataDemo') }
  let(:entity_types) { %w{Product FeaturedProduct ProductDetail Category Supplier Person Customer Employee PersonDetail Advertisement} }
  let(:complex_types) { %w{Address} }
  let(:associations) { %w{Product_Categories_Category_Products
                          Product_Supplier_Supplier_Products
                          Product_ProductDetail_ProductDetail_Product
                          FeaturedProduct_Advertisement_Advertisement_FeaturedProduct
                          Person_PersonDetail_PersonDetail_Person} }

  describe '.open' do
    it { expect(OData::Service).to respond_to(:open) }
  end

  it 'adds itself to OData::ServiceRegistry on creation' do
    expect(OData::ServiceRegistry['ODataDemo']).to be_nil
    expect(OData::ServiceRegistry['http://services.odata.org/OData/OData.svc']).to be_nil

    service = OData::Service.open('http://services.odata.org/OData/OData.svc', name: 'ODataDemo')

    expect(OData::ServiceRegistry['ODataDemo']).to eq(service)
    expect(OData::ServiceRegistry['http://services.odata.org/OData/OData.svc']).to eq(service)
  end

  describe 'instance methods' do
    it { expect(subject).to respond_to(:service_url) }
    it { expect(subject).to respond_to(:entity_types) }
    it { expect(subject).to respond_to(:entity_sets) }
    it { expect(subject).to respond_to(:complex_types) }
    it { expect(subject).to respond_to(:associations) }
    it { expect(subject).to respond_to(:namespace) }
    it { expect(subject).to respond_to(:entity_container) }
    it { expect(subject).to respond_to(:[])}
    it { expect(subject).to respond_to(:metadata) }
  end

  describe '#service_url' do
    it { expect(subject.service_url).to eq('http://services.odata.org/OData/OData.svc') }
  end

  describe '#entity_types' do
    it { expect(subject.entity_types.size).to eq(10) }
    it { expect(subject.entity_types).to eq(entity_types) }
  end

  describe '#complex_types' do
    it { expect(subject.complex_types.size).to eq(1) }
    it { expect(subject.complex_types).to eq(complex_types) }
  end

  describe '#associations' do
    it { expect(subject.associations.size).to eq(5) }
    it { expect(subject.associations.keys).to eq(associations) }
    it do
      subject.associations.each do |name, association|
        expect(association).to be_a(OData::Association)
      end
    end
  end

  describe '#entity_container' do
    it { expect(subject.entity_container).to be_a(OData::EntityContainer) }
  end

  describe '#navigation_properties' do
    it { expect(subject).to respond_to(:navigation_properties) }
    it { expect(subject.navigation_properties['Product'].size).to eq(3) }
    it { expect(subject.navigation_properties['Product']['Categories']).to be_a(OData::Association) }
  end

  describe '#namespace' do
    it { expect(subject.namespace).to eq('ODataDemo') }
  end
end