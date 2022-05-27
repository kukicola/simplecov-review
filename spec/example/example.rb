# frozen_string_literal: true

class Example
  def abc
    a = 2 + 2

    a * 2
  end

  def bcd(arg)
    return 1 if arg == 1

    arg**2
  end

  def cde
    'hello'
  end
end

Example.new.bcd(1)
Example.new.cde
