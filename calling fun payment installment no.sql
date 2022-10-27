declare
         v_installement_no number(2);
         cursor contracts_cursor is
         select* from contracts;
begin
for v_contracts_record in contracts_cursor loop
           v_installement_no := payemnt_installments_no_fn(v_contracts_record.CONTRACT_ID);
           update contracts
           set payments_installments_no=v_installement_no
           where contract_id=v_contracts_record.CONTRACT_ID;
end loop;        
end;