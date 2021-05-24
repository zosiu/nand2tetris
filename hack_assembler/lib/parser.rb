# frozen_string_literal: true

require 'parslet'

module Hack
  class Parser < Parslet::Parser
    def noise
      (space | comment).repeat
    end

    rule(:space)      { match('\s').repeat(1) }
    rule(:space?)     { space.maybe }
    rule(:newline)    { str("\n") >> str("\r").maybe }

    rule(:comment) { (space? >> str('//') >> (newline.absent? >> any).repeat) }

    rule(:identifier) { match('[a-zA-Z]') >> match('[0-9a-zA-z.$_]').repeat }

    rule(:named_register) do
      str('R15') | str('R14') | str('R13') | str('R12') |
        str('R11') | str('R10') | str('R9') | str('R8') |
        str('R7') | str('R6') | str('R5') | str('R4') |
        str('R3') | str('R2') | str('R1') | str('R0')
    end
    rule(:builtin_variable) do
      named_register | str('SCREEN') | str('KBD') | str('SP') | str('LCL') | str('ARG') | str('THIS') | str('THAT')
    end
    rule(:variable) { str('@') >> (builtin_variable | identifier).as(:named_address) }
    rule(:address) { str('@') >> (str('0') | (match('[1-9]') >> match('[0-9]').repeat)).as(:direct_address) }
    rule(:a_instruction) { variable | address }

    rule(:data_type) { str('A') | str('M') | str('D') }
    rule(:comp) do
      ((str('!') >> data_type.as(:negated_data_value)) | (str('-') >> data_type.as(:negative_data_value)) |
        (data_type.as(:lhs) >> space? >> str('+') >> space? >> data_type.as(:rhs)).as(:plus) |
        (data_type.as(:lhs) >> space? >> str('+') >> space? >> str('1').as(:rhs)).as(:plus) |
        (data_type.as(:lhs) >> space? >> str('-') >> space? >> data_type.as(:rhs)).as(:minus) |
        (data_type.as(:lhs) >> space? >> str('-') >> space? >> str('1').as(:rhs)).as(:minus) |
        (data_type.as(:lhs) >> space? >> str('|') >> space? >> data_type.as(:rhs)).as(:or) |
        (data_type.as(:lhs) >> space? >> str('&') >> space? >> data_type.as(:rhs)).as(:and) |
        data_type.as(:data_value) | str('0').as(:zero) | str('1').as(:one) | str('-1').as(:minus_one)).as(:comp)
    end

    rule(:dest) { ((data_type >> data_type.maybe >> data_type.maybe) | str('0')).as(:dest) }
    rule(:jump) do
      (str('JGT') | str('JEQ') | str('JGE') | str('JLT') | str('JNE') | str('JLE') | str('JMP')).as(:jump)
    end

    rule(:d_instruction) do
      (dest.as(:dest) >> space? >> str('=') >> space?).maybe >>
        comp.as(:d_comp) >>
        (space? >> str(';') >> space? >> jump.as(:jump)).maybe
    end

    rule(:instruction) { a_instruction.as(:a_instruction) | d_instruction.as(:d_instruction) }

    rule(:label) { str('(') >> identifier.as(:label) >> str(')') }

    rule(:program) { (noise >> (instruction | label) >> noise).repeat }

    root(:program)
  end
end
