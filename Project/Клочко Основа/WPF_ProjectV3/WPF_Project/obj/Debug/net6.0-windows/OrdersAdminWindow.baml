   M S B A M L   `   `   `  ����F  BWPF_Project, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null)clr-namespace:WPF_ProjectWPF_Project  5   	   #    WPF_Project.OrdersAdminWindow   5   	   W SPresentationCore, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5   	   R NSystem.Xaml, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   +localclr-namespace:WPF_Project     5   	   _ [MaterialDesignThemes.Wpf, Version=5.0.0.0, Culture=neutral, PublicKeyToken=df2a72020bd7962aFmaterialDesign1http://materialdesigninxaml.net/winfx/xaml/themes  5   	     � Title$  OrdersAdminWindow��5	   	   $	��450��6#   $
��1000��60    � WindowStartupLocation$ CenterScreen=�5
   	    � 	Resources 5      "   WPF_Project.AdminIdConverter   adminIdConverter��%   &	          5   
   6!   5      .��5      �  � RowDefinitions 5   
   �� 5      $
��auto �6   �� 5      $
��auto �6   �� 5      $
��auto �6   .+�5   
   �� -   5        $
��Left=�5      $��0q�6,   .��5      � $��10,10,10,10q�6   .+�5      �� $��20��6!   $��20��6,   .��5      '  !MaterialDesignThemes.Wpf.PackIcon     Kind$ 	ArrowBack=�6.   $��Center=�6?   $��Center=�6Z   5      5      5      &   System.Windows.Controls.DataGrid  5   
   -   5          Name$ dataGrid��5       $��1��6      AutoGenerateColumns$ False��6Q   ��62   �� *Orders+   Columns 5      0  *System.Windows.Controls.DataGridTextColumn  5      ,  &System.Windows.Controls.DataGridColumn   Header$ OrderId��6%   	   Width5  /System.Windows.Controls.DataGridLengthConverter$
	 Auto 6R   
   
IsReadOnly$

 True��6_   1  +System.Windows.Controls.DataGridBoundColumn   Binding 66   �� *	OrderId+6_     5      $ UserId��6%   $	 * 6P   $

 True��6Z    65   �� *UserId+6Z     5       $ 
UserAdress��6%   $	 * 6X   $

 True��6b    69   �� *
UserAdress+6b     5!      $ UserFirstName��6%   $	 * 6^   $

 True��6h    6<   �� *UserFirstName+6h     5"      $ UserLastName��6%   $	 * 6\   $

 True��6f    6;   �� *UserLastName+6f     5#      $ UserPhoneNumber��6%   $	 * 6b   $

 True��6l    6>   �� *UserPhoneNumber+6l     5%      $ 	OrderDate��6%   $	 * 6V   $

 True��6`    68   �� *	OrderDate+6`     5&      $ DeliveryDate��6%   $	 * 6\   $

 True��6f    6;   �� *DeliveryDate+6f     5'      $ BookId��6%   $	 * 6P   $

 True��6Z    65   �� *BookId+6Z     5(      $ Quantity��6%   $	 * 6T   $

 True��6^    67   �� *
Quantity+6^     5)      $ Price��6%   $	 * 6N   $

 True��6X    64   �� *Price+6X     5*      $ AdminId��6%   $	 * 6   $

 True��6�    66   �� *	AdminId+ �� 	Converter# [  6�   5,      �� 5-   
    �� Orientation$ 
Horizontal=�6   $��Center=�6.   $��2��6K   .+�5.      �� -   5        $	��150��5.      $#��Заказ доставлен��6"   $��10q�6<   6H   �� 5/      -   5        $	��150��5/      $��Принять заказ��6!   $��10q�6V   50      51      52      