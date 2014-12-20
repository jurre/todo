Sequel.migration do
  up do
    create_table(:todos) do
      primary_key :id
      String      :title,         size: 256, null: false
      Boolean     :completed,     null: false, default: false
      DateTime    :created_at,    null: false
      DateTime    :updated_at,    null: false
    end
  end

  down do
    drop_table :todos, cascade: true
  end
end
