package by.daniletskiy.fit.lab9;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.view.Display;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.PopupMenu;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.lifecycle.LifecycleOwner;
import androidx.lifecycle.LiveData;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;
import androidx.lifecycle.ViewModelStoreOwner;
import androidx.recyclerview.widget.RecyclerView;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import kotlinx.coroutines.CoroutineScope;


public class CardAdapter extends RecyclerView.Adapter<CardAdapter.ViewHolder>{
    private LiveData<List<Model>> list;
    private Context context;
    private Model card;
    private  List<Model> listData;
    ViewModel cardViewModel;

    public CardAdapter(Context context, LiveData<List<Model>> tasksList){
        this.context = context;
        this.list = tasksList;
        cardViewModel = new ViewModelProvider((ViewModelStoreOwner) context).get(ViewModel.class);
        cardViewModel.getAllCards().observe((LifecycleOwner) context, new Observer<List<Model>>() {
            @Override
            public void onChanged(List<Model> models) {
                listData = models;
            }
        });
    }

    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item, parent,false);
        return new ViewHolder(view);
    }
    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int position) {
        card = listData.get(position);
        if(card != null){
            holder.FIO.setText(String.valueOf(card.getSurname()) + " " + String.valueOf(card.getName()) + " " + String.valueOf(card.getPatronymic()));
            holder.WorkPlace.setText(card.getWork_place());
            holder.Telephone.setText(card.getTelephone());
        }

    }

    @Override
    public int getItemCount() {
        if (listData == null) {
            return 0;
        } else {
            return listData.size();
        }
    }

    @Override
    public long getItemId(int position) {
        return position;
    }


    public class ViewHolder extends RecyclerView.ViewHolder {
        public TextView FIO;
        public TextView WorkPlace;
        public TextView Telephone;
        public LinearLayout llitem;

        public ViewHolder(View itemView){
            super(itemView);
            FIO = itemView.findViewById(R.id.FIO);
            WorkPlace = itemView.findViewById(R.id.WorkPlace);
            Telephone = itemView.findViewById(R.id.Telephone);
            llitem = itemView.findViewById(R.id.llitem);

            itemView.setOnLongClickListener(new View.OnLongClickListener() {
                @Override
                public boolean onLongClick(View v) {
                    int position = getAdapterPosition();
                    Model task = listData.get(position);
                    showPopupMenu(v, task);
                    return true;
                }
            });
        }
        private void showPopupMenu(View view, Model task) {
            PopupMenu popupMenu = new PopupMenu(view.getContext(), view);
            popupMenu.getMenuInflater().inflate(R.menu.context_menu, popupMenu.getMenu());

            popupMenu.setOnMenuItemClickListener(new PopupMenu.OnMenuItemClickListener() {
                @Override
                public boolean onMenuItemClick(MenuItem item) {
                    if (item.getItemId() == R.id.menu_view) {
                        Intent intent = new Intent(view.getContext(), FirstActivity.class);
                        intent.putExtra(Model.class.getSimpleName(), task);
                        intent.putExtra("Edit", false);
                        view.getContext().startActivity(intent);
                        return true;
                    } else if (item.getItemId() == R.id.menu_edit) {
                        Intent intent = new Intent(view.getContext(), FirstActivity.class);
                        intent.putExtra(Model.class.getSimpleName(), task);
                        intent.putExtra("Edit", true);
                        view.getContext().startActivity(intent);
                        notifyDataSetChanged();
                        return true;
                    } else if (item.getItemId() == R.id.menu_delete) {
                        AlertDialog.Builder builder = new AlertDialog.Builder(view.getContext());
                        builder.setTitle("Подтверждение")
                                .setMessage("Вы действительно хотите удалить элемент?")
                                .setPositiveButton("Удалить", new DialogInterface.OnClickListener() {
                                    @Override
                                    public void onClick(DialogInterface dialogInterface, int i) {
                                        cardViewModel.deleteCard(task);
                                        listData.remove(task);
                                        notifyDataSetChanged();
                                    }
                                })
                                .setNegativeButton("Отмена", null)
                                .show();
                        return true;
                    } else {
                        return false;
                    }
                }
            });

            popupMenu.show();
        }

    }
}
