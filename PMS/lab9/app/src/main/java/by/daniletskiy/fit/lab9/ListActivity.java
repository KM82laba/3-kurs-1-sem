package by.daniletskiy.fit.lab9;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.SearchView;
import androidx.appcompat.widget.Toolbar;
import androidx.fragment.app.FragmentContainerView;
import androidx.lifecycle.LiveData;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.annotation.SuppressLint;
import android.app.ActionBar;
import android.content.Intent;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.view.Display;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Toast;

import java.util.List;

public class ListActivity extends AppCompatActivity{
    private Toolbar toolbar;
    ListFragment listFragment;
    private  ViewModel cardViewModel;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_list);

        toolbar = findViewById(R.id.toolbarList);
        setSupportActionBar(toolbar);
        listFragment = (ListFragment) getSupportFragmentManager().findFragmentById(R.id.listFragment);

    }


    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        onResume();
    }

    @Override
    protected void onResume() {
        super.onResume();
        cardViewModel = new ViewModelProvider(this).get(ViewModel.class);
        if (listFragment != null) {
            ListFragment.TasksList = listFragment.cardViewModel.getAllCards();
            CardAdapter adapter = new CardAdapter(this, ListFragment.TasksList);
            ListFragment.listView.setAdapter(adapter);
            adapter.notifyDataSetChanged();
        }
    }
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_main, menu);
        if (getSupportActionBar() != null) {
            getSupportActionBar().setDisplayShowTitleEnabled(false);
        }
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {
        int id = item.getItemId();
        if(id == R.id.action_add){
            Intent intent = new Intent(this, FirstActivity.class);
            startActivity(intent);
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

}