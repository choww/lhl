# NON-DUPLICATE VAUES IN ARRAY

def non_duplicated_values(values)
  values.delete_if do |value|
    values.count(value) > 1
  end
end