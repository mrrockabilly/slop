module Slop
  module Types
  end

  class Type
    def self.aliases
      @aliases ||= {}
    end

    def self.exists?(value)
      Types.constants.include?(to_constant_name(value))
    end

    def self.to_constant_name(name)
      name = aliases[name.to_s] if aliases.key?(name.to_s)
      :"#{name.to_s.capitalize}Type"
    end

    def self.from_name(name)
      Types.const_get to_constant_name(name)
    end

    def self.add_alias(this, that)
      aliases[this.to_s] = that
    end

    add_alias "str",  "string"
    add_alias "int",  "integer"
    add_alias "bool", "boolean"

    attr_reader :parser

    def initialize(parser)
      @parser = parser
    end

    alias options parser

    def call
      raise
    end

    def option_config
      { expects_argument: true }
    end

  end
end

require "slop/types/string_Type"
require "slop/types/integer_Type"
require "slop/types/boolean_Type"