Sequel.migration do
  change do
    add_column :themes ,:userId,String
    add_column :cards ,:userId,String

    create_table :groups do
      primary_key   :id
      foreign_key   :theme_id, :themes
      String        :title, :null => true
    end

    create_table :cardsortings do
      primary_key   :id
      foreign_key   :theme_id, :themes
      String   :userId, :null => true
    end

    create_table :cardsorting_card_and_groups do
      primary_key   :id
      foreign_key   :cardsorting_id, :cardsortings
      foreign_key   :card_id, :cards
      foreign_key   :group_id, :groups
    end

    create_table :unselected_cards do
      primary_key   :id
      foreign_key   :cardsorting_id, :cardsortings
      foreign_key   :card_id, :cards
    end


  end

end