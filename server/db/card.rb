class Card < Sequel::Model

  many_to_one :theme
  
end