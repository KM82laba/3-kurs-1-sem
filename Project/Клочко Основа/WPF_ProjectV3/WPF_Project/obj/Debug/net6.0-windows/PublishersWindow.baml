   M S B A M L   `   `   `  ����F  BWPF_Project, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null)clr-namespace:WPF_ProjectWPF_Project  5   	   "    WPF_Project.PublishersWindow   5   	   W SPresentationCore, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5   	   _ [MaterialDesignThemes.Wpf, Version=5.0.0.0, Culture=neutral, PublicKeyToken=df2a72020bd7962aFmaterialDesign1http://materialdesigninxaml.net/winfx/xaml/themes  5   	   R NSystem.Xaml, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   +localclr-namespace:WPF_Project     5   	     � Title$  PublishersWindow��5	   	   $	��600��6"   $	��450��6/    � WindowStartupLocation$ CenterScreen=�5
   	   .��5      � .+�5   
   �� .+�5      �� -   5        $��0��5      $��1��6%   $
��Left=�69   $��0q�6T   .��5      � $��10,10,10,10q�6   .+�5      �� $��20��6%   $��20��60   .��5      '  !MaterialDesignThemes.Wpf.PackIcon     Kind$ 	ArrowBack=�62   $��Center=�6C   $��Center=�6^   5      5      5      �� 5      $!��Новый издатель��6   $
��Bold"�6.   $��16(�6@   $��0 0 0 10q�6N   $��Center=�6`   �� 5       �� Orientation$ 
Horizontal=�6   $��0 0 0 10q�62   $��Center=�6D   .+�5      �� $��Имя издателя��6   $��0 5 10 0q�60   �� 5      -   5         ��Name$ newPublisherNameTextBox��5      $	��150��6;   5      �� 5      -   5        $'��!Добавить издателя��5      $	��150��6R   $��Center=�6^   �� 5      $��Издатели��6   $
��Bold"�6(   $��16(�6:   $��	0 20 0 10q�6H   &   System.Windows.Controls.DataGrid  5      -   5          Name$ dataGrid��5      $	��200��6L      AutoGenerateColumns$ False��6Y   
�������
���������6)   �� *
Publishers+   Columns 5       0  *System.Windows.Controls.DataGridTextColumn  5!      ,  &System.Windows.Controls.DataGridColumn   Header$ ID��6)   	   Width5  /System.Windows.Controls.DataGridLengthConverter$
	 Auto 6U   
   
IsReadOnly$

 True��6b   1  +System.Windows.Controls.DataGridBoundColumn   Binding 65   �� *PublisherId+6b     5"      $
 Name��6)   $	 * 6Y   $

 True��6c    67   �� *PublisherName+6c   5$      �� 5%      $ 
Horizontal=�6   $��	0 10 0 10q�62   $��Center=�6E   .+�5&      �� $.��(Изменить имя издателя��6    $��0 5 10 0q�6=   �� 5'      -   5        $ EditPublisherNameTextBox��5'      $	��150��6<   5(      �� 5)      -   5        $'��!Изменить издателя��5)      $	��150��6S   $��Center=�6_   �� 5*      -   5        $%��Удалить издателя��5*      $��0 10 0 0q�6T   $	��150��6f   $��Center=�6r   5.      5/      50      