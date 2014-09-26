class Cardsorting < Sequel::Model

  many_to_one :theme
  
  one_to_many :cardsortingCardAndGroups
  
  many_to_many :unselectedCards, 
    :left_key=>:cardsorting_id,
    :right_key=>:card_id,
    :join_table=>:unselected_cards,
    :class=>:Card

  many_to_many :groups, 
    :left_key=>:cardsorting_id,
    :right_key=>:group_id,
    :join_table=>:cardsorting_card_and_groups,
    :class=>:Group

end