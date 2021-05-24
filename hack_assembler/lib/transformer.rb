# frozen_string_literal: true

require 'parslet'
require_relative 'nodes'

module Hack
  class Transformer < Parslet::Transform
    rule(value: simple(:value)) { value.to_i }
    rule(direct_address: simple(:value)) { DirectAddress.new(value.to_i) }
    rule(named_address: simple(:value)) { NamedAddress.new(value.str) }
    rule(a_instruction: simple(:direct_address)) { AInstruction.new(direct_address) }
    rule(a_instruction: simple(:named_address)) { AInstruction.new(named_address) }
    rule(label: simple(:name)) { Label.new(name.str) }

    rule(jump: simple(:j)) do
      case j
      when 'JGT' then '001'
      when 'JEQ' then '010'
      when 'JGE' then '011'
      when 'JLT' then '100'
      when 'JNE' then '101'
      when 'JLE' then '110'
      when 'JMP' then '111'
      else '000'
      end
    end

    rule(dest: simple(:d)) do
      case d
      when 'M' then '001'
      when 'D' then '010'
      when 'MD' then '011'
      when 'A' then '100'
      when 'AM' then '101'
      when 'AD' then '110'
      when 'AMD' then '111'
      else '000'
      end
    end

    rule(comp: subtree(:args)) do
      if args[:zero] then '0101010'
      elsif args[:one] then '0111111'
      elsif args[:minus_one] then '0111010'
      elsif args[:data_value]
        { 'A' => '0110000',
          'D' => '0001100',
          'M' => '1110000' }[args[:data_value].str]
      elsif args[:negative_data_value]
        { 'A' => '0110011',
          'D' => '0001111',
          'M' => '1110011' }[args[:negative_data_value].str]
      elsif args[:negated_data_value]
        { 'A' => '0110001',
          'D' => '0001101',
          'M' => '1110001' }[args[:negated_data_value].str]
      elsif args[:plus]
        {
          'A_1' => '0110111',
          '1_A' => '0110111',
          'D_1' => '0011111',
          '1_D' => '0011111',
          'M_1' => '1110111',
          '1_M' => '1110111',
          'D_A' => '0000010',
          'A_D' => '0000010',
          'D_M' => '1000010',
          'M_D' => '1000010'
        }["#{args[:plus][:lhs].str}_#{args[:plus][:rhs].str}"]
      elsif args[:minus]
        {
          'A_1' => '0110010',
          'D_1' => '0001110',
          'M_1' => '1110010',
          'D_A' => '0010011',
          'A_D' => '0000111',
          'D_M' => '1010011',
          'M_D' => '1000111'
        }["#{args[:minus][:lhs].str}_#{args[:minus][:rhs].str}"]
      elsif args[:or]
        {
          'D_A' => '0010101',
          'A_D' => '0010101',
          'D_M' => '1010101',
          'M_D' => '1010101'
        }["#{args[:or][:lhs].str}_#{args[:or][:rhs].str}"]
      elsif args[:and]
        {
          'D_A' => '0000000',
          'A_D' => '0000000',
          'D_M' => '1000000',
          'M_D' => '1000000'
        }["#{args[:and][:lhs].str}_#{args[:and][:rhs].str}"]
      else '0000000'
      end
    end

    rule(d_instruction: subtree(:stuff)) do
      DInstructon.new(stuff[:dest] || '000', stuff[:d_comp] || '0000000', stuff[:jump] || '000')
    end
  end
end
