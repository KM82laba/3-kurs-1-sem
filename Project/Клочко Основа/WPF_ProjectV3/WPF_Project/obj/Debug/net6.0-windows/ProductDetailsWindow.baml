   M S B A M L   `   `   `  ����F  BWPF_Project, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null)clr-namespace:WPF_ProjectWPF_Project  5   	   &     WPF_Project.ProductDetailsWindow   5   	   W SPresentationCore, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     R NSystem.Xaml, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   +localclr-namespace:WPF_Project     5   	   _ [MaterialDesignThemes.Wpf, Version=5.0.0.0, Culture=neutral, PublicKeyToken=df2a72020bd7962aFmaterialDesign1http://materialdesigninxaml.net/winfx/xaml/themes  5   	   D @ModernWpf, Version=0.9.7.0, Culture=neutral, PublicKeyToken=nullM IModernWpf.Controls, Version=0.9.7.0, Culture=neutral, PublicKeyToken=null-uim!http://schemas.modernwpf.com/2019   5	   	   A	 =Wpf.Ui, Version=2.1.0.0, Culture=neutral, PublicKeyToken=null/ui&http://schemas.lepo.co/wpfui/2022/xaml 	 5
   	   4xctk)http://schemas.xceed.com/wpf/xaml/toolkit 	 5   	     � Title$  ProductDetailsWindow��5   	   $	��900��6&   $
��1000��63    � WindowStartupLocation$ CenterScreen=�5   	   .��5      � $��10q�6    � RowDefinitions 5   
   �� 5      $
��Auto �6   �� 5      $
��Auto �6   �� 5      $
��Auto �6   �� 5      $
��Auto �6   .+�5   
   �  � ColumnDefinitions 5      �� 5      $	��275 �6#   �� 5      $��* �6#   .+�5       � .+�5"      �� -   5         ��Name$ BookDetailStackPanel��5"      .+�5#      �� -   5         ��Name$ coverImageBlock��5#      $��7��65   $	��200��6`   $	��150��6m   $��	0,10,0,10q�6y   ��6B   �� *
CoverImage+6y   �� 5$      -   5        $��Читать книгу��5$      $	��150��66   $��30��6B   $��	0,10,0,10q�6N   $��Center=�6z   �� 5%      -   5        $ 
StatusBook��5%   :    �� Orientation$ 
Horizontal=�6!   .+�5&      �� $��Статус книги: ��6    $��5q�69   �� 5(      -   5         ��Name$ StatusComboBox��5+      $	��130��5*      $��42 0 0 0q�5-      $��35��5.      ��5(   #   �� *%#UserBooksViewModel.PossibleStatuses+ �� SelectedItem 5)      �� *#!UserBooksViewModel.SelectedStatus+5.      50      �� 51      -   5        $ 	OrderBook��51   !   $��0 10 0 0q�64   .+�52      �� -   5        $ OrderBookVertical��52   %   $ 
Horizontal=�6@   $��Center=�6Y   .+�53      �� $$��Количество книг:��6$   $��Center=�6?   $��0 0 30 0q�6Z   �� 54      -   5        	 ��Name$	 quantityTextBlock��54   &   $	��130��6A   $��
0 10 15 10q�6M   $��0 10 0 0q�6a   $��35��6t   55      �� 56      -	   5        
 ��Name$
 	Order_btn��56   !   $��Заказать��6L   $	��100��6_   $��30��6k   $��Center=�6w   $��0 5 0 0q�6�   57      59      5:      � 5;      $��1��6   $��0 0 20 0q�6#    5<      �� 5=      $
��Auto �6$   �� 5>      $
��Auto �6$   �� 5?      $
��Auto �6$   �� 5@      $
��Auto �6$   �� 5A      $
��Auto �6$   �� 5B      $
��Auto �6$   �� 5C      $
��Auto �6$   �� 5D      $��* �6$   .+�5F      �� -
   5         ��Name$ titleTextBlock��5F      $��0��65   $��24(�6Y   $
��Bold"�6g   ��6B   �� *Title+6g   �� 5G      -   5        $ priceTextBlock��5G      $��5��65   $��14(�6o   
���  ��$��0,10,0,0q�6�   ��6B   �� *Price+ �� StringFormat$ {0:C}��6�   �� 5H      -   5        $ quantityTextBox��5H      $��6��66   $��14(�6]   $��0,10,0,0q�6k   ��6C   �� *
Quantity+6k   �� 5I      -   5        $ descriptionTextBlock��5I      $��7��6:   $��0,10,0,0q�6d   $��14(�6v   $
��Wrap=�6�   ��6G   �� *Description+6�   �� 5J      -   5        $ yearPublishedTextBlock��5J      $��4��6=   $��0,10,0,0q�6�   $��14(�6�   ��6J   �� *YearPublished+$ Year published: {0:yyyy}��6�   �� 5K      -   5        $ publisherTextBlock��5K      $��3��69   $��0,10,0,0q�6b   $��14(�6t   ��6F   �� *
Publishers+6t   �� 5L      -   5        $ authorsTextBlock��5L      $��2��67   $��0,10,0,0q�6a   $��14(�6s   ��6D   �� *AuthorsName+6s   �� 5M      -   5        $ categoryTextBlock��5M      $��1��68   $��0,10,0,0q�6c   $��14(�6u   ��6E   �� *CategoryName+6u   5N      5O      � 5P   
   $��1��6    5Q      �� 5R      $	��36* �6#   �� 5S      $
��209* �6#   .+�5V      �� $��2��6   .+�5W      �� -   5        $ ReviewStackPanel��5W      .+�5X      �� -   5        $	 ReviewRichTextBox��5X      $��50��6:   $	��300��6F   
���   �$��0,10,0,0q�6f   �� 5Y      $ 
Horizontal=�6!   $��Center=�6:   $��Center=�6W   .+�5Z      �� $��Rating: ��6$   $��25��64   $��14(�6@      WPF_Project.Rating  5[      -   5          Name$ RatingControl��5[   '   $��60��6>   $	��100��6J   $��Center=�6V   5\      �� 5]      -   5        $
 
SendReview��5]      $��Отправить��61   $	��120��6G   $��30��6S   $��	0,10,0,10q�6_   $��Center=�6�   5^      �� 5_      -   5        $
 DeleteReview��5_      $	��200��6/   $+��%Удалить комментарий��6;   $��Center=�6n   $��0 10 q�6�   �� 5`      -   5         ��Name$ ReviewsListView��5`      $	��250��6d   
�������$��0 10 q�6�   ��63   �� *ReviewsViewModel.Reviews+��5a      �� 5b      .R�5c      �� $ Vertical=�6)   .+�5d   "   �� $ 
Horizontal=�6-   .+�5e   &   '  !MaterialDesignThemes.Wpf.PackIcon     Kind$ AccountCircle=�6>   $��Center=�6S   $��Center=�6n   $��30��6�   $��30��6�   �� 5f   &   $��5q�6J   
���   �$
��Bold"�6h   $��17(�6z   ��60   �� *
UserName+6z   5g   #   �� 5h   "   $ 
Horizontal=�6-   $��3q�6F   .+�5i   &   �� $	��★��60   
��� ���$��17(�6Q   �� 5j   &   
��� ���$��17(�6Z   ��60   �� *Rating+6Z   5k   #   �� 5l   "   $��5q�6H   
���   �$��17(�6f   ��6,   �� *
ReviewText+6f   5m      5n      5p      5q      5r      5t      5v      