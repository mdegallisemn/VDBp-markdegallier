select 
max(p.First_Name) as First_Name,
max(p.Last_Name) as Last_Name,
max(a.Street_1) as Street_1,
max(a.Street_2) as Street_2,
max(a.City) as City,
max(a.State) as State,
max(a.Zip) as Zip,
max(apt.Apt_Number) as Apt_Number,
max(admin.First_Name) as adminFirst_Name,
max(admin.Last_Name) as adminLast_Name,
max(admin.Phone_Number) as adminPhone_Number,
max(i.InvoiceID) as InvoiceID,
max(i.InvoiceDate) as InvoiceDate,
max(i.DueDate) as DueDate,
max(l.Qty) as Qty,
max(prod.Description) as Description,
max(prod.Price) as Price,
sum(l.Qty*prod.Price) as LineTotal,
max(r.Receipt_ID) as Receipt_ID,
max(r.ReceiptAmount) as ReceiptAmount,
max(r.ReceiptDate) as ReceiptDate,
max(der.grand_total) as InvoiceTotal

from Invoice as i 

join Apartment as apt on apt.Apartment_ID=i.Apartment_ID
join Person as p on p.Person_ID=apt.Tenant_ID
join Person as admin on admin.Person_ID=apt.Manager_ID
left join Address as a on a.Address_ID=p.Address_ID
join LineItem as l on l.Invoice_ID = i.InvoiceID
join Product as prod on prod.Product_ID=l.Product_ID
join Receipt as r on r.Invoice_ID = i.InvoiceID
join 
	(select max(l.Invoice_ID) as Invoice_ID, sum(l.Qty*prod.Price) as grand_total from Invoice i 
	join LineItem l on l.Invoice_ID=i.InvoiceID
	join Product prod on prod.Product_ID=l.Product_ID) as der 
	on der.Invoice_ID=i.InvoiceID

where i.InvoiceID = 1

 group by l.LineItem_ID
