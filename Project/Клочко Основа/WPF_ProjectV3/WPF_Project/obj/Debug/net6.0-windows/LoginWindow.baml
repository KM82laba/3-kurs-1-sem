   M S B A M L   `   `   `  ����F  BWPF_Project, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null)clr-namespace:WPF_ProjectWPF_Project  5   	       WPF_Project.LoginWindow   5   	   W SPresentationCore, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5   	   R NSystem.Xaml, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   +localclr-namespace:WPF_Project     5   	   A =Wpf.Ui, Version=2.1.0.0, Culture=neutral, PublicKeyToken=null/ui&http://schemas.lepo.co/wpfui/2022/xaml  5	   	     � Title$  LoginWindow��5   	   $	��250��6   $	��350��6*    � WindowStartupLocation$ CenterScreen=�5
   	   .��5      � $��10q�6    � RowDefinitions 5   
   �� 5      $
��Auto �6   �� 5      $
��Auto �6   �� 5      $
��Auto �6   �� 5      $
��Auto �6   �� 5      $
��Auto �6   �� 5      $��* �6   .+�5   
   �� -   5         ��Name$ UserName��5      $��1��6&   $��Email��63   $��14(�6@   �� 5   
   -   5        $��usernameTextBox��5   &   
�������$��2��6=   $��0,5,0,0q�6K   �� 5   
   -   5        $ UserPassword��5      $��3��6*   $��Пароль��67   $��14(�6E   G� 5   
   -   5        $��passwordTextBox��5   +   
�������$��4��6B   $��0,5,0,0q�6O   �� 5   
   $��5��6    �� Orientation$ 
Horizontal=�6"   $��Center=�6;   $��Center=�6X   .+�5        Wpf.Ui.Controls.Button  -   5          Name$ LoginButton��5      $��
Войти��6-   $��0,0,10,0q�6=      
Appearance$ Primary=�6f     5      -   5        $ RegisterButton��5      
�������$��Регистрация��6D   $��10,0,0,0q�6Z   $ Light=�6�   5      5      5       