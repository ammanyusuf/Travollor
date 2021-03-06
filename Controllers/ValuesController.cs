﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json.Linq;
using ProjectTemp.Helpers;
using System.Data;

using MySql.Data.MySqlClient;

namespace ProjectTemp.Controllers
{
    /**
     * This code document references and uses Professor Abdullah Sarhan's provided templated code
     * called ProjectTemp.  The GET, PUT, and POST enpoint request followed the template code. More speicifcally,
     * the default 'GetValues' mapping was kept but appropriated for our purposes.  Now, 'GetValues' will return the 
     * current naitonalities in the database
     */
    [Route("api/ValuesController")]
    [ApiController]
    public class ValuesController : ControllerBase
    {

        /**
         * Description: This method allowed us test the connection string to our database
         */
        [HttpGet]
        [Route("TestConnection")]
        public ActionResult<bool> TestConnection()
        {
            // Create a new DatabaseModel object
            DatabaseModel databaseModel = new DatabaseModel();
            return Ok(databaseModel.CheckDatabaseConnectionString("server = localhost; port = 3306; database = travellors; user = admin1; password = password"));
        }

        /**
         * Description: This method will execute a Http GET request and retrieve the tourguides by 
         *              the tourist city id
         */
        // GET api/ValuesController/getTourGuidesByTouristCityID?touristCityID=2
        [HttpGet]
        [Route("getTourGuidesByTouristCityID")]
        public ActionResult<IEnumerable<string>> getTourGuidesByTouristCityID(int touristCityID)
        {
            // Create a new DatabaseModel object
            DatabaseModel dbm = new DatabaseModel();

            // Execute the stored procedure and fill datatable
            DataTable dt = dbm.getTourGuidesByTouristCityID(touristCityID);

            return Ok(dt);
        }

        /**
         * Description: This method will execute a Http GET request and retrieve the info and
         *              facts of a given city
         */
        // GET api/ValuesController/getInfoAndFactsByCityID?cityID=2
        [HttpGet]
        [Route("getInfoAndFactsByCityID")]
        public ActionResult<IEnumerable<string>> getInfoAndFactsByCityID(int cityID)
        {
            // Create a new DatabaseModel object
            DatabaseModel dbm = new DatabaseModel();

            // Execute the stored procedure and fill datatable
            DataTable dt = dbm.getInfoAndFactsByCityID(cityID);

            return Ok(dt);
        }

        /**
         * Description: This method will execute a Http GET request and retrieve the attraction
         *              with the most recommendations for a given city
         */
        // GET api/ValuesController/getAttractionWithMostRecommendationsByCityID?cityID=2
        [HttpGet]
        [Route("getAttractionWithMostRecommendationsByCityID")]
        public ActionResult<IEnumerable<string>> getAttractionWithMostRecommendationsByCityID(int cityID)
        {
            // Create a new DatabaseModel object
            DatabaseModel dbm = new DatabaseModel();

            // Execute the stored procedure and fill datatable
            DataTable dt = dbm.getAttractionWithMostRecommendationsByCityID(cityID);

            return Ok(dt);
        }

        /**
         * Description: This method will execute a Http GET request and retrieve the nationalities
         *              in the current database
         */
        // GET api/ValuesController/GetValues
        [HttpGet]
        [Route("GetValues")]
        public ActionResult<IEnumerable<string>> GetValues()
        {
            List<string> touristList = new List<string>();

            // Create a new DatabaseModel object
            DatabaseModel dbm = new DatabaseModel();
            DataTable dt = dbm.GetTouristNationality();
            foreach (DataRow dr in dt.Rows)
            {
                string nationality = dr[0].ToString();
                touristList.Add(dr[0].ToString());
            }
            return Ok(touristList);
        }

        /**
         * Description: This method will execute a Http POST request and add a new user
         *              from the given JObject input
         */
        // POST api/ValuesController/addUser
        [HttpPost]
        [Route("addUser")]
        public ActionResult<IEnumerable<string>> addUser([FromBody] JObject user)
        {
            // Retrieve the attributes from the json object to be passed through the function
            string userEmail = user["userEmail"].ToString();
            string userName = user["userName"].ToString();
            string userLastName = user["userLastName"].ToString();
            int userAdminID = (int)user["userAdminID"];

            // Create a new DatabaseModel object
            DatabaseModel dbm = new DatabaseModel();

            // Execute the stored procedure and set the response from the stored procedure equal to res
            int res = dbm.addUser(userEmail, userName, userLastName, userAdminID);

            return Ok(res);
        }

        /**
         * Description: This method will execute a Http GET request and retrieve the recommendations of a given
         *              attraction
         */
        // GET api/ValuesController/getRecommendations_retrieve?attraction_name=Miami Beach
        // If doesn't work in postman enter 
        // api/ValuesController/getRecommendations_retrieve?attraction_name=Miami%20Beach
        [HttpGet]
        [Route("getRecommendations_retrieve")]
        public ActionResult<IEnumerable<string>> getRecommendations_retrieve(string attraction_name)
        {
            // Create a new DatabaseModel object
            DatabaseModel dbm = new DatabaseModel();

            // Execute the stored procedure and fill datatable
            DataTable dt = dbm.getRecommendations_retrieve(attraction_name);
            return Ok(dt);
        }

        /**
         * Description: This method will execute a Http GET request and retrieve the information of the
         *              local businesses from a given city
         */
        // GET api/ValuesController/getLocal_business_info?city_id=2
        [HttpGet]
        [Route("getLocal_business_info")]
        public ActionResult<IEnumerable<string>>getLocal_business_info(int city_id)
        {
            // Create a new DatabaseModel object
            DatabaseModel dbm = new DatabaseModel();

            // Execute the stored procedure and fill datatable
            DataTable dt = dbm.getLocal_business_info(city_id);
             return Ok(dt);
        }

        /**
         * Description: This method will execute a Http POST request and add a new recommendation
         *              from the given JObject input
         */
         //POST api/ValuesController/PostAdd_Recommendation
         [HttpPost]
         [Route("PostAdd_Recommendation")]
         public ActionResult<IEnumerable<string>> PostAdd_Recommendation([FromBody] JObject rec)
         {
            // Retrieve the attributes from the json object to be passed through the function
            string title = rec["rtitle"].ToString();
            DateTime creation_date= (DateTime)rec["rcreation_date"];
            DateTime posting_time = (DateTime)rec["rposting_time"];
            string tips = rec["rtips"].ToString();
            string description = rec["rdescription"].ToString();
            int attraction_id = (int)rec["rattraction_id"];
            int city_id = (int)rec["rcity_id"];
            int local_uid= (int)rec["rlocal_uid"];

            // Create a new DatabaseModel object
            DatabaseModel dbm = new DatabaseModel();

            // Execute the stored procedure and set the response from the stored procedure equal to res
            string res = dbm.PostAdd_Recommendation(title,creation_date,posting_time,tips,description,
                                                    attraction_id,city_id,local_uid);
            return Ok(res.ToString());
        }

        /**
         * Description: This method will execute a Http PUT request and updated the rating of a given local
         */
        // PUT api/ValuesController/updateLocalRatings
        [HttpPut]
        [Route("updateLocalRatings")]
        public ActionResult<IEnumerable<string>> updateLocalRatings([FromBody] JObject rat)
        {
            // Retrieve the attributes from the json object to be passed through the function
            int uid = (int)rat["uid"];
            int updated_rating = (int)rat["updatedRating"];

            // Create a new DatabaseModel object
            DatabaseModel dbm = new DatabaseModel();

            // Execute the stored procedure and set the response from the stored procedure equal to response
            int response = dbm.updateLocalRatings(uid,updated_rating);
            
            return Ok(response.ToString());
        }

        /**
         * Description: This method will execute a Http POST request and add a new local
         *              from the given JObject input
         */
        // POST api/ValuesController/addLocal
        [HttpPost]
        [Route("addLocal")]
        public ActionResult<IEnumerable<string>> addLocal([FromBody] JObject add)
        {
            // Retrieve the attributes from the json object to be passed through the function
            int super_local_uid = (int)add["superLocalUid"];
            int local_user_id = (int)add["localUserId"];
            int city_id = (int)add["cityId"];
            bool super_local_flag = (bool)add["superLocalFlag"];

            // Create a new DatabaseModel object
            DatabaseModel dbm = new DatabaseModel();

            // Execute the stored procedure and set the response from the stored procedure equal to response
            int response = dbm.addLocal(super_local_uid, local_user_id, city_id, super_local_flag);
            
            return Ok(response.ToString());
        }

        /**
         * Description: This method will execute a Http POST request and add/verify a new local business
         *              from the given JObject input
         */
        // POST api/ValuesController/verifyLocalBusiness
        [HttpPost]
        [Route("verifyLocalBusiness")]
        public ActionResult<IEnumerable<string>> verifyLocalBusiness([FromBody] JObject verify)
        {
            // Retrieve the attributes from the json object to be passed through the function
            int super_local_uid = (int)verify["superLocalUid"];
            int business_license_number = (int)verify["businessLicenseNumber"];
            string name = verify["name"].ToString();
            string address = verify["address"].ToString();
            int city_id = (int)verify["cityId"];

            // Create a new DatabaseModel object
            DatabaseModel dbm = new DatabaseModel();

            // Execute the stored procedure and set the response from the stored procedure equal to response
            int response = dbm.verifyLocalBusiness(super_local_uid, business_license_number, name, address, city_id);
            
            return Ok(response.ToString());
        }

    }
}
