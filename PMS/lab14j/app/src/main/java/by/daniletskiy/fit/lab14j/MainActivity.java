package by.daniletskiy.fit.lab14j;

import android.Manifest;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Color;
import android.location.Address;
import android.location.Geocoder;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.provider.Settings;
import android.view.View;
import android.widget.Button;
import android.widget.RadioGroup;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.MapView;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.model.BitmapDescriptorFactory;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.Marker;
import com.google.android.gms.maps.model.MarkerOptions;
import com.google.android.gms.maps.model.PolylineOptions;
import com.google.maps.android.clustering.ClusterItem;
import com.google.maps.android.clustering.ClusterManager;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

public class MainActivity extends AppCompatActivity implements OnMapReadyCallback {

    private static final int REQUEST_LOCATION_PERMISSION = 1;
    private static final int REQUEST_SETTINGS = 2;

    private LocationManager locationManager;
    private LocationListener locationListener;
    private boolean isTrackingLocation = false;
    private File locationLogFile;

    private TextView latitudeTextView;
    private TextView longitudeTextView;
    private TextView addressTextView;
    private TextView speedTextView;
    private TextView timeTextView;
    private TextView altitudeTextView;
    private Button startButton;
    private Button stopButton;
    private MapView mapView;
    private GoogleMap googleMap;
    private Marker startMarker;
    private Marker stopMarker;
    private ClusterManager<MarkerItem> clusterManager;

    private int updateIntervalInSeconds = 1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        latitudeTextView = findViewById(R.id.latitudeTextView);
        longitudeTextView = findViewById(R.id.longitudeTextView);
        addressTextView = findViewById(R.id.addressTextView);
        speedTextView = findViewById(R.id.speedTextView);
        timeTextView = findViewById(R.id.timeTextView);
        altitudeTextView = findViewById(R.id.altitudeTextView);
        startButton = findViewById(R.id.startButton);
        stopButton = findViewById(R.id.stopButton);
        mapView = findViewById(R.id.mapView);
        mapView.onCreate(savedInstanceState);
        mapView.getMapAsync(this);

        locationManager = (LocationManager) getSystemService(Context.LOCATION_SERVICE);

        startButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (isTrackingLocation) {
                    return;
                }

                if (!isLocationPermissionGranted()) {
                    requestLocationPermission();
                    return;
                }

                if (!isLocationEnabled()) {
                    showLocationSettingsDialog();
                    return;
                }

                isTrackingLocation = true;
                startButton.setEnabled(false);
                stopButton.setEnabled(true);

                locationLogFile = createLocationLogFile();

                locationListener = new LocationListener() {
                    @Override
                    public void onLocationChanged(Location location) {
                        updateLocationViews(location);
                        logLocation(location);
                        addMarkerToMap(location);
                    }

                    @Override
                    public void onStatusChanged(String provider, int status, Bundle extras) {
                    }

                    @Override
                    public void onProviderEnabled(String provider) {
                    }

                    @Override
                    public void onProviderDisabled(String provider) {
                    }
                };

                String provider = LocationManager.GPS_PROVIDER;
                int selectedProvider = getSelectedProvider();
                if (selectedProvider == 1) {
                    provider = LocationManager.NETWORK_PROVIDER;
                }
                try {
                    int updateIntervalInMillis = getUpdateInterval();
                    int minDistance = 0;
                    locationManager.requestLocationUpdates(provider, updateIntervalInMillis, 0, locationListener);
                } catch (SecurityException e) {
                    e.printStackTrace();
                }
            }
        });

        stopButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (!isTrackingLocation) {
                    return;
                }

                isTrackingLocation = false;
                startButton.setEnabled(true);
                stopButton.setEnabled(false);

                locationManager.removeUpdates(locationListener);
            }
        });
    }

    @Override
    protected void onResume() {
        super.onResume();
        mapView.onResume();
    }

    @Override
    protected void onPause() {
        super.onPause();
        mapView.onPause();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        mapView.onDestroy();

        if(isTrackingLocation) {
            locationManager.removeUpdates(locationListener);
        }
    }

    @Override
    protected void onSaveInstanceState(Bundle outState) {
        super.onSaveInstanceState(outState);
        mapView.onSaveInstanceState(outState);
    }

    @Override
    public void onLowMemory() {
        super.onLowMemory();
        mapView.onLowMemory();
    }

    @Override
    public void onMapReady(GoogleMap googleMap) {
        this.googleMap = googleMap;
        clusterManager = new ClusterManager(this, googleMap);
        googleMap.setOnCameraIdleListener(clusterManager);
        googleMap.setOnMarkerClickListener(clusterManager);
    }

    private boolean isLocationPermissionGranted() {
        int permission = checkSelfPermission(Manifest.permission.ACCESS_FINE_LOCATION);
        return permission == PackageManager.PERMISSION_GRANTED;
    }

    private void requestLocationPermission() {
        String[] permissions = {Manifest.permission.ACCESS_FINE_LOCATION};
        requestPermissions(permissions, REQUEST_LOCATION_PERMISSION);
    }

    private boolean isLocationEnabled() {
        boolean gpsEnabled = locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER);
        boolean networkEnabled = locationManager.isProviderEnabled(LocationManager.NETWORK_PROVIDER);
        return gpsEnabled || networkEnabled;
    }

    private void showLocationSettingsDialog() {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle(R.string.location_settings_dialog_title)
                .setMessage(R.string.location_settings_dialog_message)
                .setPositiveButton(R.string.location_settings_dialog_positive_button, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        Intent settingsIntent = new Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS);
                        startActivityForResult(settingsIntent, REQUEST_SETTINGS);
                    }
                })
                .setNegativeButton(R.string.location_settings_dialog_negative_button, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        dialog.dismiss();
                    }
                });
        AlertDialog dialog = builder.create();
        dialog.show();
    }

    private File createLocationLogFile() {
        File directory = getExternalFilesDir(null);
        String fileName = "location_log.txt";
        return new File(directory, fileName);
    }

    private void logLocation(Location location) {
        String logEntry = String.format(
                Locale.getDefault(),
                "Time: %s\nLatitude: %f\nLongitude: %f\nAddress: %s\nSpeed: %f\nAltitude: %f\n\n",
                new Date().toString(),
                location.getLatitude(),
                location.getLongitude(),
                getAddress(location),
                location.getSpeed(),
                location.getAltitude()
        );

        try {
            FileWriter writer = new FileWriter(locationLogFile, true);
            writer.append(logEntry);
            writer.flush();
            writer.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void updateLocationViews(Location location) {
        latitudeTextView.setText(getString(R.string.latitude, location.getLatitude()));
        longitudeTextView.setText(getString(R.string.longitude, location.getLongitude()));
        addressTextView.setText(getString(R.string.address, getAddress(location)));
        speedTextView.setText(getString(R.string.speed, location.getSpeed()));
        timeTextView.setText(getString(R.string.time, new Date(location.getTime()).toString()));
        altitudeTextView.setText(getString(R.string.altitude, location.getAltitude()));
    }

    private String getAddress(Location location) {
        Geocoder geocoder = new Geocoder(this, Locale.getDefault());
        try {
            List<Address> addresses = geocoder.getFromLocation(location.getLatitude(), location.getLongitude(), 1);
            if (!addresses.isEmpty()) {
                Address address = addresses.get(0);
                StringBuilder sb = new StringBuilder();
                for (int i = 0; i <= address.getMaxAddressLineIndex(); i++) {
                    sb.append(address.getAddressLine(i));
                    if (i < address.getMaxAddressLineIndex()) {
                        sb.append(", ");
                    }
                }
                return sb.toString();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return getString(R.string.unknown_address);
    }

    private void addMarkerToMap(Location location) {
        LatLng latLng = new LatLng(location.getLatitude(), location.getLongitude());
        MarkerOptions markerOptions = new MarkerOptions()
                .position(latLng)
                .title(getString(R.string.marker_title))
                .icon(BitmapDescriptorFactory.defaultMarker(BitmapDescriptorFactory.HUE_GREEN));
        if (startMarker == null) {
            startMarker = googleMap.addMarker(markerOptions);
        } else {
            stopMarker = googleMap.addMarker(markerOptions);
            drawPolyline();
            startMarker.remove();
            startMarker = stopMarker;
        }
        googleMap.animateCamera(CameraUpdateFactory.newLatLngZoom(latLng, 15));
    }

    private void drawPolyline() {
        if (startMarker != null && stopMarker != null) {
            LatLng startLatLng = startMarker.getPosition();
            LatLng stopLatLng = stopMarker.getPosition();
            googleMap.addPolyline(new PolylineOptions()
                    .add(startLatLng, stopLatLng)
                    .width(5)
                    .color(Color.RED));
        }
    }

    private int getSelectedProvider() {RadioGroup providerRadioGroup = findViewById(R.id.providerRadioGroup);
        int selectedId = providerRadioGroup.getCheckedRadioButtonId();
        if (selectedId == R.id.gpsRadioButton) {
            return 0;
        } else {
            return 1;
        }
    }

    private int getUpdateInterval() {
        RadioGroup updateIntervalRadioGroup = findViewById(R.id.updateIntervalRadioGroup);
        int selectedId = updateIntervalRadioGroup.getCheckedRadioButtonId();
        if (selectedId == R.id.interval1RadioButton) {
            updateIntervalInSeconds = 1;
        } else if (selectedId == R.id.interval5RadioButton) {
            updateIntervalInSeconds = 5;
        } else if (selectedId == R.id.interval10RadioButton) {
            updateIntervalInSeconds = 10;
        }
        return updateIntervalInSeconds * 1000;
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == REQUEST_SETTINGS) {
            if (isLocationEnabled()) {
                startButton.performClick();
            } else {
            }
        }
    }
}
