module Shifter

  def shift_converter(shift)
    if shift > 27
    modulo_shift = shift % 27
    else
    modulo_shift = shift
  end 
    converted_shift = 27 - modulo_shift
  end
end
