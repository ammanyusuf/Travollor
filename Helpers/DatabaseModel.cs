using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Configuration;
using System.Data;
using System.Web;

using MySql.Data.MySqlClient;
using MySql.Data.Types;

namespace ProjectTemp.Helpers
{
    public class DatabaseModel
    {

        #region Query Methods

        public string GetConnectionString()
        {
            return "server=localhost;port=3306;database=travellors;user=admin1;password=password;check parameters=false";

        }

        /**
         * This method will return the connection string in the GetConnectionString method
         * into a MySqlConnection type string
         */
        public MySqlConnection GetMySQLConnection()
        {
            return new MySqlConnection(GetConnectionString());
        }

        /// <summary>
        /// This method is responisble to to execute a query in your RDBMS and return for you an output value. 
        /// For instance, in some cases when you insert a new records you need to return the id of that record to do other actions
        /// </summary>
        /// <returns></returns>

        public int Execute_Non_Query_Store_Procedure(string procedureName, MySqlParameter[] parameters, string returnValue)
        {
            if (GetMySQLConnection() == null)
                return -2;

            int successfulQuery = -2;
            MySqlCommand mySqlCommand = new MySqlCommand(procedureName, GetMySQLConnection());
            mySqlCommand.CommandType = CommandType.StoredProcedure;

            try
            {
                mySqlCommand.Parameters.AddRange(parameters);
                mySqlCommand.Connection.Open();
                successfulQuery = mySqlCommand.ExecuteNonQuery();
                successfulQuery = (int)mySqlCommand.Parameters["@" + returnValue].Value;

            }
            catch (Exception ex)
            {
                string s = ex.Message;
            }

            if (mySqlCommand.Connection != null && mySqlCommand.Connection.State == ConnectionState.Open)
                mySqlCommand.Connection.Close();

            return successfulQuery;
        }


        /// <summary>
        /// This method is responisble to to execute a query in your RDBMS and return for you if it was successult executed. Minay used for insert,update, and delete
        /// </summary>
        /// <returns></returns>
        public int Execute_Non_Query_Store_Procedure(string procedureName, MySqlParameter[] parameters)
        {
            if (GetMySQLConnection() == null)
                return -1;

            int successfulQuery = 1;
            MySqlCommand mySqlCommand = new MySqlCommand(procedureName, GetMySQLConnection());
            mySqlCommand.CommandType = CommandType.StoredProcedure;

            
            try
            {
                mySqlCommand.Parameters.AddRange(parameters);
                mySqlCommand.Connection.Open();
                successfulQuery = mySqlCommand.ExecuteNonQuery();
                // successfulQuery =1

            }
            catch (Exception ex)
            {
                string s = ex.Message;
                successfulQuery = -2;
            }

            if (mySqlCommand.Connection != null && mySqlCommand.Connection.State == ConnectionState.Open)
                mySqlCommand.Connection.Close();

            return successfulQuery;
        }


        /// <summary>
        /// This method is responisble to to execute to rertieve data from your RDBSM by executing a stored procedure. Mainly used when using one select statment
        /// </summary>
        /// <returns></returns>
        public DataTable Execute_Data_Query_Store_Procedure(string procedureName, MySqlParameter[] parameters)
        {
            if (GetMySQLConnection() == null)
                return null;

            MySqlDataReader reader = null;

            DataTable dataTable = new DataTable();
            /*
            MySqlCommand command = new MySqlCommand("GetPeople", connection);
            command.CommandType = CommandType.StoredProcedure;
            MySqlDataReader reader = command.ExecuteReader();
            
            MySqlCommand myCommand = new MySqlCommand(procedureName);
            myCommand.Connection = connection;
            myCommand.CommandType = CommandType.StoredProcedure;

            reader = myCommand.ExecuteReader();

            dataTable.Load(reader);
            */
            MySqlDataAdapter adapter = new MySqlDataAdapter(procedureName, GetMySQLConnection());
            adapter.SelectCommand.CommandType = CommandType.StoredProcedure;
            
            // Open the connection
            adapter.SelectCommand.Connection.Open();

            try
            {
                adapter.SelectCommand.Parameters.AddRange(parameters);
                adapter.Fill(dataTable);
            }
            catch (Exception er)
            {
                dataTable = null;
            }

            // Make sure to close the connection
            if (adapter.SelectCommand.Connection != null && adapter.SelectCommand.Connection.State == ConnectionState.Open)
            {
                adapter.SelectCommand.Connection.Close();
            }
            
            return dataTable;
        }

        /// <summary>
        /// This method is responisble to to execute to rertieve data from your RDBSM by executing a stored procedure. Mainly used when more than one table is being returned.
        /// </summary>
        /// <returns></returns>
        /// 

        public DataSet Execute_Data_Dataset_Store_Procedure(string procedureName, MySqlParameter[] parameters)
        {
            if (GetMySQLConnection() == null)
                return null;

            DataSet dataset = new DataSet();
            MySqlDataAdapter mySqlDataAdapter = new MySqlDataAdapter(procedureName, GetMySQLConnection());
            mySqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            try
            {
                mySqlDataAdapter.SelectCommand.Parameters.AddRange(parameters);
                mySqlDataAdapter.SelectCommand.Connection.Open();
                mySqlDataAdapter.Fill(dataset);
            }
            catch (Exception er)
            {
                string ee = er.ToString();
                dataset = null;
            }

            if (mySqlDataAdapter.SelectCommand.Connection != null && mySqlDataAdapter.SelectCommand.Connection.State == ConnectionState.Open)
                mySqlDataAdapter.SelectCommand.Connection.Close();

            return dataset;
        }

        /// <summary>
        /// This method check if the connection string is valid or not
        /// </summary>
        /// <returns></returns>

        public bool CheckDatabaseConnectionString(string ConnectionString)
        {
            try
            {

                MySqlConnection con = new MySqlConnection(ConnectionString);
                con.Open();
                con.Close();
                return true;
            }
            catch
            {
                return false;
            }


        }
        #endregion

        #region Examples
        public int updateEmployee(int empId, string empName, DateTime embBDate, string empAddress)
        {


            MySqlParameter[] Parameters = new MySqlParameter[4]; // Specifc number of parametrs for this tored procedure. 
            Parameters[0] = new MySqlParameter("@empName", empName);//Make sure parameters name matches thenames given in your stored procedure
            Parameters[1] = new MySqlParameter("@embBDate", embBDate);
            Parameters[2] = new MySqlParameter("@empAddress", empAddress);
            Parameters[3] = new MySqlParameter("@empId", empId);

            return Execute_Non_Query_Store_Procedure("SP_UpdateEmpInfo", Parameters);//Make sure procedure name matches the name given in your RDBMS
        }


        public int addUser(string email_id, string first_name, string last_name, int admin_id)
        {
            MySqlParameter[] Parameters = new MySqlParameter[5];
            Parameters[0] = new MySqlParameter("@email_id", email_id);
            Parameters[1] = new MySqlParameter("@first_name", first_name);
            Parameters[2] = new MySqlParameter("@last_name", last_name);
            Parameters[3] = new MySqlParameter("@admin_id", admin_id);

            Parameters[4] = new MySqlParameter("@userID", MySqlDbType.Int32);
            Parameters[4].Direction = ParameterDirection.Output;


            return Execute_Non_Query_Store_Procedure("addUser", Parameters, "userID");
        }
        public DataTable getInfoAndFactsByCityID(int cityNumber)
        {
            MySqlParameter[] Parameters = new MySqlParameter[1];
            Parameters[0] = new MySqlParameter("@cityNumber", cityNumber);

            return Execute_Data_Query_Store_Procedure("infoAndFactsFromCity", Parameters);
        }

        public DataTable getAttractionWithMostRecommendationsByCityID(int cityNumber)
        {
            MySqlParameter[] Parameters = new MySqlParameter[1];
            Parameters[0] = new MySqlParameter("@cityNumber", cityNumber);

            return Execute_Data_Query_Store_Procedure("attractionMostRecommendationsByCityID", Parameters);
        }


        public DataTable getTourGuidesByTouristCityID(int touristCityID)
        {
            MySqlParameter[] Parameters = new MySqlParameter[1];
            Parameters[0] = new MySqlParameter("@touristCityID", touristCityID);

            return Execute_Data_Query_Store_Procedure("tourGuidesByTouristCityID", Parameters);
        }

        public DataTable GetTouristNationality()
        {
            MySqlParameter[] Parameters = new MySqlParameter[0];

            return Execute_Data_Query_Store_Procedure("touristNationality", Parameters);

        }

        public int updateSalaries()
        {
            MySqlParameter[] Parameters = new MySqlParameter[0];


            return Execute_Non_Query_Store_Procedure("UpdateSalary", Parameters);
        }
        
        public DataTable getRecommendations_retrieve(string attraction_name)
        {
            MySqlParameter[] Parameters = new MySqlParameter[1];
            Parameters[0] = new MySqlParameter("@attraction_name", attraction_name);
            return Execute_Data_Query_Store_Procedure("recommendations_retrieve", Parameters);

        }

        public DataTable getLocal_business_info(int city_id)
        {
            MySqlParameter[] Parameters = new MySqlParameter[1];
            Parameters[0] = new MySqlParameter("@city_id", city_id);
            return Execute_Data_Query_Store_Procedure("local_business_info", Parameters);

        }
        
        public int PostAdd_Recommendation(string title, DateTime creation_date, DateTime posting_time , 
        int post_rating, string tips, string description, string personal_info,
        int attraction_id, int city_id, int local_uid, int tour_guide_id, int tourist_id, string title_name )
        {
            MySqlParameter[] Parameters = new MySqlParameter[13];
            Parameters[0] = new MySqlParameter("@rtitle", title);
            Parameters[1] = new MySqlParameter("@rcreation_date", creation_date);
            Parameters[2] = new MySqlParameter("@rposting_time", posting_time);
            Parameters[3] = new MySqlParameter("@rpost_rating",post_rating);
            Parameters[4] = new MySqlParameter("@rtips",tips);
            Parameters[5] = new MySqlParameter("@rdescription",description);
            Parameters[6] = new MySqlParameter("@rpersonal_info",personal_info);
            Parameters[7] = new MySqlParameter("@rattraction_id",attraction_id);
            Parameters[8] = new MySqlParameter("@rcity_id",city_id);
            Parameters[9] = new MySqlParameter("@rlocal_uid",local_uid);
            Parameters[10] = new MySqlParameter("@rtour_guide_id",tour_guide_id);
            Parameters[11] = new MySqlParameter("@rtourist_id",tourist_id);
            Parameters[12] = new MySqlParameter("@title_name", MySqlDbType.VarChar);
            Parameters[12].Direction = ParameterDirection.Output;
            return Execute_Non_Query_Store_Procedure("add_Recommendation", Parameters, "@title_name");


        }


        #endregion
    }
}
