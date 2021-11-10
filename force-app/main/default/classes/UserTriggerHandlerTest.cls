@isTest
private class UserTriggerHandlerTest {
    
    @TestSetup
    static void testSetup(){
        List<Account> accList = new List<Account>();
        for(Integer i = 0 ; i < 100 ; i++){
            Account temp = new Account(Name = 'Test Acc ' + i);
            accList.add(temp);
        }
        insert accList;
        
        List<Contact> contactList = new List<Contact>();
        for(Integer i = 0 ; i < accList.size() ; i++){
            Contact temp = new Contact(LastName = 'Test Contact ' + i, AccountId = accList[i].Id);
            contactList.add(temp);
        }
        insert contactList;
        
    }
    
    static testMethod void testUpdateOnContactAddress() {
        Account acct = [SELECT Id FROM Account WHERE Name='Test Acc 0' LIMIT 1];
        Contact con =  [SELECT Id, MailingCity FROM Contact WHERE Name='Test Contact 0' LIMIT 1];
        Profile p = [Select Id, UserType, name from Profile WHERE UserType = 'CspLitePortal' LIMIT 1];
      
        
        User u = new User(LastName = 'Test User ', ContactId = con.Id, Username='username1341291230@test.com', Email='test@test.com', Alias='alias', TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='ISO-8859-1', ProfileId=p.Id, LanguageLocaleKey='en_US',   City='abc');
        Database.insert(u);
        
        
        Test.startTest();
        //Update user
        
        System.runAs(new User(Id = UserInfo.getUserId())){
            u.Street='test';            
            u.City='test';
            u.PostalCode='11334';
            u.State='test';
            u.Country='test';
            update u;
        }
        Test.stopTest();
                
        // Test that the trigger correctly updated the mailing city
        System.assertEquals('test', u.City);
    }
}