   M S B A M L   `   `   `  ����F  BWPF_Project, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null)clr-namespace:WPF_ProjectWPF_Project  5   	       WPF_Project.ClientWindow   5   	   W SPresentationCore, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5   	   R NSystem.Xaml, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   +localclr-namespace:WPF_Project     5   	   _ [MaterialDesignThemes.Wpf, Version=5.0.0.0, Culture=neutral, PublicKeyToken=df2a72020bd7962aFmaterialDesign1http://materialdesigninxaml.net/winfx/xaml/themes  5   	   D @ModernWpf, Version=0.9.7.0, Culture=neutral, PublicKeyToken=nullM IModernWpf.Controls, Version=0.9.7.0, Culture=neutral, PublicKeyToken=null,ui!http://schemas.modernwpf.com/2019   5
   	   A	 =Wpf.Ui, Version=2.1.0.0, Culture=neutral, PublicKeyToken=null0uiw&http://schemas.lepo.co/wpfui/2022/xaml 	 5   	     � Title$  ClientWindow��5	   	   $	��720��6   $
��1300��6+    � WindowStartupLocation$ CenterScreen=�5   	   .��5      � $��	10 0 10 0q�6    � RowDefinitions 5   
   �� 5      $
��auto �6   �� 5      $
��auto �6   �� 5      $��* �6    � ColumnDefinitions 5   
   �� 5      $	��330 �6   �� 5      $��* �6   .+�5   
   �� -   5        $��0��5      $
��Left=�6   $��0q�69   .��5      � $��10,10,10,10q�6   .+�5      �� $��20��6!   $��20��6,   .��5      '  !MaterialDesignThemes.Wpf.PackIcon     Kind$ 	ArrowBack=�6.   $��Center=�6?   $��Center=�6Z   5      5      5      �� 5    
   -   5        $��0q�5       $��67,0,0,0q�6G   .��5!      � $��10,10,10,10q�6   .+�5"      �� $��20��6!   $��20��6,   .��5#        $
 Cart=�6.   $��Center=�6:   $��Center=�6U   5$      5%      5&      �� 5'   
   -   5        $��0q�5'      $��	134,0,0,0q�6E   .��5(      � $��10,10,10,10q�6   .+�5)      �� $��20��6!   $��20��6,   .��5*        $ Account=�6.   $��Center=�6=   $��Center=�6X   5+      5,      5-      � 5.   
   $��1��6    5/      �� 50      $
��auto �6#   �� 51      $
��auto �6#   .+�53      �� $��Здравствуйте ��6   $��0��6-   $
��Bold"�6=   $��20(�6O   �� 54      -   5         ��Name$ 	UserEmail��54   *   $��	UserEmail��6   $��1��6=   $
��Bold"�6M   $��20(�6_   55      �� 56   
   $��1��6   $��1��6"    �� Orientation$ 
Horizontal=�62   $��10q�6K   .+�57      �� .+�58      �� $ 
Horizontal=�6   $��	300 0 0 0q�66   .+�59      �� -   5         ��Name$ 	searchBox��59      $	��300��6)   �� 5:      -   5         ��Name$ SearchButton��5:      $��25��6+   $��25��66   $��0q�6]   $��1��6q   $��1��6�   
�������$��10 0 0 0q�6�   ��6�   �� .��5;      � .+�5<      �� $��25��6%   $��25��60   .��5=        $ Search=�62   $��Center=�6@   $��Center=�6[   $��30��6x   $��30��6�   5>      5?      5@      5A      �� 5B      $��1��6   $��1��6&   $ 
Horizontal=�66   .+�5C       	 Wpf.Ui.Controls.Button  -   5        	  Name$	 SortTitleButton��5C   !   $��
10 10 0 10q�6;   $��Название��6m   $��16(�6�   
   Icon$
 ArrowSortDown16=�6�     5D      -   5        $	 SortPriceButton��5D   !   $��
10 10 0 10q�6;   $��Цена��6m   $��16(�6|   $
 ArrowSortDown16=�6�   5E      5F      5G      �� 5H   
   $��2��6   .+�5I      �� -	   5        $��Right=�5I      $��0q�61   .��5J      � $��1q�6   .+�5K      �� $��20��6%   $��20��60   .��5L        $ Reload=�62   $��Center=�6@   $��Center=�6[   5M      5N      5O      &   System.Windows.Controls.DataGrid  5P         AutoGenerateColumns$ False��6H      CanUserAddRows$ False��6d   
���������6   �� *UserBooksViewModel.Books+   Columns 5R      0  *System.Windows.Controls.DataGridTextColumn  5S      ,  &System.Windows.Controls.DataGridColumn   Header$ 
Книга��6)      Width5  /System.Windows.Controls.DataGridLengthConverter$ * 6U      
IsReadOnly$
 True��6_   1  +System.Windows.Controls.DataGridBoundColumn   Binding 68   �� *
BookName+6_     5T      $ Статус книги��6)   $ * 6Z   $
 True��6d    6?   �� *Status+6d   5V      5W      �� 5Y   
   -
   5         ��Name$ productsList��5Y   &   $��0q�6      WindowBackground#���   6<    �� SelectionMode$ Single=�6�   $��2��6�   $��1��6�   ��6l   �� *BooksViewModel.Books+��5Z      �� 5[      .R�5\      A�  A� Columns$ 4��6"   5]      ��5_      �� 5`      .R�5b      5  /ModernWpf.Controls.Primitives.ThemeShadowChrome     Depth$ 30Q�6/      IsShadowEnabled$
 True��5c   /   $	��300��5d   0   ._�5f      �� $	��200��6)   
�������.+�5g   "   �� $	��200��6F   $	��185��6S   $��5q�6_   ��6(   �� *
CoverImage+6_   �� 5h   "   
���   �$
��Bold"�6V   $��16(�6h   $��5q�6v   ��6,   �� *Title+6v   �� 5i   "   
���   �$��5q�6�   ��6,   �� *YearPublished+ �� StringFormat$% Год издания: {0:yyyy}��6�   �� 5j   "   
���   �$��5q�6s   ��6,   �� *Price+$ 
{0:N2} BYN��6s   �� 5k   "   
���   �$��5q�6\   ��6,   �� *Description+6\   5l      5m      5p      5r      5s      5t      