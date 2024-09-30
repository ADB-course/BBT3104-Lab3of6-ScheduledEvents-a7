-- CREATE EVN_average_customer_waiting_time_every_1_hour

SET GLOBAL event_scheduler = ON;


DELIMITER $$  

CREATE EVENT `EVN_average_customer_waiting_time_every_1_hour`  
ON 
SCHEDULE EVERY 1 HOUR   
STARTS CURRENT_TIMESTAMP + INTERVAL 3 MINUTE  
ON 
COMPLETION PRESERVE  
COMMENT 'This event computes the average waiting time of customers who raised tickets in the past hour.'  
DO  
BEGIN  
    INSERT INTO `customer_service_kpi` (`customer_service_KPI_average_waiting_time_minutes`)   
    SELECT AVG(TIMESTAMPDIFF(MINUTE, `customer_service_ticket_raise_time`, CURRENT_TIMESTAMP))  
    FROM `customer_service_ticket`  
    WHERE `customer_service_ticket_raise_time` >= NOW() - INTERVAL 1 HOUR;  
END$$  

DELIMITER ;


SHOW EVENTS FROM `classicmodels`;