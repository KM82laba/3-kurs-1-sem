   M S B A M L   `   `   `  ���� F  BWPF_Project, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null)clr-namespace:WPF_ProjectWPF_Project  #    WPF_Project.OrdersAdminWindow   W SPresentationCore, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     R NSystem.Xaml, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     @d2http://schemas.microsoft.com/expression/blend/2008     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     +localclr-namespace:WPF_Project     _ [MaterialDesignThemes.Wpf, Version=5.0.0.0, Culture=neutral, PublicKeyToken=df2a72020bd7962aFmaterialDesign1http://materialdesigninxaml.net/winfx/xaml/themes    � Title$  OrdersAdminWindow��$	��450��$
��1000�� � WindowStartupLocation$ CenterScreen=� � 	Resources "   WPF_Project.AdminIdConverter   adminIdConverter��%   &	          .���  � RowDefinitions �� $
��auto ��� $
��auto ��� $
��auto �.+��� -   $
��Left=�$��0q�.��� $��10,10,10,10q�.+��� $��20��$��20��.��'  !MaterialDesignThemes.Wpf.PackIcon     Kind$ 	ArrowBack=�$��Center=�$��Center=�&   System.Windows.Controls.DataGrid  -     Name$ dataGrid��$��1��   AutoGenerateColumns$ False������ *Orders+   Columns 0  *System.Windows.Controls.DataGridTextColumn  ,  &System.Windows.Controls.DataGridColumn   Header$ OrderId��	   Width5  /System.Windows.Controls.DataGridLengthConverter$
	 Auto 
   
IsReadOnly$

 True��1  +System.Windows.Controls.DataGridBoundColumn   Binding �� *	OrderId+  $ UserId��$	 * $

 True�� �� *UserId+  $ 
UserAdress��$	 * $

 True�� �� *
UserAdress+  $ UserFirstName��$	 * $

 True�� �� *UserFirstName+  $ UserLastName��$	 * $

 True�� �� *UserLastName+  $ UserPhoneNumber��$	 * $

 True�� �� *UserPhoneNumber+  $ 	OrderDate��$	 * $

 True�� �� *	OrderDate+  $ DeliveryDate��$	 * $

 True�� �� *DeliveryDate+  $ BookId��$	 * $

 True�� �� *BookId+  $ Quantity��$	 * $

 True�� �� *
Quantity+  $ Price��$	 * $

 True�� �� *Price+  $ AdminId��$	 * $

 True�� �� *	AdminId+ �� 	Converter# [  ��  �� Orientation$ 
Horizontal=�$��Center=�$��2��.+��� -   $	��150��$#��Заказ доставлен��$��10q��� -   $	��150��$��Принять заказ��$��10q�