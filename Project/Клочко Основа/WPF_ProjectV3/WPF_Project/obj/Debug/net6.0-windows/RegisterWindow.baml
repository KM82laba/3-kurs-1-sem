   M S B A M L   `   `   `  ����F  BWPF_Project, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null)clr-namespace:WPF_ProjectWPF_Project  5   	        WPF_Project.RegisterWindow   5   	   W SPresentationCore, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5   	   R NSystem.Xaml, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   +localclr-namespace:WPF_Project     5   	   _ [MaterialDesignThemes.Wpf, Version=5.0.0.0, Culture=neutral, PublicKeyToken=df2a72020bd7962aFmaterialDesign1http://materialdesigninxaml.net/winfx/xaml/themes  5	   	     � Title$  RegisterWindow��5   
   $	��600��6!   $	��400��6.    � WindowStartupLocation$ CenterScreen=�5
   	   .��5      � $��10q�6    � RowDefinitions 5   
   �� 5      $
��Auto �6   �� 5      $
��Auto �6   �� 5      $
��Auto �6   �� 5      $
��Auto �6   �� 5      $
��Auto �6   �� 5      $
��Auto �6   �� 5      $
��Auto �6   �� 5      $
��Auto �6   �� 5      $
��Auto �6   �� 5      $
��Auto �6   �� 5      $
��Auto �6   �� 5      $
��Auto �6   �� 5      $
��Auto �6   �� 5      $
��Auto �6   �� 5      $
��Auto �6   .+�5   
   �� $��0��6   .+�5   
   �� -   5        $��0��5      $��1��6!   $��40��65   $
��Left=�6@   $	��Top=�6[   $��0q�6s   .��5       � .+�5!      �� $��15��6!   $��15��6,   .��5"      '  !MaterialDesignThemes.Wpf.PackIcon     Kind$ 	ArrowBack=�6.   $��Center=�6?   $��Center=�6Z   $��15��6w   $��15��6�   5#      5$      5%      �� 5&   
   $��0��6   $��Email:��6   $��14(�6.   5'      �� 5(   
   -   5        $��emailTextBox��5(      $��1��6   $��0,5,0,0q�63   �� 5)   
   $��2��6   $��Пароль:��6   $��14(�6/   G� 5*   
   -   5        $��passwordTextBox��5*   #   $��3��6   $��0,5,0,0q�6:   �� 5+   
   $��4��6   $*��$Подтвердить пароль:��6   $��14(�6;   G� 5,   
   -   5        $��confirmpasswordTextBox��5,   #   $��5��6   $��0,5,0,0q�6A   �� 5-   
   $��6��6   $��Имя:��6   $��14(�6,   �� 5.   
   -   5        $��firstNameTextBox��5.      $��7��6   $��0,5,0,0q�67   �� 5/   
   $��8��6   $��Фамилия:��6   $��14(�60   �� 50   
   -   5        $��lastNameTextBox��50      $��9��6   $��0,5,0,0q�66   �� 51   
   $��10��6   $��Адресс:��6   $��14(�60   �� 52   
   -   5        $��addressTextBox��52       $��11��6   $��0,5,0,0q�66   �� 53   
   $��12��6   $��Телефон:��6   $��14(�61   �� 54   
   -   5        $��phoneNumberTextBox��54       $��13��6   $��0,5,0,0q�6:   �� 55   
   $��14��6   $	��Top=�6#   $��Center=�6;   .+�56   
   �� -	   5        $��addUserButton��56      $��14��6   $#��Создать аккаунт��64   $��0,10,0,0q�6j   $��14(�6|   57      58      59      