codeunit 50017 "IT4G-SQL Management"
{
    trigger OnRun()
    begin
    end;

    procedure GetSQLDataAsXML(): Text
    var
        SQLDataSet: DotNet SQLDataSet;
        SQLDataAdapter: DotNet SQLDataAdapter;
        SQLConnection: Text;
        SQLQuery: Text;
        SQLResultAsXML: Text;
    begin
        //connection using authentication with username & password
        SQLConnection := 'Server=.\sql2019;Database=BC171_LS_IT4G;User Id=myUsername;Password=myPassword;';

        // connection using windows authentication 
        SQLConnection := 'Server=.\sql2019;Database=BC171_LS_IT4G_HO;Trusted_Connection=True;';

        // sql query 
        SQLQuery := 'SELECT * FROM[IT4G_V_CRONUS - LS Central$IT4G-LS Document] LSDoc (nolock)';

        SQLDataAdapter := SQLDataAdapter.SqlDataAdapter(SQLQuery, SQLConnection);
        SQLDataSet := SQLDataSet.DataSet();
        SQLDataAdapter.Fill(SQLDataSet);
        SQLResultAsXML := 'c:\kouvas\sample.xml';
        SQLDataSet.WriteXml(SQLResultAsXML);

        /*
                SQLDataAdapter.Dispose();
                clear(SQLDataAdapter);
                clear(SQLDataSet);
        */
        exit(SQLResultAsXML);
    end;
}

