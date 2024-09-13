package com.example.lab15;

import static org.mockito.Mockito.when;

import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Handler;
import android.os.IBinder;
import android.widget.Toast;

import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

public class LocationTrackingServiceTest {

    @Mock
    private LocationManager mockLocationManager;

    @Mock
    private LocationListener mockLocationListener;

    @Mock
    private Toast mockToast;

    @Mock
    private Handler mockHandler;

    @Mock
    private Location mockLocation;

    @Mock
    private IBinder mockIBinder;

    private LocationTrackingService locationTrackingService;
    private Toast toast;
    private Handler handler;

    @Before
    public void setUp() {
        MockitoAnnotations.initMocks(this);
        locationTrackingService = new LocationTrackingService();
        locationTrackingService.locationManager = mockLocationManager;
        locationTrackingService.locationListener = mockLocationListener;
        locationTrackingService.toast = mockToast;
        locationTrackingService.handler = mockHandler;
    }

    @Test(timeout = 1000)
    public void testOnLocationChangedWithSpeed() {
        when(mockLocation.hasSpeed()).thenReturn(true);
        when(mockLocation.getSpeed()).thenReturn(10.0f);

        locationTrackingService.onLocationChanged(mockLocation);

    }

    @Test(timeout = 1000)
    @Ignore("Проигнорированный тест")
    public void testOnLocationChangedWithoutSpeed() {
        when(mockLocation.hasSpeed()).thenReturn(false);

        locationTrackingService.onLocationChanged(mockLocation);

    }

    private void onLocationChanged(Location mockLocation) {

    }

    @Test(timeout = 1000)
    public void testOnStatusChanged() {
        locationTrackingService.onStatusChanged("provider", 1, null);

    }

    private void onStatusChanged(String provider, int i, Object o) {

    }

    @Test(timeout = 1000)
    public void testOnProviderEnabled() {
        locationTrackingService.onProviderEnabled("provider");

    }

    private void onProviderEnabled(String provider) {

    }

    @Test(timeout = 1000)
    public void testOnProviderDisabled() {
        locationTrackingService.onProviderDisabled("provider");

    }

    private void onProviderDisabled(String provider) {
    }

}
