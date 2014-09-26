class Theme < Sequel::Model

  one_to_many :cards

  one_to_many :groups

  one_to_many :cardsortings

end