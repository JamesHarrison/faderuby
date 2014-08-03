require 'spec_helper'

describe(FadeRuby::Client) do
  context 'creating a new client' do
    it 'should open a socket' do
      expect_any_instance_of(FadeRuby::Client).to receive(:socket)
      described_class.new
    end
  end
  context 'given a mock socket' do
    let(:client) { described_class.new }
    let(:socket_mock) { double('socket') }
    # Mock the socket
    before(:each) do
      allow_any_instance_of(FadeRuby::Client).to receive(:socket).and_return(socket_mock)
    end
    describe '#set_pixels' do
      context 'setting 1 pixel on channel 0 to 128, 128, 128' do
        after(:each) do
          client.set_pixels([128,128,128], 0)
        end
        it 'should send the right message' do
          expect(socket_mock).to receive(:send).with([0, 0, 3, 128, 128, 128].pack('CCS>CCC'), 0)
        end
      end
      context 'setting 2 pixels on channel 1 to 256, 128, 0' do
        after(:each) do
          client.set_pixels([256, 128, 0, 256, 128, 0], 1)
        end
        it 'should send the right message' do
          expect(socket_mock).to receive(:send).with([1, 0, 6, 256, 128, 0, 256, 128, 0].pack('CCS>CCCCCC'), 0)
        end
      end
    end

  end
end