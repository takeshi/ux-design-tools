class CardsortingCardAndGroup < Sequel::Model

  many_to_one :cardsorting

  many_to_one :group
  
  many_to_one :card
  
end