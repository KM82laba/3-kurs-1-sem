   M S B A M L   `   `   `  ���� F  BWPF_Project, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null)clr-namespace:WPF_ProjectWPF_Project      WPF_Project.AuthorsWindow   _ [MaterialDesignThemes.Wpf, Version=5.0.0.0, Culture=neutral, PublicKeyToken=df2a72020bd7962aFmaterialDesign1http://materialdesigninxaml.net/winfx/xaml/themes  W SPresentationCore, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     R NSystem.Xaml, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     @d2http://schemas.microsoft.com/expression/blend/2008     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     +localclr-namespace:WPF_Project       � Title$  AuthorsWindow��$	��600��$	��450�� � WindowStartupLocation$ CenterScreen=�.��� .+��� .+��� -   $��0��$��1��$
��Left=�$��0q�.��� $��10,10,10,10q�.+��� $��20��$��20��.��'  !MaterialDesignThemes.Wpf.PackIcon     Kind$ 	ArrowBack=�$��Center=�$��Center=��� $��Новый автор��$
��Bold"�$��16(�$��0 0 0 10q�$��Center=���  �� Orientation$ 
Horizontal=�$��0 0 0 10q�$��Center=�.+��� $��Автор:��$��0 5 10 0q��� -    ��Name$ newAuthorNameTextBox��$	��150���� -   $#��Добавить автора��$	��150��$��Center=��� $��Авторы��$
��Bold"�$��16(�$��	0 20 0 10q�&   System.Windows.Controls.DataGrid  -     Name$ dataGrid��$	��200��   AutoGenerateColumns$ False��
�������
����������� *	Authors+   Columns 0  *System.Windows.Controls.DataGridTextColumn  ,  &System.Windows.Controls.DataGridColumn   Header$ ID��	   Width5  /System.Windows.Controls.DataGridLengthConverter$
	 Auto 
   
IsReadOnly$

 True��1  +System.Windows.Controls.DataGridBoundColumn   Binding �� *
AuthorId+  $
 Name��$	 * $

 True�� �� *
AuthorName+�� $ 
Horizontal=�$��	0 10 0 10q�$��Center=�.+��� $+��%Изменить имя автора:��$��0 5 10 0q��� -   $ EditAuthorNameTextBox��$	��150���� -   $#��Изменить автора��$	��150��$��Center=��� -   $!��Удалить автора��$��0 10 0 0q�$	��150��$��Center=�