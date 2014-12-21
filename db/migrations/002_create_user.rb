Sequel.migration do
  up do
    create_table(:users) do
      primary_key :id
      String      :username,      size: 256, null: false
      String      :password_hash, size: 256, null: false
      String      :token,         size: 256

      index [:username], unique: true
    end
  end
end
