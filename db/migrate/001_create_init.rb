Sequel.migration do
  change do
    create_table :themes do
      primary_key   :id
      String        :title, :null => true
    end

    create_table :cards do
      primary_key   :id
      foreign_key   :theme_id, :themes
      String        :desc, :null => true
    end

  end

end