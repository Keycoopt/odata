require 'spec_helper'

describe OData::Properties::DateTimeOffset do
  let(:subject) { OData::Properties::DateTimeOffset.new('DateTime', '2002-10-10T17:00:00Z') }
  let(:new_datetime) { DateTime.strptime('2015-01-08T22:11:58Z', '%Y-%m-%dT%H:%M:%S%:z') }

  it { expect(subject.type).to eq('Edm.DateTimeOffset') }
  it { expect(subject.value).to eq(DateTime.strptime('2002-10-10T17:00:00Z', '%Y-%m-%dT%H:%M:%S%:z')) }

  it { expect {subject.value = 'bad'}.to raise_error(ArgumentError) }

  it { expect(lambda {
    subject.value = new_datetime
    subject.value
  }.call).to eq(new_datetime) }

  it { expect(lambda {
    subject.value = nil
  }).not_to raise_error }

  context "with the allows_nil option set to false" do
    let(:subject) { OData::Properties::DateTimeOffset.new('DateTime', '2002-10-10T17:00:00Z', allows_nil: false) }

    it { expect(lambda {
      subject.value = nil
    }).to raise_error(ArgumentError) }
  end
end