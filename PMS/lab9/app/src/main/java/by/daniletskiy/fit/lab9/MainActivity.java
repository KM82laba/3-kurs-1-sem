package by.daniletskiy.fit.lab9;

import androidx.appcompat.app.AppCompatActivity;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;

import android.content.Intent;
import android.os.Bundle;
import android.view.Display;
import android.view.View;

import java.util.List;

public class MainActivity extends AppCompatActivity {
    private ViewModel cardViewModel;
    private Intent intent;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        cardViewModel = new ViewModelProvider(this).get(ViewModel.class);
        cardViewModel.getAllCards().observe(this, new Observer<List<Model>>() {
            @Override
            public void onChanged(List<Model> models) {
                if(models.size() > 0){
                    intent = new Intent(getApplicationContext(), ListActivity.class);
                    startActivity(intent);
                }
                else{
                    intent = new Intent(getApplicationContext(), FirstActivity.class);
                    startActivity(intent);
                }
                finish();
            }
        });


    }
}