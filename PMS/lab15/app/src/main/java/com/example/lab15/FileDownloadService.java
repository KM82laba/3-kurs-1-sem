package com.example.lab15;

import static org.hamcrest.CoreMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import android.app.IntentService;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.content.Intent;
import android.content.Context;
import android.location.Location;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Binder;
import android.os.Build;
import android.os.Environment;
import android.os.IBinder;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.core.app.NotificationCompat;
import androidx.core.content.FileProvider;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.mockito.junit.MockitoJUnitRunner;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

@RunWith(MockitoJUnitRunner.class)
public class FileDownloadService extends IntentService {




    private static final int NOTIFICATION_ID = 1;
    private static final String CHANNEL_ID = "file_download_channel";

    private final IBinder binder = new LocalBinder();

    public void methodInFileDownloadServiceThatUsesLocationTrackingService(LocationTrackingService locationTrackingService) {
        Location location = locationTrackingService.getCurrentLocation();

        if (location != null) {
        }
    }

    public class LocalBinder extends Binder {
        FileDownloadService getService() {
            return FileDownloadService.this;
        }
    }

    public FileDownloadService() {
        super("FileDownloadService");
    }

    @Override
    public void onCreate() {
        super.onCreate();
        showToast("Service created");
        createNotificationChannel();
    }

    public boolean downloadImage(String imageUrl) {
        new DownloadImageTask().execute(imageUrl);
        return true; // возвращаем true, т.к. реальный результат будет получен в AsyncTask
    }

    private class DownloadImageTask extends AsyncTask<String, Void, Boolean> {
        @Override
        protected Boolean doInBackground(String... params) {
            String imageUrl = params[0];
            try {
                URL url = new URL(imageUrl);
                HttpURLConnection connection = (HttpURLConnection) url.openConnection();

                int responseCode = connection.getResponseCode();

                if (responseCode == HttpURLConnection.HTTP_OK) {
                    String fileName = "downloaded_image.jpg"; // Имя файла изображения

                    // Сохраняем файл во внешнем хранилище
                    File storageDir = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES);
                    File imageFile = new File(storageDir, fileName);

                    FileOutputStream outputStream = new FileOutputStream(imageFile);

                    byte[] buffer = new byte[4096];
                    int bytesRead;

                    while ((bytesRead = connection.getInputStream().read(buffer)) != -1) {
                        outputStream.write(buffer, 0, bytesRead);
                    }

                    outputStream.close();
                    connection.disconnect();

                    // Открываем изображение с помощью интента
                    Intent intent = new Intent(Intent.ACTION_VIEW);
                    Uri photoURI = FileProvider.getUriForFile(FileDownloadService.this, getPackageName() + ".provider", imageFile);
                    intent.setDataAndType(photoURI, "image/*");
                    intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
                    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                    startActivity(intent);

                    return true;
                }
            } catch (IOException e) {
                e.printStackTrace();
            }

            return false;
        }

        @Override
        protected void onPostExecute(Boolean result) {
            showToast(result ? "Download successful" : "Download failed");
            showNotification(result ? "Download successful" : "Download failed");
        }
    }


    @Override
    protected void onHandleIntent(@Nullable Intent intent) {
        showToast("Service started");

        if (intent != null && intent.hasExtra("image_url")) {
            String imageUrl = intent.getStringExtra("image_url");

            // Вызываем метод скачивания изображения с использованием URL из Intent
            boolean downloadSuccess = downloadImage(imageUrl);

            showToast(downloadSuccess ? "Download successful" : "Download failed");

            showNotification(downloadSuccess ? "Download successful" : "Download failed");
        }
    }


    public void showToast(final String message) {
        Log.d("FileDownloadService", "Toast: " + message);
        Toast.makeText(this, message, Toast.LENGTH_SHORT).show();
    }

    public void showNotification(String message) {
        Log.d("FileDownloadService", "Notification: " + message);

        NotificationCompat.Builder builder = new NotificationCompat.Builder(this, CHANNEL_ID)
                .setSmallIcon(android.R.drawable.stat_sys_download_done)
                .setContentTitle("File Download")
                .setContentText(message)
                .setPriority(NotificationCompat.PRIORITY_DEFAULT);

        NotificationManager notificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        notificationManager.notify(NOTIFICATION_ID, builder.build());
    }

    private void createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            CharSequence name = "File Download Channel";
            String description = "Channel for file download notifications";
            int importance = NotificationManager.IMPORTANCE_DEFAULT;
            NotificationChannel channel = new NotificationChannel(CHANNEL_ID, name, importance);
            channel.setDescription(description);

            NotificationManager notificationManager = getSystemService(NotificationManager.class);
            notificationManager.createNotificationChannel(channel);
        }
    }

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return binder;
    }
}