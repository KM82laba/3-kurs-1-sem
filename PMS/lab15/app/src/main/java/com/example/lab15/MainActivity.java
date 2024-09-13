package com.example.lab15;

import static android.Manifest.permission.ACCESS_FINE_LOCATION;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.Looper;
import android.text.TextUtils;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {

    private static final int LOCATION_PERMISSION_REQUEST_CODE = 1;
    private boolean isLocationPermissionGranted = false;
    private boolean isTryingToDownload = false;

    private LocationTrackingService locationService;
    private boolean isLocationServiceBound = false;

    private FileDownloadService downloadService;
    private boolean isDownloadServiceBound = false;

    private final ServiceConnection locationServiceConnection = new ServiceConnection() {
        @Override
        public void onServiceConnected(ComponentName name, IBinder service) {
            LocationTrackingService.LocalBinder binder = (LocationTrackingService.LocalBinder) service;
            locationService = binder.getService();
            isLocationServiceBound = true;
        }

        @Override
        public void onServiceDisconnected(ComponentName name) {
            isLocationServiceBound = false;
        }
    };

    private final ServiceConnection downloadServiceConnection = new ServiceConnection() {
        @Override
        public void onServiceConnected(ComponentName name, IBinder service) {
            FileDownloadService.LocalBinder binder = (FileDownloadService.LocalBinder) service;
            downloadService = binder.getService();
            isDownloadServiceBound = true;

            // Теперь, когда служба связана, проверяем, была ли уже попытка скачивания
            if (isTryingToDownload) {
                // Вызываем метод скачивания изображения в службе
                String imageUrl = "https://get.wallhere.com/photo/1920x1200-px-cute-himalayan-kitten-1641129.jpg";
                downloadService.downloadImage(imageUrl);
                isTryingToDownload = false;
            }
        }

        @Override
        public void onServiceDisconnected(ComponentName name) {
            isDownloadServiceBound = false;
        }
    };


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        EditText imageUrlEditText = findViewById(R.id.imageUrlEditText);

        Button startLocationServiceButton = findViewById(R.id.startLocationServiceButton);
        startLocationServiceButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startLocationService();
            }
        });

        Button downloadImageButton = findViewById(R.id.startDownloadServiceButton);
        downloadImageButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String imageUrl = imageUrlEditText.getText().toString();
                if (!TextUtils.isEmpty(imageUrl)) {
                    if (isDownloadServiceBound) {
                        if (downloadService != null) {
                            // Вызываем метод скачивания изображения в службе
                            downloadService.downloadImage(imageUrl);
                        } else {
                            // Обработка случая, если downloadService не инициализирован
                            showToast("Download service is not initialized");
                        }
                    } else {
                        // Если служба не связана, запускаем ее и вызываем метод скачивания
                        startDownloadService();
                    }
                } else {
                    showToast("Please enter an image URL");
                }
            }
        });

        checkLocationPermission();
    }
    private void showToast(final String message) {
        new Handler(Looper.getMainLooper()).post(() -> {
            if (!isFinishing()) {
                Toast.makeText(this, message, Toast.LENGTH_SHORT).show();
            }
        });
    }
    private void checkLocationPermission() {
        if (ContextCompat.checkSelfPermission(this, ACCESS_FINE_LOCATION)
                == PackageManager.PERMISSION_GRANTED) {
            isLocationPermissionGranted = true;
        } else {
            ActivityCompat.requestPermissions(
                    this,
                    new String[]{ACCESS_FINE_LOCATION},
                    LOCATION_PERMISSION_REQUEST_CODE
            );
        }
    }

    private void startLocationService() {
        if (isLocationPermissionGranted) {
            if (isLocationServiceBound) {
                showToast("Location service is already running");
            } else {
                Intent locationServiceIntent = new Intent(this, LocationTrackingService.class);
                startService(locationServiceIntent);
                bindService(locationServiceIntent, locationServiceConnection, Context.BIND_AUTO_CREATE);
            }
        } else {
            checkLocationPermission();
        }
    }

    private void startDownloadService() {
        // Привязываем службу
        Intent downloadServiceIntent = new Intent(this, FileDownloadService.class);
        bindService(downloadServiceIntent, downloadServiceConnection, Context.BIND_AUTO_CREATE);

        // Запускаем службу
        startService(downloadServiceIntent);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (isLocationServiceBound) {
            unbindService(locationServiceConnection);
            isLocationServiceBound = false;
        }
        if (isDownloadServiceBound) {
            unbindService(downloadServiceConnection);
            isDownloadServiceBound = false;
        }
    }


    // Handle permission request results
    @Override
    public void onRequestPermissionsResult(
            int requestCode,
            @NonNull String[] permissions,
            @NonNull int[] grantResults
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode == LOCATION_PERMISSION_REQUEST_CODE) {
            if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                isLocationPermissionGranted = true;
            } else {
                // Handle the case where the user denies the location permission
            }
        }
    }
}