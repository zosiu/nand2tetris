# frozen_string_literal: true

module Hack
  class Vars
    attr_accessor :variables, :next_var

    def initialize
      @variables = {
        'R0' => 0, 'R1' => 1, 'R2' => 2, 'R3' => 3,
        'R4' => 4, 'R5' => 5, 'R6' => 6, 'R7' => 7,
        'R8' => 8, 'R9' => 9, 'R10' => 10, 'R11' => 11,
        'R12' => 12, 'R13' => 13, 'R14' => 14, 'R15' => 15,
        'SCREEN' => 16_384, 'KBD' => 24_576,
        'SP' => 0, 'LCL' => 1, 'ARG' => 2, 'THIS' => 3, 'THAT' => 4
      }
      @next_var = 16
    end
  end

  DirectAddress = Struct.new(:value) do
    def address_value
      value
    end

    def generate(_ins_num, _vars); end
  end

  NamedAddress = Struct.new(:name) do
    def generate(_ins_num, vars)
      @address_value ||= vars.variables[name]
      return if @address_value

      @address_value = vars.next_var
      vars.variables[name] = @address_value
      vars.next_var += 1
    end

    def address_value
      @address_value
    end
  end

  AInstruction = Struct.new(:address) do
    def generate(ins_num, vars)
      address.generate(ins_num, vars)
      address.address_value.to_i.to_s(2).rjust(16, '0')
    end
  end

  Label = Struct.new(:name) do
    def generate(ins_num, vars)
      vars.variables[name] ||= ins_num
      nil
    end
  end

  DInstructon = Struct.new(:dest, :comp, :jump) do
    def generate(_ins_num, _vars)
      "111#{comp}#{dest}#{jump}"
    end
  end
end
