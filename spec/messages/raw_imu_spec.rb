require 'spec_helper'

describe MAVLink::Log::Messages::RawImu do

  let(:time) { ["0004D9EE608DA5E4"].pack('H*') }

  let(:header) { MAVLink::Log::Header.new(["FE1AA237011B"].pack('H*')) }

  let(:payload) { ["4018A32700000000C6027F0155F4EE17F017B418000000000000"].pack('H*') }

  let(:crc) { ["DD85"].pack('H*') }

  subject do
    entry = MAVLink::Log::Entry.new(time, header, payload, crc)
    MAVLink::Log::Messages::RawImu.new(entry)
  end

  it_behaves_like 'a message'

  it_behaves_like 'a timed message (us)', 665000000

end
