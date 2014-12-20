namespace :db do
  desc "Run DB migrations"
  task :migrate => :app do
   require "sequel/extensions/migration"

   Sequel::Migrator.apply(TodoAPI::App.database, "db/migrations")
  end

  desc "Rollback migration"
  task :rollback => :app do
    require "sequel/extensions/migration"
    database = TodoAPI::App.database

    version  = (row = database[:schema_info].first) ? row[:version] : nil
    Sequel::Migrator.apply(database, "db/migrations", version - 1)
  end

  desc "Dump the database schema"
  task :dump => :app do
    database = TodoAPI::App.database

    `sequel -d #{database.url} > db/schema.rb`
    `pg_dump --schema-only #{database.url} > db/schema.sql`
  end

  desc "Create databases (test and development)"
  task :setup => :app do
    `createdb todo_test`
    `createdb todo_development`
  end
end
