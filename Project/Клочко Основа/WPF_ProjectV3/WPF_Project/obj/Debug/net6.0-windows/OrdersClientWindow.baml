   M S B A M L   `   `   `  ����F  BWPF_Project, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null)clr-namespace:WPF_ProjectWPF_Project  5   	   $    WPF_Project.OrdersClientWindow   5   	   W SPresentationCore, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5   	   R NSystem.Xaml, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   +localclr-namespace:WPF_Project     5   	     � Title$  OrdersClientWindow��5   	   $	��450��6$   $	��700��61    � WindowStartupLocation$ CenterScreen=�5	   	    � 	Resources 5      (   "WPF_Project.AdminIdConverterClient   adminIdConverter��%   &	          5   
   6'   5      .��5      � .+�5   
   �� .+�5      &   System.Windows.Controls.DataGrid  -   5          Name$ dataGrid��5      $	��350��6H      AutoGenerateColumns$ False��6U      CanUserAddRows$ False��6s   ��6)   �� *Orders+   Columns 5      0  *System.Windows.Controls.DataGridTextColumn  5      ,  &System.Windows.Controls.DataGridColumn   Header$ 
Книга��6)      Width5  /System.Windows.Controls.DataGridLengthConverter$ * 6V   	   
IsReadOnly$
	 True��6`   1  +System.Windows.Controls.DataGridBoundColumn
   Binding
 68   �� *	BookTitle+6`     5      $ Дата заказа��6)   $ * 6\   $
	 True��6f   
 6>   �� *	OrderDate+6f     5      $ Дата доставки��6)   $ * 6a   $
	 True��6k   
 6@   �� *DeliveryDate+6k     5      $ Количество��6)   $ * 6Z   $
	 True��6d   
 6=   �� *
Quantity+6d     5      $ Цена книги��6)   $ * 6W   $
	 True��6a   
 6=   �� *Price+6a     5      $% Состояние заказа��6)   $ * 6�   $
	 True��6�   
 6C   �� *	AdminId+ �� 	Converter# [  6�   5      �� 5      -   5        $	��150��5      $��30��6!   $!��Отменить заказ��6-   $��10q�6[   $��Center=�6g   5      5      5      