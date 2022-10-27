create or replace procedure insert_data(v_contract_id number)
is 
v_installements_date date ; 
v_installments_amount number ;
v_contract_start_date date ; 
v_contract_end_date date ; 
v_payments_installments_no number ; 
v_contract_payment_type varchar2(100); 
v_contract_total_fees number ; 
v_contract_deposit_fees number;
v_contract_start_datee date;
begin 
select  contract_start_date , contract_end_date , payments_installments_no 
,contract_payment_type , nvl(contract_total_fees ,0) , nvl(contract_deposit_fees,0) 
into v_contract_start_date , v_contract_end_date , v_payments_installments_no 
,v_contract_payment_type , v_contract_total_fees , v_contract_deposit_fees
from contracts
where contract_id = v_contract_id ;
v_installments_amount := (v_contract_total_fees - v_contract_deposit_fees ) / v_payments_installments_no ;
v_contract_start_datee := v_contract_start_date; 
for i in 1 ..  v_payments_installments_no loop
   if v_contract_payment_type = 'ANNUAL' then 
    insert into installements_paid (contract_id , installements_date, installements_amount , paid) 
    values (v_contract_id , add_months(v_contract_start_datee , 0) , v_installments_amount , 0) ;
    v_contract_start_datee := add_months(v_contract_start_datee , 12);
   elsif v_contract_payment_type = 'QUARTER' then 
    insert into installements_paid (contract_id , installements_date, installements_amount , paid) 
    values (v_contract_id , add_months(v_contract_start_datee , 0) , v_installments_amount , 0) ;
    v_contract_start_datee := add_months(v_contract_start_datee , 3);
   elsif v_contract_payment_type = 'HALF_ANNUAL' then 
    insert into installements_paid ( contract_id , installements_date , installements_amount , paid) 
    values ( v_contract_id , add_months(v_contract_start_datee , 0) , v_installments_amount , 0) ;
    v_contract_start_datee := add_months(v_contract_start_datee , 6);
   elsif v_contract_payment_type = 'MONTHLY' then 
     insert into installements_paid ( contract_id , installements_date , installements_amount , paid) 
     values (  v_contract_id , add_months(v_contract_start_datee , 0) , v_installments_amount , 0) ;
     v_contract_start_datee := add_months(v_contract_start_datee , 1);
end if ;
end loop ;
end ; 
show errors