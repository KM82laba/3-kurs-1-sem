package by.daniletskiy.fit.lab9;

import android.content.Context;
import android.view.Display;

import androidx.lifecycle.LiveData;
import androidx.lifecycle.Transformations;

import java.util.List;
import java.util.concurrent.Callable;
import java.util.concurrent.Executor;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

public class Repository {
    private ModelDAO modelDAO;
    private LiveData<List<Model>> allCardsLiveData;
    private Executor executor;
    public Repository(Context context){
        DatabaseClass database = DatabaseClass.getInstance(context);
        modelDAO = database.modelDao();
        allCardsLiveData = Transformations.map(modelDAO.getAllCards(), cards -> cards);
        executor = Executors.newSingleThreadExecutor();
    }

    public LiveData<List<Model>> getAllCards(){
        return modelDAO.getAllCards();
    }
    public LiveData<List<Model>> getAllCardsLiveData() {
        return allCardsLiveData;
    }
    public Model getCardById(int ID){
        return modelDAO.getCardByID(ID);
    }


    public LiveData<Integer> getLastItemId() {
        return modelDAO.getLastItemId();
    }

    public void insertCard(Model card){
        executor.execute(()->modelDAO.insertCard(card));
    }
    public void updateCard(Model card){
        executor.execute(()->modelDAO.updateCard(card));
    }
    public void deleteCard(Model card){
        executor.execute(()->modelDAO.deleteCard(card));
    }
    public void deleteAllData() {
        executor.execute(() -> {
            modelDAO.deleteAll();
        });
    }
}
