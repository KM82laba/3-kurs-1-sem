   M S B A M L   `   `   `  ���� F  BWPF_Project, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null)clr-namespace:WPF_ProjectWPF_Project  $    WPF_Project.OrdersClientWindow   W SPresentationCore, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     R NSystem.Xaml, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     @d2http://schemas.microsoft.com/expression/blend/2008     Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     +localclr-namespace:WPF_Project       � Title$  OrdersClientWindow��$	��450��$	��700�� � WindowStartupLocation$ CenterScreen=� � 	Resources (   "WPF_Project.AdminIdConverterClient   adminIdConverter��%   &	          .��� .+��� .+�&   System.Windows.Controls.DataGrid  -     Name$ dataGrid��$	��350��   AutoGenerateColumns$ False��   CanUserAddRows$ False������ *Orders+   Columns 0  *System.Windows.Controls.DataGridTextColumn  ,  &System.Windows.Controls.DataGridColumn   Header$ 
Книга��   Width5  /System.Windows.Controls.DataGridLengthConverter$ * 	   
IsReadOnly$
	 True��1  +System.Windows.Controls.DataGridBoundColumn
   Binding
 �� *	BookTitle+  $ Дата заказа��$ * $
	 True��
 �� *	OrderDate+  $ Дата доставки��$ * $
	 True��
 �� *DeliveryDate+  $ Количество��$ * $
	 True��
 �� *
Quantity+  $ Цена книги��$ * $
	 True��
 �� *Price+  $% Состояние заказа��$ * $
	 True��
 �� *	AdminId+ �� 	Converter# [  �� -   $	��150��$��30��$!��Отменить заказ��$��10q�$��Center=�