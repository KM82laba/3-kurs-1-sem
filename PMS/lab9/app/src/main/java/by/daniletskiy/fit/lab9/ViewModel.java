package by.daniletskiy.fit.lab9;

import android.app.Application;
import android.graphics.ColorSpace;
import android.view.Display;
import android.view.View;

import androidx.lifecycle.AndroidViewModel;
import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.Transformations;

import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class ViewModel extends AndroidViewModel {
    private Repository repository;
    private LiveData<List<Model>> allCards;

    public ViewModel(Application application){
        super(application);
        repository = new Repository(application);
        allCards = repository.getAllCardsLiveData();
    }

    public LiveData<List<Model>> getAllCards(){
        return allCards;
    }
    public void insertCard(Model card){
        repository.insertCard(card);
    }
    public void updateCard(Model card){
        repository.updateCard(card);
    }
    public void deleteCard(Model card){
        repository.deleteCard(card);
    }

    public void deleteAll(){
        repository.deleteAllData();
    }
}
