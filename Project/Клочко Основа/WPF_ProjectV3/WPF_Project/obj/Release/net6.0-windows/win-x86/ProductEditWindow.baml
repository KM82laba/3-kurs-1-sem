   M S B A M L   `   `   `  ���� F  BWPF_Project, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null)clr-namespace:WPF_ProjectWPF_Project  #    WPF_Project.ProductEditWindow   W SPresentationCore, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     R NSystem.Xaml, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     @d2http://schemas.microsoft.com/expression/blend/2008     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     +localclr-namespace:WPF_Project       � Title$3  -Редактирование продукта��$	��800��$	��400�� � WindowStartupLocation$ CenterScreen=�.��� $��10q� � DataContext '   !WPF_Project.AddProductDatacontext   � RowDefinitions �� $
��Auto ��� $
��Auto ��� $
��Auto ��� $
��Auto ��� $
��Auto ��� $
��Auto ��� $
��Auto ��� $
��Auto ��� $
��Auto ��� $
��Auto ��� $
��Auto ��� $
��Auto ��� $
��Auto � � ColumnDefinitions �� $
��Auto ��� .+��� -    ��Name$ NameAddProd��$��0��$��0��$��Название���� -    ��Name$ titleTextBox��$��5q�$��0��$��1��$��2���� -   $ PriseAddProd��$��1��$��0��$��Цена���� -   $ priceTextBox��$��1��$��1��$��2��$��5q��� -   $ DescAddProd��$��2��$��0��$��Описание���� -   $ descriptionTextBox��$��5q�$��2��$��1��$��2���� $��3��$��0��.+��� -   $ quantity_Label��$��5 10 0 0q�$��Количество���� -   $# yearPublishedDatePicker_Label��$��5 27 0 0q�$#��Дата публикации���� $��3��$��1��$��2��.+��� -	   $ quantityTextBox��$��5q�(  "System.Windows.Controls.DatePicker  -
     Name$ yearPublishedDatePicker��$��5q��� -   $ 
PubAddProd��$��4��$��0��$��Издатель���� -    ��Name$ publishersComboBox��	 �� DisplayMemberPath$	 PublisherName��
 �� 
IsEditable$

 True��$��4��$��1��$��5q����� *
Publishers+ �� *PublishersViewModel+�� -   $ 
AutAddProd��$��5��$��0��$��Авторы���� -    ��Name$ 
AutAddList��$	��100��$��5��$��1��$��2��$��5q� �� *AuthorsViewModel+���� *	Authors+���� .R���  �� Orientation$ 
Horizontal=�.+��� $��5q� d� 	IsChecked �� *
IsSelected+�� $��5q����� *
AuthorName+�� -   $ 
CatAddProd��$��6��$��0��$��Категории���� -   $ 
CatAddList��$	��100��$��6��$��1��$��2��$��5q� �� *CategoryViewModel+���� *
Category+���� .R��� $ 
Horizontal=�.+��� $��5q� �� *
IsSelected+�� $��5q����� *CategoryName+�� -   $ ContentAddProd��$��7��$��0��$��Контент���� -   $��5q�$��7��$��1��$��2��$!��Выберите текст��$	��200��$��Center=��� -   $ 
ImgAddProd��$��8��$��0��$��Изображение���� -   $��5q�$��8��$��1��$+��%Выбрать изображение��$	��200��$��Center=��� -    ��Name$ сoverImage��$��10q�$��9��$��1��$��2��$	��100��$	��100������ *Image+�� -    ��Name$ addBookButton��$��10��$��1��$��Сохранить��$	��200��$��Center=�