   M S B A M L   `   `   `  ���� F  BWPF_Project, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null)clr-namespace:WPF_ProjectWPF_Project      WPF_Project.ClientWindow   W SPresentationCore, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     R NSystem.Xaml, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     @d2http://schemas.microsoft.com/expression/blend/2008     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     +localclr-namespace:WPF_Project     _ [MaterialDesignThemes.Wpf, Version=5.0.0.0, Culture=neutral, PublicKeyToken=df2a72020bd7962aFmaterialDesign1http://materialdesigninxaml.net/winfx/xaml/themes  D @ModernWpf, Version=0.9.7.0, Culture=neutral, PublicKeyToken=nullM IModernWpf.Controls, Version=0.9.7.0, Culture=neutral, PublicKeyToken=null,ui!http://schemas.modernwpf.com/2019   A	 =Wpf.Ui, Version=2.1.0.0, Culture=neutral, PublicKeyToken=null0uiw&http://schemas.lepo.co/wpfui/2022/xaml 	   � Title$  ClientWindow��$	��720��$
��1300�� � WindowStartupLocation$ CenterScreen=�.��� $��	10 0 10 0q� � RowDefinitions �� $
��auto ��� $
��auto ��� $��* � � ColumnDefinitions �� $	��330 ��� $��* �.+��� -   $��0��$
��Left=�$��0q�.��� $��10,10,10,10q�.+��� $��20��$��20��.��'  !MaterialDesignThemes.Wpf.PackIcon     Kind$ 	ArrowBack=�$��Center=�$��Center=��� -   $��0q�$��67,0,0,0q�.��� $��10,10,10,10q�.+��� $��20��$��20��.��  $
 Cart=�$��Center=�$��Center=��� -   $��0q�$��	134,0,0,0q�.��� $��10,10,10,10q�.+��� $��20��$��20��.��  $ Account=�$��Center=�$��Center=�� $��1�� �� $
��auto ��� $
��auto �.+��� $��Здравствуйте ��$��0��$
��Bold"�$��20(��� -    ��Name$ 	UserEmail��$��	UserEmail��$��1��$
��Bold"�$��20(��� $��1��$��1�� �� Orientation$ 
Horizontal=�$��10q�.+��� .+��� $ 
Horizontal=�$��	300 0 0 0q�.+��� -    ��Name$ 	searchBox��$	��300���� -    ��Name$ SearchButton��$��25��$��25��$��0q�$��1��$��1��
�������$��10 0 0 0q����� .��� .+��� $��25��$��25��.��  $ Search=�$��Center=�$��Center=�$��30��$��30���� $��1��$��1��$ 
Horizontal=�.+� 	 Wpf.Ui.Controls.Button  -   	  Name$	 SortTitleButton��$��
10 10 0 10q�$��Название��$��16(�
   Icon$
 ArrowSortDown16=�  -   $	 SortPriceButton��$��
10 10 0 10q�$��Цена��$��16(�$
 ArrowSortDown16=��� $��2��.+��� -	   $��Right=�$��0q�.��� $��1q�.+��� $��20��$��20��.��  $ Reload=�$��Center=�$��Center=�&   System.Windows.Controls.DataGrid     AutoGenerateColumns$ False��   CanUserAddRows$ False��
����������� *UserBooksViewModel.Books+   Columns 0  *System.Windows.Controls.DataGridTextColumn  ,  &System.Windows.Controls.DataGridColumn   Header$ 
Книга��   Width5  /System.Windows.Controls.DataGridLengthConverter$ *    
IsReadOnly$
 True��1  +System.Windows.Controls.DataGridBoundColumn   Binding �� *
BookName+  $ Статус книги��$ * $
 True�� �� *Status+�� -
    ��Name$ productsList��$��0q�   WindowBackground#���    �� SelectionMode$ Single=�$��2��$��1������ *BooksViewModel.Books+���� .R�A�  A� Columns$ 4������ .R�5  /ModernWpf.Controls.Primitives.ThemeShadowChrome     Depth$ 30Q�   IsShadowEnabled$
 True��$	��300��._��� $	��200��
�������.+��� $	��200��$	��185��$��5q����� *
CoverImage+�� 
���   �$
��Bold"�$��16(�$��5q����� *Title+�� 
���   �$��5q����� *YearPublished+ �� StringFormat$% Год издания: {0:yyyy}���� 
���   �$��5q����� *Price+$ 
{0:N2} BYN���� 
���   �$��5q����� *Description+