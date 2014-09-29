Sequel.migration do

  up do
    drop_table :unselected_cards
  end

  down do
    create_table :unselected_cards do
      primary_key   :id
      foreign_key   :cardsorting_id, :cardsortings
      foreign_key   :card_id, :cards
    end
  end

end