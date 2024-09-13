package by.daniletskiy.fit.lab9;

import android.content.Context;

import androidx.room.Database;
import androidx.room.Room;
import androidx.room.RoomDatabase;
@Database(entities = {Model.class}, version = 2)
public abstract class DatabaseClass extends RoomDatabase {
    private static DatabaseClass instance;
    public abstract ModelDAO modelDao();

    public static synchronized DatabaseClass getInstance(Context context) {
        if(instance == null){
            instance = Room.databaseBuilder(context.getApplicationContext(), DatabaseClass.class, "lab9")
                    .fallbackToDestructiveMigration().build();
        }
        return instance;
    }
}
