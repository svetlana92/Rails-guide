class IzraeliIdsController < ApplicationController
  def new

  end

  def result
    @izraeli_id = params[:izraeli_id]
    @result = check(@izraeli_id)
  end

  private

  def check(izraeli_id)
    id_array = izraeli_id.split('')
    sum = sum_izraeli_id(id_array)
    return (sum % 10) == 0
  end

  def sum_izraeli_id(id_array)
    sum = 0
    id_array.each_with_index do |value, index|
      if value.to_i.to_s == value
        if index % 2 == 0
          sum += value.to_i
        else
          double_value = value.to_i * 2
          if double_value < 10
            sum += double_value
          else
            sum += double_value / 10 + double_value % 10
          end
        end
      else
        return false
      end
    end
    sum
  end

end
