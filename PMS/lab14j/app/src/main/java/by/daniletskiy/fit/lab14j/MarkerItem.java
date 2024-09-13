package by.daniletskiy.fit.lab14j;

import com.google.android.gms.maps.model.LatLng;
import com.google.maps.android.clustering.ClusterItem;

public class MarkerItem implements ClusterItem {
    private final LatLng position;
    private final String title;
    private final String snippet;

    public MarkerItem(double latitude, double longitude, String title, String snippet) {
        position = new LatLng(latitude, longitude);
        this.title = title;
        this.snippet = snippet;
    }

    @Override
    public LatLng getPosition() {
        return position;
    }

    @Override
    public String getTitle() {
        return title;
    }

    @Override
    public String getSnippet() {
        return snippet;
    }
}