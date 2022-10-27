CREATE OR REPLACE function payemnt_installments_no_fn(v_contract_id number)
return number
is
v_contract_payment_type varchar2(100); result number(2);
V_CONTRACT_ENDDATE DATE;  V_CONTRACT_STARTDATE DATE;
begin
select contract_payment_type,CONTRACT_START_DATE,CONTRACT_END_DATE 
into v_contract_payment_type,V_CONTRACT_ENDDATE,V_CONTRACT_STARTDATE
from contracts
where contract_id=v_contract_id;
if v_contract_payment_type='ANNUAL'
        THEN result:=months_between(V_CONTRACT_STARTDATE,V_CONTRACT_ENDDATE)/12;
ELSIF v_contract_payment_type='QUARTER'
        THEN result:=months_between(V_CONTRACT_STARTDATE,V_CONTRACT_ENDDATE)/3;
elsif v_contract_payment_type='MONTHLY'
        THEN result:=months_between(V_CONTRACT_STARTDATE,V_CONTRACT_ENDDATE);
elsif v_contract_payment_type='HALF_ANNUAL'
        THEN result:=months_between(V_CONTRACT_STARTDATE,V_CONTRACT_ENDDATE)/6;
end if;
return result;
end;