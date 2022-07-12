public class AccountHandler {
    public static void insertAccount(Integer newAccounts) {
        List<Account> addAccounts = new List<Account>();
        Integer i=1;
        while(i<=newAccounts){
            Account acc=new Account();
            acc.Name='Acme Inc '+i;
            acc.AccountNumber='A000'+i;
            addAccounts.add(acc);
            i++;
        }
        insert addAccounts;
    }
}
