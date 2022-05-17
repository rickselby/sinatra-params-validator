# frozen_string_literal: true

RSpec.describe Sinatra::ParamValidator::Parameter::Boolean do
  subject(:valid) { klass.valid? }

  let(:klass) { described_class.new(value, **options) }
  let(:options) { {} }
  let(:value) { 'true' }

  describe 'coerce' do
    subject(:coerce) { klass.coerced }

    %w[false f no n 0].each do |string|
      context "with the string #{string}" do
        let(:value) { string }

        it { is_expected.to be false }
      end
    end

    %w[true t yes y 1].each do |string|
      context "with the string #{string}" do
        let(:value) { string }

        it { is_expected.to be true }
      end
    end

    %w[foo bar].each do |string|
      context "with the string #{string}" do
        let(:value) { string }

        it { is_expected.to be_nil }
        example { expect(klass.errors).not_to be_empty }
      end
    end
  end

  describe 'is' do
    let(:options) { { is: true } }

    it { is_expected.to be true }

    context 'with an invalid option' do
      let(:options) { { is: false } }

      it { is_expected.to be false }
    end
  end

  describe 'in' do
    let(:options) { { in: [true] } }

    it { is_expected.to be true }

    context 'with an invalid option' do
      let(:options) { { in: [false] } }

      it { is_expected.to be false }
    end
  end

  describe 'required' do
    let(:options) { { required: true } }

    it { is_expected.to be true }

    context 'without a value' do
      let(:value) { nil }

      it { is_expected.to be false }
    end
  end
end