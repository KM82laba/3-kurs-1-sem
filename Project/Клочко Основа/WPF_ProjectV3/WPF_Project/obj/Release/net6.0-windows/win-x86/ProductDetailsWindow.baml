   M S B A M L   `   `   `  ���� F  BWPF_Project, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null)clr-namespace:WPF_ProjectWPF_Project  &     WPF_Project.ProductDetailsWindow   W SPresentationCore, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     R NSystem.Xaml, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     @d2http://schemas.microsoft.com/expression/blend/2008     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     +localclr-namespace:WPF_Project     _ [MaterialDesignThemes.Wpf, Version=5.0.0.0, Culture=neutral, PublicKeyToken=df2a72020bd7962aFmaterialDesign1http://materialdesigninxaml.net/winfx/xaml/themes  D @ModernWpf, Version=0.9.7.0, Culture=neutral, PublicKeyToken=nullM IModernWpf.Controls, Version=0.9.7.0, Culture=neutral, PublicKeyToken=null-uim!http://schemas.modernwpf.com/2019   A	 =Wpf.Ui, Version=2.1.0.0, Culture=neutral, PublicKeyToken=null/ui&http://schemas.lepo.co/wpfui/2022/xaml 	 4xctk)http://schemas.xceed.com/wpf/xaml/toolkit 	   � Title$  ProductDetailsWindow��$	��900��$
��1000�� � WindowStartupLocation$ CenterScreen=�.��� $��10q� � RowDefinitions �� $
��Auto ��� $
��Auto ��� $
��Auto ��� $
��Auto �.+��  � ColumnDefinitions �� $	��275 ��� $��* �.+�� .+��� -    ��Name$ BookDetailStackPanel��.+��� -    ��Name$ coverImageBlock��$��7��$	��200��$	��150��$��	0,10,0,10q����� *
CoverImage+�� -   $��Читать книгу��$	��150��$��30��$��	0,10,0,10q�$��Center=��� -   $ 
StatusBook�� �� Orientation$ 
Horizontal=�.+��� $��Статус книги: ��$��5q��� -    ��Name$ StatusComboBox��$	��130��$��42 0 0 0q�$��35������ *%#UserBooksViewModel.PossibleStatuses+ �� SelectedItem �� *#!UserBooksViewModel.SelectedStatus+�� -   $ 	OrderBook��$��0 10 0 0q�.+��� -   $ OrderBookVertical��$ 
Horizontal=�$��Center=�.+��� $$��Количество книг:��$��Center=�$��0 0 30 0q��� -   	 ��Name$	 quantityTextBlock��$	��130��$��
0 10 15 10q�$��0 10 0 0q�$��35���� -	   
 ��Name$
 	Order_btn��$��Заказать��$	��100��$��30��$��Center=�$��0 5 0 0q�� $��1��$��0 0 20 0q� �� $
��Auto ��� $
��Auto ��� $
��Auto ��� $
��Auto ��� $
��Auto ��� $
��Auto ��� $
��Auto ��� $��* �.+��� -
    ��Name$ titleTextBlock��$��0��$��24(�$
��Bold"����� *Title+�� -   $ priceTextBlock��$��5��$��14(�
���  ��$��0,10,0,0q����� *Price+ �� StringFormat$ {0:C}���� -   $ quantityTextBox��$��6��$��14(�$��0,10,0,0q����� *
Quantity+�� -   $ descriptionTextBlock��$��7��$��0,10,0,0q�$��14(�$
��Wrap=����� *Description+�� -   $ yearPublishedTextBlock��$��4��$��0,10,0,0q�$��14(����� *YearPublished+$ Year published: {0:yyyy}���� -   $ publisherTextBlock��$��3��$��0,10,0,0q�$��14(����� *
Publishers+�� -   $ authorsTextBlock��$��2��$��0,10,0,0q�$��14(����� *AuthorsName+�� -   $ categoryTextBlock��$��1��$��0,10,0,0q�$��14(����� *CategoryName+� $��1�� �� $	��36* ��� $
��209* �.+��� $��2��.+��� -   $ ReviewStackPanel��.+��� -   $	 ReviewRichTextBox��$��50��$	��300��
���   �$��0,10,0,0q��� $ 
Horizontal=�$��Center=�$��Center=�.+��� $��Rating: ��$��25��$��14(�   WPF_Project.Rating  -     Name$ RatingControl��$��60��$	��100��$��Center=��� -   $
 
SendReview��$��Отправить��$	��120��$��30��$��	0,10,0,10q�$��Center=��� -   $
 DeleteReview��$	��200��$+��%Удалить комментарий��$��Center=�$��0 10 q��� -    ��Name$ ReviewsListView��$	��250��
�������$��0 10 q����� *ReviewsViewModel.Reviews+���� .R��� $ Vertical=�.+��� $ 
Horizontal=�.+�'  !MaterialDesignThemes.Wpf.PackIcon     Kind$ AccountCircle=�$��Center=�$��Center=�$��30��$��30���� $��5q�
���   �$
��Bold"�$��17(����� *
UserName+�� $ 
Horizontal=�$��3q�.+��� $	��★��
��� ���$��17(��� 
��� ���$��17(����� *Rating+�� $��5q�
���   �$��17(����� *
ReviewText+