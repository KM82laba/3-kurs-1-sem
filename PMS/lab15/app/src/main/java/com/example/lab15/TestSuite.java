package com.example.lab15;

import org.junit.runner.RunWith;
import org.junit.runners.Suite;

@RunWith(Suite.class)
@Suite.SuiteClasses({
        FileDownloadServiceTest.class,
        LocationTrackingServiceTest.class,
        InteractionTest.class
})
public class TestSuite {
}
