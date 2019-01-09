module Converter

  def conversion_loop(index_array, final_array, soup, output_hash)
    loop do
      if index_array.length >= 4
        self.shift_applier(index_array, final_array, soup.a_shift_array)
        self.shift_applier(index_array, final_array, soup.b_shift_array)
        self.shift_applier(index_array, final_array, soup.c_shift_array)
        self.shift_applier(index_array, final_array, soup.d_shift_array)
      elsif index_array.length == 3
        self.shift_applier(index_array, final_array, soup.a_shift_array)
        self.shift_applier(index_array, final_array, soup.b_shift_array)
        self.shift_applier(index_array, final_array, soup.c_shift_array)
      elsif index_array.length == 2
        self.shift_applier(index_array, final_array, soup.a_shift_array)
        self.shift_applier(index_array, final_array, soup.b_shift_array)
      elsif index_array.length == 1
        self.shift_applier(index_array, final_array, soup.a_shift_array)
      else
        output_hash[:encryption] = final_array.join
        return output_hash
      end
    end
  end
end
