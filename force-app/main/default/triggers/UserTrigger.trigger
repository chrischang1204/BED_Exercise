trigger UserTrigger on User (after update) {
    
    if (Trigger.new.size()==1) 
    { 
        User u = Trigger.new[0]; 
        
        if (u.ContactId!=null) { 
            UserTriggerHandler.updateContact(u.ContactId); 
        } 
    } 
}