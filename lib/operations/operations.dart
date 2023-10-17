class OperationServices {
  static String get login => r"""
           mutation userLogin($username:String,$password:String){
              login(userName:$username,password:$password){
                  success
                  message
                  accessToken
                  refreshToken
                  loginAs
                  }
                  
                  }
                  """;
  static String get registerUser => r"""
           mutation registerUser($username:String!,$password:String!,$deviceToken:String!){
           insertUser(input:{
        deviceToken:$deviceToken,
        password:$password,
        username:$username,
                }){
           success
           message
                 }
                  
                  }
                  """;
}
