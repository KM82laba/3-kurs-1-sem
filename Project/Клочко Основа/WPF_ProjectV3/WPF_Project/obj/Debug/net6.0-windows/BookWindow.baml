   M S B A M L   `   `   `  ����F  BWPF_Project, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null)clr-namespace:WPF_ProjectWPF_Project  5   	       WPF_Project.BookWindow   5   	   _ [MaterialDesignThemes.Wpf, Version=5.0.0.0, Culture=neutral, PublicKeyToken=df2a72020bd7962aFmaterialDesign1http://materialdesigninxaml.net/winfx/xaml/themes  5   	   W SPresentationCore, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5   	   R NSystem.Xaml, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   +localclr-namespace:WPF_Project     5   	   A =Wpf.Ui, Version=2.1.0.0, Culture=neutral, PublicKeyToken=null0uiw&http://schemas.lepo.co/wpfui/2022/xaml  5   	   D @ModernWpf, Version=0.9.7.0, Culture=neutral, PublicKeyToken=nullM	 IModernWpf.Controls, Version=0.9.7.0, Culture=neutral, PublicKeyToken=null,ui!http://schemas.modernwpf.com/2019  	 5   	     � Title$  
Bookmarket��5
   	   $	��700��6   $	��930��6)    � WindowStartupLocation$ CenterScreen=�5   	    � 	Resources 5      ��%    5      .��5      � $
��auto��6   $
��auto��6    � RowDefinitions 5   
   �� 5      $
��auto �6   �� 5      $
��auto �6   �� 5      $
��auto �6   �� 5      $��* �6   .+�5   
   �� -   5        $��1��5      $
��Left=�6%   $��0q�6@   $��77,0,0,0q�6p   .��5      � $��10,10,10,10q�6   .+�5      �� $��50��6!   $��50��6,   .��5      '  !MaterialDesignThemes.Wpf.PackIcon     Kind$
 Plus=�6.   $��Center=�6:   $��Center=�6U   $��30��6r   $��30��6}   5      5      5       �� 5!   
   -   5        $��1��5!      $
��Left=�6%   $��0q�6@   .��5"      � $��10,10,10,10q�6   .+�5$      �� $��50��6!   $��50��6,   .��5%        $ 	ArrowBack=�6.   $��Center=�6?   $��Center=�6Z   $��30��6w   $��30��6�   5&      5'      5(      �� 5)   
   -   5         ��Name$ btnRefrechListOfProduct��5)      $
��Left=�62   $��0q�6M   $��	154,0,0,0q�6�   .��5*      � $��10,10,10,10q�6   .+�5+      �� $��50��6!   $��50��6,   .��5,        $ Refresh=�6.   $��Center=�6=   $��Center=�6X   $��30��6u   $��30��6�   5-      5.      5/      �� 51   
   -   5        $��0q�51      $��	246,0,0,0q�6�   ��6=   �� *DeleteProductCommand+��6f   �� *SelectedProduct+.��52      � $��10,10,10,10q�6   .+�54      �� $��50��6!   $��50��6,   .��55        $ Trash=�6.   $��Center=�6;   $��Center=�6V   $��30��6s   $��30��6~   56      57      58      �� 59   
   -   5        $��0q�59      $��	343,0,0,0q�6;   .��5:      � $��10,10,10,10q�6   .+�5<      �� $��50��6!   $��50��6,   .��5=        $ DatabaseEdit=�6.   $��Center=�6B   $��Center=�6]   $��30��6z   $��30��6�   5>      5?      5@      �� 5A   
   $��1��6   $��Center=�6"   $��Center=�6=    �� Orientation$ 
Horizontal=�6Z   $��10q�6s   .+�5B      �� -   5         ��Name$ 	searchBox��5B      $	��300��6)   �� 5C      -   5        $ SearchButton��5C      $��25��6+   $��25��66   $��0q�6]   $��1��6q   $��1��6�   
�������$��10 0 0 0q�6�   ��6�   �� .��5D      � .+�5E      �� $��25��6%   $��25��60   .��5F        $ Search=�62   $��Center=�6@   $��Center=�6[   $��30��6x   $��30��6�   5G      5H      5I      5J      �� 5K   
   $��2��6   $��1��6"   $ 
Horizontal=�62   .+�5L        Wpf.Ui.Controls.Button  -   5          Name$ SortTitleButton��5L      $��Название��6P   $��16(�6c   	   Icon$	 ArrowSortDown16=�6q   $��10q�6�     5M      -	   5        $ SortPriceButton��5M      $��Цена��6P   $��16(�6_   $	 ArrowSortDown16=�6m   $��10q�6�   5N      �� 5P   
   -
   5        
 ��Name$
 productsList��5P   &   $��0q�6    �� SelectionMode$ Single=�6Z   $��3��6�   $��1��6�   ��6<   �� *Books+��5Q      �� 5R      .R�5S      A�  A� Columns$ 4��6"   5T      ��5V      �� 5W      .R�5X      5  /ModernWpf.Controls.Primitives.ThemeShadowChrome     Depth$ 20Q�6+      IsShadowEnabled$
 True��66   $	��300��6M   ._�5Y      �� $	��200��6%   
�������.+�5Z      �� $	��150��6B   $	��150��6O   $��5q�6[   ��6$   �� *
CoverImage+6[   �� 5[      
���   �$
��Bold"�6R   $��16(�6d   $��5q�6r   ��6(   �� *Title+6r   �� 5\      
���   �$��5q�6�   ��6(   �� *YearPublished+ �� StringFormat$% Год издания: {0:yyyy}��6�   �� 5]      
���   �$��5q�6o   ��6(   �� *Price+$ 
{0:N2} BYN��6o   �� 5^      
���   �$��5q�6X   ��6(   �� *Description+6X   5_      5`      5a      5c      5e      5f      