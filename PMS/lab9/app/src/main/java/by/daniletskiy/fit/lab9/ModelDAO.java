package by.daniletskiy.fit.lab9;

import android.annotation.SuppressLint;
import android.os.AsyncTask;

import androidx.lifecycle.LiveData;
import androidx.room.Dao;
import androidx.room.Delete;
import androidx.room.Insert;
import androidx.room.Query;
import androidx.room.Update;

import java.util.List;
@Dao
public interface ModelDAO {
    @Query("Select * from Business_Cards")
    LiveData<List<Model>> getAllCards();
    @Query("Select * from Business_Cards where id = :cardID")
    Model getCardByID(int cardID);
    @Query("SELECT id FROM Business_Cards ORDER BY id DESC LIMIT 1")
    LiveData<Integer> getLastItemId();
    @Insert
    void insertCard(Model model);
    @Update
    void updateCard(Model model);
    @Delete
    void deleteCard(Model model);
    @Query("DELETE FROM Business_Cards")
    void deleteAll();

}
