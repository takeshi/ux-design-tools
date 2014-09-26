class Card < Sequel::Model

  many_to_one :theme
  
  one_to_many :cardsortingCardAndGroups
  
end