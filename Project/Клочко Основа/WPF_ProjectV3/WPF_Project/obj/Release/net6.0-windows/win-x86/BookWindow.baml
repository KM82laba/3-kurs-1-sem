   M S B A M L   `   `   `  ���� F  BWPF_Project, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null)clr-namespace:WPF_ProjectWPF_Project      WPF_Project.BookWindow   _ [MaterialDesignThemes.Wpf, Version=5.0.0.0, Culture=neutral, PublicKeyToken=df2a72020bd7962aFmaterialDesign1http://materialdesigninxaml.net/winfx/xaml/themes  W SPresentationCore, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     R NSystem.Xaml, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     @d2http://schemas.microsoft.com/expression/blend/2008     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     +localclr-namespace:WPF_Project     A =Wpf.Ui, Version=2.1.0.0, Culture=neutral, PublicKeyToken=null0uiw&http://schemas.lepo.co/wpfui/2022/xaml  D @ModernWpf, Version=0.9.7.0, Culture=neutral, PublicKeyToken=nullM	 IModernWpf.Controls, Version=0.9.7.0, Culture=neutral, PublicKeyToken=null,ui!http://schemas.modernwpf.com/2019  	   � Title$  
Bookmarket��$	��700��$	��930�� � WindowStartupLocation$ CenterScreen=� � 	Resources ��%    .��� $
��auto��$
��auto�� � RowDefinitions �� $
��auto ��� $
��auto ��� $
��auto ��� $��* �.+��� -   $��1��$
��Left=�$��0q�$��77,0,0,0q�.��� $��10,10,10,10q�.+��� $��50��$��50��.��'  !MaterialDesignThemes.Wpf.PackIcon     Kind$
 Plus=�$��Center=�$��Center=�$��30��$��30���� -   $��1��$
��Left=�$��0q�.��� $��10,10,10,10q�.+��� $��50��$��50��.��  $ 	ArrowBack=�$��Center=�$��Center=�$��30��$��30���� -    ��Name$ btnRefrechListOfProduct��$
��Left=�$��0q�$��	154,0,0,0q�.��� $��10,10,10,10q�.+��� $��50��$��50��.��  $ Refresh=�$��Center=�$��Center=�$��30��$��30���� -   $��0q�$��	246,0,0,0q����� *DeleteProductCommand+���� *SelectedProduct+.��� $��10,10,10,10q�.+��� $��50��$��50��.��  $ Trash=�$��Center=�$��Center=�$��30��$��30���� -   $��0q�$��	343,0,0,0q�.��� $��10,10,10,10q�.+��� $��50��$��50��.��  $ DatabaseEdit=�$��Center=�$��Center=�$��30��$��30���� $��1��$��Center=�$��Center=� �� Orientation$ 
Horizontal=�$��10q�.+��� -    ��Name$ 	searchBox��$	��300���� -   $ SearchButton��$��25��$��25��$��0q�$��1��$��1��
�������$��10 0 0 0q����� .��� .+��� $��25��$��25��.��  $ Search=�$��Center=�$��Center=�$��30��$��30���� $��2��$��1��$ 
Horizontal=�.+�  Wpf.Ui.Controls.Button  -     Name$ SortTitleButton��$��Название��$��16(�	   Icon$	 ArrowSortDown16=�$��10q�  -	   $ SortPriceButton��$��Цена��$��16(�$	 ArrowSortDown16=�$��10q��� -
   
 ��Name$
 productsList��$��0q� �� SelectionMode$ Single=�$��3��$��1������ *Books+���� .R�A�  A� Columns$ 4������ .R�5  /ModernWpf.Controls.Primitives.ThemeShadowChrome     Depth$ 20Q�   IsShadowEnabled$
 True��$	��300��._��� $	��200��
�������.+��� $	��150��$	��150��$��5q����� *
CoverImage+�� 
���   �$
��Bold"�$��16(�$��5q����� *Title+�� 
���   �$��5q����� *YearPublished+ �� StringFormat$% Год издания: {0:yyyy}���� 
���   �$��5q����� *Price+$ 
{0:N2} BYN���� 
���   �$��5q����� *Description+