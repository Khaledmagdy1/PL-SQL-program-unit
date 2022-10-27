DECLARE
            CURSOR insts_curs IS
            select contract_id 
            FROM contracts;

BEGIN
        
        FOR insts_record IN insts_curs LOOP
        insert_data( insts_record.contract_id);
        END LOOP;
END;