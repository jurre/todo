Sequel.migration do
  up do
    alter_table(:todos) do
      add_foreign_key :user_id, :users
    end
  end

  down do
    alter_table(:todos) do
      drop_column :user_id
    end
  end
end
