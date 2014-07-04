require 'spec_helper'

RSpec.describe FluentAccessors do

  class FluentAccessorsTestKlass
    extend FluentAccessors
    fluent_accessor :something
    fluent_accessor :other, set_method: false
    fluent_accessor :another, set_method: false
    fluent_accessor :no_writer, writer_method: false, set_method: false

    def initialize(something, other, another)
      @something = something
      @other     = other
      @another   = another
    end

    def set_another(value)
      @set_called = true

      @another = value
      :return_of_set_another
    end

    def setter_called?
      !!@set_called
    end
  end

  describe FluentAccessorsTestKlass do
    subject { described_class.new :hey, :you, :there }
    describe '#something (fluent setter/getter)' do
      describe '#something as getter' do
        it 'return the value' do
          expect(subject.something).to eq :hey
        end
      end

      describe '#something("val")' do
        it 'set the value and return self' do
          res = subject.something :x
          expect(subject).to be res
          expect(subject.something).to eq :x
        end
      end

      describe '#set_something("val")' do
        it 'set the value and return self' do
          res = subject.set_something :x
          expect(subject).to be res
          expect(subject.something).to eq :x
        end
      end
    end

    context 'without fluent setter' do
      describe '#set_other("val")' do
        it 'does not have the method' do
          expect(subject).not_to respond_to :set_other
        end
      end

      describe '#other("val") (fluent setter)' do
        it 'set the value and return self' do
          res = subject.other :x
          expect(subject).to be res
          expect(subject.other).to eq :x
        end
      end
    end

    context 'without fluent setter, but with a different set_x method ' do
      describe '#another("val") (fluent setter)' do
        it '(call set_another) and return self, regardless of what set_another returns' do
          res = subject.another :x
          expect(subject).to be res
          expect(subject.another).to eq :x
          expect(subject).to be_setter_called
        end
      end
    end

    context 'without writer setter' do
      describe '#no_writer("val") (fluent setter)' do
        it 'sets the instance variable the and return self' do
          # check that it works with arrays
          res = subject.no_writer [:x]
          expect(subject).to be res
          expect(subject.no_writer).to eq [:x]
        end

        it 'does not have the setter' do
          expect(subject).not_to respond_to :no_writer=
          expect(subject).not_to respond_to :set_writer
        end
      end
    end
  end

end