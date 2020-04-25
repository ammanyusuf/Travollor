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
    /**
     * This code document references and uses Professor Abdullah Sarhan's provided templated code
     * called ProjectTemp.  The StoredProcedures region built upon the provided example code.  However,
     * the Query Methods region uses the referenced ProjectTemp code to set up the database connection
     * and the stored procedure, query connections.
     */
    public class DatabaseModel
    {

        #region Query Methods

        /**
         * Description: This method will return the connection string that is used to connect to the database.
         */
        public string GetConnectionString()
        {
            return "server=localhost;port=3306;database=travellors;user=admin1;password=password;check parameters=false";

        }

        /**
         * Description: This method will return the connection string in the GetConnectionString method
         *              as a MySqlConnection type string.
         */
        public MySqlConnection GetMySQLConnection()
        {
            return new MySqlConnection(GetConnectionString());
        }

        /** 
         * Description: This method is responisble to to execute a query in the MySQL DBMS and return for an output value.
         *  
         * Returns: this method returns the output value of the stored procedure if successfull.  Will retunr -2 if the query
         *          was unssuccessful
         */ 

        public int Execute_Non_Query_Store_Procedure(string procedureName, MySqlParameter[] parameters, string returnValue)
        {
            // Check if the connection is null
            if (GetMySQLConnection() == null)
            {
                return -2;
            }

            int successfulQuery = -2;

            // Create a new MySqlCommand object that will communicate with the MySQL database
            MySqlCommand mySqlCommand = new MySqlCommand(procedureName, GetMySQLConnection());

            // Set the command type to a stored procedure
            mySqlCommand.CommandType = CommandType.StoredProcedure;

            try
            {
                // Add the parameters passed in to the parameters of the stored procedure
                mySqlCommand.Parameters.AddRange(parameters);

                // Open the connection to the database
                mySqlCommand.Connection.Open();

                // Execute the non query
                successfulQuery = mySqlCommand.ExecuteNonQuery();
                
                // Set successfulQuery equal to the specified return output value of the stored procedure
                successfulQuery = (int)mySqlCommand.Parameters["@" + returnValue].Value;

            }
            catch (Exception ex)
            {
                string s = ex.Message;

                // Set successful query equal to 2, this signifies that there was an exception when running the query
                successfulQuery = -2;
            }

            // Safely close the connection to the database
            if (mySqlCommand.Connection != null && mySqlCommand.Connection.State == ConnectionState.Open)
            {
                mySqlCommand.Connection.Close();
            }

            // Return the value of the successful query
            return successfulQuery;
        }

        /**
         * Description: This method is responisble to to execute a query in in the MySQL DBMS and return if 
         *              the query was successful or not. May be used for insert,update, and delete
         *
         * Return: this method returns whether the query was successful or not
         */
        public int Execute_Non_Query_Store_Procedure(string procedureName, MySqlParameter[] parameters)
        {
            // Check if the MySQL connection is null
            if (GetMySQLConnection() == null)
            {
                // If the MySQl conneciton is null, return -1, signifying an unsuccessful query
                return -1;
            }
                
            int successfulQuery = 1;

            // Create a new MySqlCommand object that will communicate with the MySQL database
            MySqlCommand mySqlCommand = new MySqlCommand(procedureName, GetMySQLConnection());

            // Set the command type to a stored procedure
            mySqlCommand.CommandType = CommandType.StoredProcedure;

            try
            {
                // Add the parameters passed in to the parameters of the stored procedure
                mySqlCommand.Parameters.AddRange(parameters);

                // Open the connection to the database
                mySqlCommand.Connection.Open();

                // Execute the non query and set whether the query was successful or not
                successfulQuery = mySqlCommand.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                string s = ex.Message;

                // Set successful query equal to 2, this signifies that there was an exception when running the query
                successfulQuery = -2;
            }

            // Safely close the connection to the database
            if (mySqlCommand.Connection != null && mySqlCommand.Connection.State == ConnectionState.Open)
            {
                mySqlCommand.Connection.Close();
            }

            // Return the value of the successful query
            return successfulQuery;
        }

        /**
         * Description: This method is responisble for retrieving data from the MySQL DBMS by 
         *              executing a stored procedure. This is primarily used for select statements
         * 
         * Return: this method returns a DataTable of the tuples retrieved in the select query
         */
        public DataTable Execute_Data_Query_Store_Procedure(string procedureName, MySqlParameter[] parameters)
        {
            // Check if the MySQL connection is null
            if (GetMySQLConnection() == null)
            {
                // If it is, return a null table
                return null;
            }
                
            // Initialize a MySQLDataReader to be null
            MySqlDataReader reader = null;

            // Initialize a new DataTable
            DataTable dataTable = new DataTable();

            // Create a new MySqlAdapter that has the procedure name and MySql connection specified
            MySqlDataAdapter adapter = new MySqlDataAdapter(procedureName, GetMySQLConnection());

            // Set the command type of the MySqlAdapter to a stored procedure
            adapter.SelectCommand.CommandType = CommandType.StoredProcedure;
            
            // Open the connection
            adapter.SelectCommand.Connection.Open();

            try
            {
                // Set the parameters of the stored procedures equal to the passed in parameter
                adapter.SelectCommand.Parameters.AddRange(parameters);

                // Execute the stored procedure specified and fill the dataTable initialized earlier
                // with the tuples retreived from the stored procedure
                adapter.Fill(dataTable);
            }
            catch (Exception er)
            {
                // If there was an exception executing the query, set the datable equal to null
                dataTable = null;
            }

            // Make sure to safely close the connection
            if (adapter.SelectCommand.Connection != null && adapter.SelectCommand.Connection.State == ConnectionState.Open)
            {
                adapter.SelectCommand.Connection.Close();
            }
            
            // Return the data table
            return dataTable;
        }

        /**
         * Description: This method checks if the connection string is a valid connection string or not
         * 
         * Returns: this method returns a boolean value; true if the connection is valid, false otherwise
        */
        public bool CheckDatabaseConnectionString(string ConnectionString)
        {
            try
            {
                // Create a new MySqlConnection with the specified connection string passed in as a parameter
                MySqlConnection con = new MySqlConnection(ConnectionString);

                // Open the connection
                con.Open();

                // Close the connection
                con.Close();

                return true;
            }
            catch
            {
                // If there was an exception, return false
                return false;
            }


        }
        #endregion

        #region StoredProcedures

        /**
         * Description: This method will add a new user to the database by calling the specified stored procedure
         * 
         * Parameters: 
         * string email_id : the email of the user
         * string first_name : the first name of the user
         * string last_name : the last name of the user
         * int admin_id : the id of the admin that added the user
         * 
         * Return: This method will return an int where it represents the user id of the newly inserted user
         */
        public int addUser(string email_id, string first_name, string last_name, int admin_id)
        {
            // Set up the IN parameters needed for the stored procedure
            MySqlParameter[] Parameters = new MySqlParameter[5];
            Parameters[0] = new MySqlParameter("@email_id", email_id);
            Parameters[1] = new MySqlParameter("@first_name", first_name);
            Parameters[2] = new MySqlParameter("@last_name", last_name);
            Parameters[3] = new MySqlParameter("@admin_id", admin_id);

            // Set the OUT parameter needed for the stored procedure
            Parameters[4] = new MySqlParameter("@userID", MySqlDbType.Int32);
            Parameters[4].Direction = ParameterDirection.Output;

            // Execute the non query stored procedure
            return Execute_Non_Query_Store_Procedure("addUser", Parameters, "userID");
        }

        /**
         * Description: This method will retrieve the info and facts of a specified city
         * 
         * Parameters:
         * int cityNumber : the city id of the city we wish to retrieve the info
         * 
         * Return: this method will return a DataTable of the retrieved tuples of the stored procedure
         */
        public DataTable getInfoAndFactsByCityID(int cityNumber)
        {
            // Set up the IN parameters needed for the stored procedure
            MySqlParameter[] Parameters = new MySqlParameter[1];
            Parameters[0] = new MySqlParameter("@cityNumber", cityNumber);

            // Execute the query stored procedure
            return Execute_Data_Query_Store_Procedure("infoAndFactsFromCity", Parameters);
        }

        /**
         * Description: This method will retrieve the attraction with the most number of recommendations
         *              with a specified city in mind
         * 
         * Parameters:
         * int cityNumber : the city id of the city we wish to retrieve the info for
         * 
         * Return: this method will return a DataTable of the retrieved tuples of the stored procedure
         */
        public DataTable getAttractionWithMostRecommendationsByCityID(int cityNumber)
        {
            // Set up the IN parameters needed for the stored procedure
            MySqlParameter[] Parameters = new MySqlParameter[1];
            Parameters[0] = new MySqlParameter("@cityNumber", cityNumber);

            // Execute the query stored procedure
            return Execute_Data_Query_Store_Procedure("attractionMostRecommendationsByCityID", Parameters);
        }

        /**
         * Description: This method will retrieve the tour guides by the specified tourist city
         * 
         * Parameters:
         * int touristCityID : the city id of the city we wish to retrieve the info for
         * 
         * Return: this method will return a DataTable of the retrieved tuples of the stored procedure
         */
        public DataTable getTourGuidesByTouristCityID(int touristCityID)
        {
            // Set up the IN parameters needed for the stored procedure
            MySqlParameter[] Parameters = new MySqlParameter[1];
            Parameters[0] = new MySqlParameter("@touristCityID", touristCityID);

            // Execute the query stored procedure
            return Execute_Data_Query_Store_Procedure("tourGuidesByTouristCityID", Parameters);
        }

        /**
         * Description: This method will retrieve nationalities of the users in the system
         * 
         * Return: this method will return a DataTable of the retrieved tuples of the stored procedure
         */
        public DataTable GetTouristNationality()
        {
            // Set up the parameters needed for the stored procedure (in this case there are none)
            MySqlParameter[] Parameters = new MySqlParameter[0];

            // Execute the query stored procedure
            return Execute_Data_Query_Store_Procedure("touristNationality", Parameters);

        }

        /**
         * Description: This method will retrieve the recommendations of a specified attraction
         * 
         * Parameters:
         * int attraction_name : the attraction name we wish to find the recommendations of
         * 
         * Return: this method will return a DataTable of the retrieved tuples of the stored procedure
         */
        public DataTable getRecommendations_retrieve(string attraction_name)
        {
            // Set up the IN parameters needed for the stored procedure
            MySqlParameter[] Parameters = new MySqlParameter[1];
            Parameters[0] = new MySqlParameter("@attraction_name", attraction_name);

            // Execute the query stored procedure
            return Execute_Data_Query_Store_Procedure("recommendations_retrieve", Parameters);

        }

        /**
         * Description: This method will retrieve the local business information for a given city
         * 
         * Parameters:
         * int city_id : the city id of the city we wish to retrieve the local business information from
         * 
         * Return: this method will return a DataTable of the retrieved tuples of the stored procedure
         */
        public DataTable getLocal_business_info(int city_id)
        {
            // Set up the IN parameters needed for the stored procedure
            MySqlParameter[] Parameters = new MySqlParameter[1];
            Parameters[0] = new MySqlParameter("@city_id", city_id);

            // Execute the query stored procedure
            return Execute_Data_Query_Store_Procedure("local_business_info", Parameters);

        }

        /**
         * Description: This method will add a new recommendaiton to the database by calling the specified stored procedure
         * 
         * Parameters: 
         * string title : the title of the recommendation
         * DateTime creation_date : the creation date of the recommendation
         * DateTime posting_time : the time the recommendation was posted
         * int post_rating : the rating of the post/recommendation
         * string tips : the tips that are part of the recommendation
         * string description : the descritption of the recommendation
         * string personal_info : the personal information of the user
         * int attraction_id : the attraction id that the recommendation was written for
         * int city_id : the city id of the city the attraction is situated in
         * int local_uid : the locad user id of the local that wrote the recommendation
         * int tour_guide_id : the tour guide id of the tour guide the recommendaiton recommended
         * int tourist_id : the tourist id of the tourist that read the recommendation
         * 
         * Return: This method will return the title of the recommendation just added
         */
        public string PostAdd_Recommendation(string title, DateTime creation_date, DateTime posting_time , 
                                             int post_rating, string tips, string description, string personal_info,
                                             int attraction_id, int city_id, int local_uid, int tour_guide_id, int tourist_id)
        {
            // Set up the IN parameters needed for the stored procedure
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

            // Set the OUT parameter needed for the stored procedure
            Parameters[12] = new MySqlParameter("@title_name", MySqlDbType.VarChar);
            Parameters[12].Direction = ParameterDirection.Output;

            // Execute the query stored procedure
            Execute_Non_Query_Store_Procedure("add_Recommendation", Parameters, Parameters[12].ToString());
            string returnValue = title;

            // Return the title
            return returnValue;
        }

        /**
         * Description: This method will update the local's rating by adding the passed in rating to the already
         *              existing rating
         * 
         * Parameters: 
         * int uid : the id of the user that getting their rating updated
         * int updated_rating : the rating that we are adding to the user's already existing rating
         * 
         * Return: This method will return an int where it represents the id of the user that had their rating updated
         */
        public int updateLocalRatings(int uid, int updated_rating)
        {
            // Set up the IN parameters needed for the stored procedure
            MySqlParameter[] parameters = new MySqlParameter[3];
            parameters[0] = new MySqlParameter("@uid", uid);
            parameters[1] = new MySqlParameter("@updated_rating", updated_rating);

            // Set the OUT parameter needed for the stored procedure
            parameters[2] = new MySqlParameter("@new_rating", MySqlDbType.Int32);
            parameters[2].Direction = ParameterDirection.Output;

            // Execute the query stored procedure
            return Execute_Non_Query_Store_Procedure("updateLocalRatings", parameters, parameters[2].ToString());

        }

        /**
         * Description: This method will add a new local into the system based on super local input
         * 
         * Parameters: 
         * int super_local_uid : the id of the super local that is adding the local
         * int local_uid : the user id of the local that is being added to the local table
         * int city_id : the city id of the city that the local resides in
         * bool super_local_flag : the true or false value we set to the local
         * 
         * Return: This method will return an int where it represents the id of the local that was just inserted 
         *         into the local table
         */
        public int addLocal(int super_local_uid, int local_uid, int city_id, bool super_local_flag)
        {
            // Set up the IN parameters needed for the stored procedure
            MySqlParameter[] parameters = new MySqlParameter[5];
            parameters[0] = new MySqlParameter("@super_local_user_id", super_local_uid);
            parameters[1] = new MySqlParameter("@local_user_id", local_uid);
            parameters[2] = new MySqlParameter("@city_id", city_id);
            parameters[3] = new MySqlParameter("@super_local_flag_input", super_local_flag);

            // Set the OUT parameter needed for the stored procedure
            parameters[4] = new MySqlParameter("@inserted_user_id", MySqlDbType.Int32);
            parameters[4].Direction = ParameterDirection.Output;

            // Execute the query stored procedure
            return Execute_Non_Query_Store_Procedure("addLocal", parameters, parameters[4].ToString());
        }

        /**
         * Description: This method will verify (add) a new local business into the system based on super local input
         * 
         * Parameters: 
         * int super_local_uid : the id of the super local that is adding the local business
         * int business_license_number : the business liscnece number of the business that is being verified/added
         * string name : the name of the business the super local is adding
         * string address : the address of the business that is being added
         * int city_id : the city id of the city that the business is situated in
         * 
         * Return: This method will return an int where it represents the business liscence number of the business
         *         that was just added
         */
        public int verifyLocalBusiness(int super_local_uid, int business_license_number, string name, string address, int city_id)
        {
            // Set up the IN parameters needed for the stored procedure
            MySqlParameter[] parameters = new MySqlParameter[6];
            parameters[0] = new MySqlParameter("@super_local_UID_1", super_local_uid);
            parameters[1] = new MySqlParameter("@business_license_number1", business_license_number);
            parameters[2] = new MySqlParameter("@name1", name);
            parameters[3] = new MySqlParameter("@address1", address);
            parameters[4] = new MySqlParameter("@city_id1", city_id);

            // Set the OUT parameter needed for the stored procedure
            parameters[5] = new MySqlParameter("@out_bln", MySqlDbType.Int32);
            parameters[5].Direction = ParameterDirection.Output;

            // Execute the query stored procedure
            return Execute_Non_Query_Store_Procedure("verifyLocalBusiness", parameters, parameters[5].ToString());
        }

        #endregion
    }
}
