package com.example.lab15;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;

import org.junit.Test;

public class InteractionTest {
    @Test
    public void testFileDownloadServiceAndLocationTrackingServiceInteraction() {
        FileDownloadService fileDownloadService = mock(FileDownloadService.class);
        LocationTrackingService locationTrackingService = mock(LocationTrackingService.class);

        fileDownloadService.methodInFileDownloadServiceThatUsesLocationTrackingService(locationTrackingService);

        verify(locationTrackingService).methodInLocationTrackingService();
    }
}
