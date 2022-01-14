dotnet
{
    assembly("System.Data")
    {
        Version = '4.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';

        type("System.Data.SqlClient.SqlConnection"; "SqlConnection") { }
        type("System.Data.SqlClient.SqlCommand"; "SqlCommand") { }
        type("System.Data.Odbc.OdbcConnection"; "OdbcConnection") { }
        type("System.Data.Odbc.OdbcCommand"; "OdbcCommand") { }
        type("System.Data.SqlClient.SqlDataReader"; "SqlDataReader") { }
        type("System.Data.DbType"; "DbType") { }
        type("System.Data.SqlClient.SqlParameter"; "SqlParameter") { }
        type("System.Data.Odbc.OdbcDataReader"; "OdbcDataReader") { }
        type("System.Data.StatementCompletedEventArgs"; "StatementCompletedEventArgs") { }
        type("System.Data.SqlClient.SqlInfoMessageEventArgs"; "SqlInfoMessageEventArgs") { }
        type("System.Data.StateChangeEventArgs"; "StateChangeEventArgs") { }
        type("System.Data.Odbc.OdbcInfoMessageEventArgs"; "OdbcInfoMessageEventArgs") { }
        type(System.Data.DataSet; SQLDataSet) { }
        type(System.Data.SqlClient.SqlDataAdapter; SQLDataAdapter) { }
    }

    assembly("mscorlib")
    {
        Version = '4.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';

        type("System.Enum"; "Enum") { }
        type("System.Convert"; "Convert") { }
        type("System.EventArgs"; "EventArgs") { }
    }

}