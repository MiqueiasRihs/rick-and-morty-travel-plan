class CreateTravels < Jennifer::Migration::Base
  def up
    create_table :travels do |t|
      t.string :travel_stops, {:null => false}

      t.timestamps
    end
  end

  def down
    drop_table :travels if table_exists? :travels
  end
end
