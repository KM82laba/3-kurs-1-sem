   M S B A M L   `   `   `  ���� F  BWPF_Project, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null)clr-namespace:WPF_ProjectWPF_Project      WPF_Project.LoginWindow   W SPresentationCore, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     R NSystem.Xaml, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     @d2http://schemas.microsoft.com/expression/blend/2008     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     +localclr-namespace:WPF_Project     A =Wpf.Ui, Version=2.1.0.0, Culture=neutral, PublicKeyToken=null/ui&http://schemas.lepo.co/wpfui/2022/xaml    � Title$  LoginWindow��$	��250��$	��350�� � WindowStartupLocation$ CenterScreen=�.��� $��10q� � RowDefinitions �� $
��Auto ��� $
��Auto ��� $
��Auto ��� $
��Auto ��� $
��Auto ��� $��* �.+��� -    ��Name$ UserName��$��1��$��Email��$��14(��� -   $��usernameTextBox��
�������$��2��$��0,5,0,0q��� -   $ UserPassword��$��3��$��Пароль��$��14(�G� -   $��passwordTextBox��
�������$��4��$��0,5,0,0q��� $��5�� �� Orientation$ 
Horizontal=�$��Center=�$��Center=�.+�  Wpf.Ui.Controls.Button  -     Name$ LoginButton��$��
Войти��$��0,0,10,0q�   
Appearance$ Primary=�  -   $ RegisterButton��
�������$��Регистрация��$��10,0,0,0q�$ Light=�