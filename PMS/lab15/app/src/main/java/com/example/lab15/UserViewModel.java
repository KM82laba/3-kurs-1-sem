package com.example.lab15;

import androidx.activity.result.ActivityResultLauncher;
import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

import java.net.HttpCookie;
import java.security.cert.Extension;
import java.util.List;

public class UserViewModel extends ViewModel {

    private final MutableLiveData<List<User>> _userList = new MutableLiveData<>();
    public LiveData<List<User>> getUserList() {
        return _userList;
    }

    private final MutableLiveData<String> _error = new MutableLiveData<>();
    public LiveData<String> getError() {
        return _error;
    }

    private final UserRepository userRepository;

    public UserViewModel(UserRepository userRepository) {
        this.userRepository = userRepository;
    }


    public void fetchUsers() {
    }
}