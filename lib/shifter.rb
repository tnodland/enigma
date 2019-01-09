module Shifter

  def shift_converter(shift)
    if shift > 27
      modulo_shift = shift % 27
    else
      modulo_shift = shift
    end
    27 - modulo_shift
  end

  def date_shifter(date)
    squared_date = (date.to_i) ** 2
    square_array = squared_date.to_s.split ""

    @a_shift += square_array[6].to_i
    @b_shift += square_array[7].to_i
    @c_shift += square_array[8].to_i
    @d_shift += square_array[9].to_i
  end

  def shift_applier(index_array, message_array, soup_array)
    shifted_letter = index_array.shift
    message_array << soup_array[shifted_letter]
  end
end
