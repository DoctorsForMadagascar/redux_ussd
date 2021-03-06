# frozen_string_literal: true

require 'redux_ussd/components/text'

RSpec.describe ReduxUssd::Middlewares::PromptParse do
  subject { described_class }

  let(:store) { double('ReduxUssd::Store') }
  let(:state) { { prompt: { key: 'test' } } }

  describe '.call' do
    before(:each) do
      allow(store).to receive(:state).and_return(state)
      allow(store).to receive(:dispatch)
    end

    let(:forward_error) { StandardError.new('This should not be raised') }
    let(:forward) { proc { raise forward_error } }

    context 'receives :handle_raw_input' do
      let(:action) do
        { type: :handle_raw_input,
          raw_input: 'this is raw input' }
      end

      it 'should dispatch an action' do
        subject.call(store).call(forward).call(action)
        expect(store).to have_received(:dispatch)
          .with(type: :fill_prompt,
                key: 'test',
                value: 'this is raw input')
      end
    end

    context 'receives another action' do
      let(:action) { { type: :another_action } }

      it 'forward the action to defined block' do
        expect do
          subject.call(store).call(forward).call(action)
        end.to raise_error(forward_error)
      end
    end
  end
end
