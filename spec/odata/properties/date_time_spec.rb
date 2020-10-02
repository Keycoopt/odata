require 'spec_helper'

describe OData::Properties::DateTime do
  let(:subject) { OData::Properties::DateTime.new('DateTime', "datetime'2000-12-12T12:00'") }
  let(:new_datetime) { DateTime.strptime('2004-05-01T14:32:00.000', '%Y-%m-%dT%H:%M:%S.%L') }

  it { expect(subject.type).to eq('Edm.DateTime') }
  it { expect(subject.value).to eq(DateTime.parse("datetime'2000-12-12T12:00'")) }

  it { expect(subject.url_value).to eq("datetime'2000-12-12T12:00:00+00:00'")}

  it { expect {subject.value = 'bad'}.to raise_error(ArgumentError) }

  it { expect(lambda {
    subject.value = '2004-05-01T14:32:00.000'
    subject.value
  }.call).to eq(new_datetime) }

  it { expect(lambda {
    subject.value = new_datetime
    subject.value
  }.call).to eq(new_datetime) }
end