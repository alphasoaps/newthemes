# frozen_string_literal: true
require "test_helper"

module ThemeCheck
  module LanguageServer
    class CompletionProviderTest < Minitest::Test
      def setup
        super
        skip("Liquid-C not supported") if liquid_c_enabled?
      end

      def test_doc_hash
        expected_hash = {
          documentation: {
            kind: "markdown",
            value: "### content",
          },
        }
        actual_hash = make_provider.doc_hash('### content')

        assert_equal(expected_hash, actual_hash)
      end

      def test_doc_hash_with_empty_content
        assert_equal({}, make_provider.doc_hash(nil))
        assert_equal({}, make_provider.doc_hash(''))
      end

      private

      def make_provider
        CompletionProvider.new(storage)
      end

      def storage
        InMemoryStorage.new
      end
    end
  end
end
