   M S B A M L   `   `   `  ����F  BWPF_Project, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null)clr-namespace:WPF_ProjectWPF_Project  5   	       WPF_Project.AuthorsWindow   5   	   _ [MaterialDesignThemes.Wpf, Version=5.0.0.0, Culture=neutral, PublicKeyToken=df2a72020bd7962aFmaterialDesign1http://materialdesigninxaml.net/winfx/xaml/themes  5   	   W SPresentationCore, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5   	   R NSystem.Xaml, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   +localclr-namespace:WPF_Project     5   	     � Title$  AuthorsWindow��5	   	   $	��600��6   $	��450��6,    � WindowStartupLocation$ CenterScreen=�5
   	   .��5      � .+�5      �� .+�5      �� -   5        $��0��5      $��1��6)   $
��Left=�6=   $��0q�6X   .��5      � $��10,10,10,10q�6   .+�5      �� $��20��6)   $��20��64   .��5      '  !MaterialDesignThemes.Wpf.PackIcon     Kind$ 	ArrowBack=�66   $��Center=�6G   $��Center=�6b   5      5      5      �� 5      $��Новый автор��6   $
��Bold"�6/   $��16(�6A   $��0 0 0 10q�6O   $��Center=�6a   �� 5       �� Orientation$ 
Horizontal=�6   $��0 0 0 10q�66   $��Center=�6H   .+�5      �� $��Автор:��6    $��0 5 10 0q�6.   �� 5      -   5         ��Name$ newAuthorNameTextBox��5      $	��150��6<   5      �� 5      -   5        $#��Добавить автора��5      $	��150��6Q   $��Center=�6]   �� 5      $��Авторы��6   $
��Bold"�6*   $��16(�6<   $��	0 20 0 10q�6J   &   System.Windows.Controls.DataGrid  5       -   5          Name$ dataGrid��5       $	��200��6M      AutoGenerateColumns$ False��6Z   
�������
���������6-   �� *	Authors+   Columns 5!      0  *System.Windows.Controls.DataGridTextColumn  5"      ,  &System.Windows.Controls.DataGridColumn   Header$ ID��6-   	   Width5  /System.Windows.Controls.DataGridLengthConverter$
	 Auto 6V   
   
IsReadOnly$

 True��6c   1  +System.Windows.Controls.DataGridBoundColumn   Binding 69   �� *
AuthorId+6c     5#      $
 Name��6-   $	 * 6Z   $

 True��6d    6;   �� *
AuthorName+6d   5%      �� 5&      $ 
Horizontal=�6   $��	0 10 0 10q�66   $��Center=�6I   .+�5'      �� $+��%Изменить имя автора:��6    $��0 5 10 0q�6<   �� 5(      -   5        $ EditAuthorNameTextBox��5(      $	��150��6=   5)      �� 5*      -   5        $#��Изменить автора��5*      $	��150��6N   $��Center=�6Z   �� 5+      -   5        $!��Удалить автора��5+      $��0 10 0 0q�6O   $	��150��6a   $��Center=�6m   5/      51      52      