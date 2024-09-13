package com.example.lab15;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;
import static javaslang.control.Option.when;

import com.sun.jna.platform.win32.Netapi32Util;

import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.stubbing.OngoingStubbing;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

public class UserViewModelTest {
    @Rule
    public InstantTaskExecutorRule instantTaskExecutorRule = new InstantTaskExecutorRule();

    @Mock
    private UserRepository userRepository;

    private UserViewModel userViewModel;

    @Before
    public void setUp() {
        MockitoAnnotations.initMocks(this);
        userViewModel = new UserViewModel(userRepository);
    }

    @Test
    public void fetchUsersSuccess() throws Exception {
        // Arrange
        List<Netapi32Util.User> mockUsers = Arrays.asList(new Netapi32Util.User(), new Netapi32Util.User());
             when(userRepository.getUsers()).thenReturn(mockUsers);

        // Act
        userViewModel.fetchUsers();

        // Assert
        assertEquals(mockUsers, userViewModel.getUserList().getValue());
        assertNull(userViewModel.getError().getValue());
    }

    private OngoingStubbing<List<Netapi32Util.User>> when(Object users) {
        return null;
    }

    @Test
    public void fetchUsersError() throws Exception {
        // Arrange
        String errorMessage = "Network error";
        when(userRepository.getUsers()).thenThrow(new IOException(errorMessage));

        // Act
        userViewModel.fetchUsers();

        // Assert
       assertNull(userViewModel.getUserList().getValue());
        assertEquals(errorMessage, userViewModel.getError().getValue());
    }
}
