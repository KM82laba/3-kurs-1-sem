package by.daniletskiy.fit.lab9;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.lifecycle.LifecycleOwner;
import androidx.lifecycle.LiveData;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProvider;
import androidx.lifecycle.ViewModelStoreOwner;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.List;


public class ListFragment extends Fragment {

    public static LiveData<List<Model>> TasksList;
    public ViewModel cardViewModel;

    public static RecyclerView listView;
    private RecyclerView.LayoutManager tableLayoutManager;
    private RecyclerView.LayoutManager linearLayoutManager;
    private CardAdapter adapter;
    public ListFragment() {

    }


    @Override
    public void onAttach(@NonNull Context context) {
        super.onAttach(context);

    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        cardViewModel = new ViewModelProvider(this).get(ViewModel.class);
        cardViewModel.getAllCards().observe((LifecycleOwner) requireContext(), new Observer<List<Model>>() {
            @Override
            public void onChanged(List<Model> models) {
                CardAdapter adapter = new CardAdapter(requireContext(), cardViewModel.getAllCards());
                linearLayoutManager = new LinearLayoutManager(requireContext());
                listView.setLayoutManager(linearLayoutManager);
                listView.setAdapter(adapter);
                adapter.notifyDataSetChanged();
            }
        });
        View view = inflater.inflate(R.layout.fragment_list, container, false);
        TasksList = cardViewModel.getAllCards();
        listView = view.findViewById(R.id.listViewItems);
        adapter = new CardAdapter(requireContext(), TasksList);

        tableLayoutManager = new GridLayoutManager(getContext(),2);
        linearLayoutManager = new LinearLayoutManager(getContext());

        listView.setLayoutManager(linearLayoutManager);
        listView.setAdapter(adapter);
        adapter.notifyDataSetChanged();
        return view;

    }



    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        registerForContextMenu(listView);

    }

}