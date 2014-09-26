class UnselectedCard < Sequel::Model

  many_to_one :card

  many_to_one :cardsorting

end