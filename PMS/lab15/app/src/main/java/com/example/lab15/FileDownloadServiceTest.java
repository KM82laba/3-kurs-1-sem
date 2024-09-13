package com.example.lab15;

import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import android.location.Location;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

public class FileDownloadServiceTest {


    @Mock
    private FileDownloadService fileDownloadService;

    @Before
    public void setUp() {
        MockitoAnnotations.initMocks(this);
    }

    @After
    public void tearDown() {
    }

    @Test
    public void testDownloadImageSuccess() {
        // Подготовка тестовых данных
        String imageUrl = "https://example.com/image.jpg";

        // Mock HttpURLConnection для имитации успешного ответа
        HttpURLConnection mockConnection = Mockito.mock(HttpURLConnection.class);
        try {
            when(mockConnection.getResponseCode()).thenReturn(HttpURLConnection.HTTP_OK);
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Mock URL для возвращения mockConnection
        URL mockUrl = Mockito.mock(URL.class);
        try {
            when(mockUrl.openConnection()).thenReturn(mockConnection);
        } catch (IOException e) {
            e.printStackTrace();
        }


        // Вызов метода, который мы хотим протестировать
        fileDownloadService.downloadImage(imageUrl);

        // Проверка, что метод showToast был вызван с ожидаемым аргументом
        verify(fileDownloadService).showToast("Download successful");
    }

    private URL createUrl(String urlString) throws MalformedURLException {
        return new URL(urlString);
    }
    @Test
    public void testDownloadImageFailure() {
        // Подготовка тестовых данных
        String imageUrl = "https://example.com/nonexistent_image.jpg";

        // Mock HttpURLConnection для имитации неудачного ответа
        HttpURLConnection mockConnection = Mockito.mock(HttpURLConnection.class);
        try {
            when(mockConnection.getResponseCode()).thenReturn(HttpURLConnection.HTTP_NOT_FOUND);
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Mock URL для возвращения mockConnection
        URL mockUrl = Mockito.mock(URL.class);
        try {
            when(mockUrl.openConnection()).thenReturn(mockConnection);
        } catch (IOException e) {
            e.printStackTrace();
        }


        // Вызов метода, который мы хотим протестировать
        fileDownloadService.downloadImage(imageUrl);

        // Проверка, что метод showToast был вызван с ожидаемым аргументом
        verify(fileDownloadService).showToast("Download failed");
    }






    @Test
    public void testShowNotification() {
        // Подготовка тестовых данных
        String message = "Test notification";

        // Вызов метода, который мы хотим протестировать
        fileDownloadService.showNotification(message);

        // Проверка, что уведомление было отображено
        verify(fileDownloadService).showNotification(message);
    }



}
