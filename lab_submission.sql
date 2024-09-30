-- CREATE EVN_average_customer_waiting_time_every_1_hour

SET GLOBAL event_scheduler = ON;


DELIMITER $$  

CREATE EVENT `EVN_average_customer_waiting_time_every_1_hour`  
ON 
SCHEDULE EVERY 1 HOUR  
DO  
BEGIN  
    INSERT INTO customer_service_kpi (customer_service_KPI_average_waiting_time_minutes)  
    SELECT AVG(waiting_time_minutes)  
    FROM customer_service_ticket  
    WHERE raised_timestamp >= NOW() - INTERVAL 1 HOUR;  
END$$  

DELIMITER ;


SHOW EVENTS FROM `classicmodels`;