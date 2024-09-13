
package by.daniletskiy.fit.lab9;

import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.lifecycle.LiveData;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.BitmapDrawable;
import android.net.Uri;
import android.os.Bundle;
import android.provider.MediaStore;
import android.util.Log;
import android.view.View;
import android.widget.Toast;

import com.google.android.material.button.MaterialButton;
import com.google.android.material.textfield.TextInputEditText;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class FirstActivity extends AppCompatActivity {

    TextInputEditText surnameTxt;
    TextInputEditText nameTxt;
    TextInputEditText patronymicTxt;
    TextInputEditText workPlaceTxt;
    TextInputEditText phoneTxt;
    TextInputEditText linkTxt;
    private int id;
    private LiveData<List<Model>> TasksList;
    private String surname;
    private String name;
    private String patronymic;
    private String workPlace;
    private String phone;
    private String link;
    private Model model;
    private ViewModel cardViewModel;
    private boolean isCreated = true;
    private boolean isEdit = false;
    private MaterialButton addButton;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_first);
        cardViewModel = new ViewModelProvider(this).get(ViewModel.class);

        surnameTxt = findViewById(R.id.surnameTxt);
        nameTxt = findViewById(R.id.nameTxt);
        patronymicTxt = findViewById(R.id.patronymicTxt);
        workPlaceTxt = findViewById(R.id.workPlaceTxt);
        phoneTxt = findViewById(R.id.phoneTxt);
        linkTxt = findViewById(R.id.linkTxt);
        addButton = findViewById(R.id.addButton);

        Toolbar toolbar = findViewById(R.id.toolbarItem);
        setSupportActionBar(toolbar);
        ActionBar actionBar = getSupportActionBar();
        if (actionBar != null) {
            actionBar.setDisplayHomeAsUpEnabled(true);
        }
        Bundle arguments = getIntent().getExtras();
        if(arguments != null){

            isCreated = false;
            isEdit = arguments.getBoolean("Edit");
            model = (Model) arguments.getSerializable(Model.class.getSimpleName());
            surnameTxt.setText(model.getSurname());
            nameTxt.setText(model.getName());
            patronymicTxt.setText(model.getPatronymic());
            workPlaceTxt.setText(model.getWork_place());
            phoneTxt.setText(model.getTelephone());
            linkTxt.setText(model.getLinks());
        }
        if(!isEdit && !isCreated){
            surnameTxt.setClickable(false);
            nameTxt.setEnabled(false);
            patronymicTxt.setEnabled(false);
            workPlaceTxt.setEnabled(false);
            phoneTxt.setEnabled(false);
            linkTxt.setEnabled(false);
            addButton.setVisibility(View.GONE);
        }
    }

    private Model newModel(){


        surname = String.valueOf(surnameTxt.getText());
        name = String.valueOf(nameTxt.getText());
        patronymic = String.valueOf(patronymicTxt.getText());
        workPlace = String.valueOf(workPlaceTxt.getText());
        phone = String.valueOf(phoneTxt.getText());
        link = String.valueOf(linkTxt.getText());
        if(isCreated){
            model = new Model();
        }
        model.setSurname(surname);
        model.setName(name);
        model.setPatronymic(patronymic);
        model.setWork_place(workPlace);
        model.setTelephone(phone);
        model.setLinks(link);
        return model;
    }

    public void addToList(View v){
        model = newModel();
        Update();

        Intent intent = new Intent(this, ListActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_REORDER_TO_FRONT);
        startActivity(intent);
        finish();
    }


    private void Update(){
        if(isEdit){
            cardViewModel.updateCard(model);
        }
        else{
            cardViewModel.insertCard(model);
        }
    }

}