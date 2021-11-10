public class UserTriggerHandler {
    
     
    public static void updateContact(Id contactId){
        Contact c = new Contact();
      
        List<Contact> contacts = new List<Contact>();
       
        
        for(User u : [SELECT Name,Id,ContactId, Address From User Where ContactId =: contactId]) {
            c.Id = u.ContactId;
            c.MailingStreet     = u.Address.getStreet();
            c.MailingCity       = u.Address.getCity();
            c.MailingState      = u.Address.getState();
            c.MailingPostalCode = u.Address.getPostalCode();
            c.MailingCountry    = u.Address.getCountry();
            contacts.add(c);
        }
        
        update contacts;
        System.debug('contacts'+contacts);
    }
}