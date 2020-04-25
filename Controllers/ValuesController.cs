using System;
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
     * Description: This sets the route api/valuesController as an ApiController
     */
    [Route("api/ValuesController")]
    [ApiController]
    public class ValuesController : ControllerBase
    {

        /**
         * Description: This method allowed us test the connection string to our database
         * 
         * return: this method returns an OkObjectResult and produces a Status200OK response 
         */
        [HttpGet]
        [Route("TestConnection")]
        public ActionResult<bool> TestConnection()
        {
            DatabaseModel databaseModel = new DatabaseModel();
            return Ok(databaseModel.CheckDatabaseConnectionString("server = localhost; port = 3306; database = travellors; user = admin1; password = password"));
        }

        // GET api/ValuesController/getTourGuidesByTouristCityID?touristCityID=2
        [HttpGet]
        [Route("getTourGuidesByTouristCityID")]
        public ActionResult<IEnumerable<string>> getTourGuidesByTouristCityID(int touristCityID)
        {
            DatabaseModel dbm = new DatabaseModel();
            DataTable dt = dbm.getTourGuidesByTouristCityID(touristCityID);

            return Ok(dt);
        }

        // GET api/ValuesController/getInfoAndFactsByCityID?cityID=2
        [HttpGet]
        [Route("getInfoAndFactsByCityID")]
        public ActionResult<IEnumerable<string>> getInfoAndFactsByCityID(int cityID)
        {
            DatabaseModel dbm = new DatabaseModel();
            DataTable dt = dbm.getInfoAndFactsByCityID(cityID);

            return Ok(dt);
        }

        // GET api/ValuesController/getAttractionWithMostRecommendationsByCityID?cityID=2
        [HttpGet]
        [Route("getAttractionWithMostRecommendationsByCityID")]
        public ActionResult<IEnumerable<string>> getAttractionWithMostRecommendationsByCityID(int cityID)
        {
            DatabaseModel dbm = new DatabaseModel();
            DataTable dt = dbm.getAttractionWithMostRecommendationsByCityID(cityID);

            return Ok(dt);
        }

        // Isa method: getting tourist's nationality !

        // GET api/ValuesController/GetValues
        [HttpGet]
        [Route("GetValues")]
        public ActionResult<IEnumerable<string>> GetValues()
        {
            List<string> touristList = new List<string>();
            DatabaseModel dbm = new DatabaseModel();
            DataTable dt = dbm.GetTouristNationality();
            foreach (DataRow dr in dt.Rows)
            {
                string nationality = dr[1].ToString();
                touristList.Add(dr[1].ToString());
            }
            return Ok(touristList);
        }

        // GET api/ValuesController/GetValuesById?id=5
        [HttpGet]
        [Route("GetValuesById")]
        public ActionResult<IEnumerable<string>> GetValuesById(int id)
        {
            return new string[] { "value1" };
        }

        // POST api/ValuesController/addUser
        [HttpPost]
        [Route("addUser")]
        public ActionResult<IEnumerable<string>> addUser([FromBody] JObject user)
        {
            string userEmail = user["userEmail"].ToString();
            string userName = user["userName"].ToString();
            string userLastName = user["userLastName"].ToString();
            int userAdminID = (int)user["userAdminID"];

            DatabaseModel dbm = new DatabaseModel();
            int res = dbm.addUser(userEmail, userName, userLastName, userAdminID);

            return Ok(res);
        }
        
        // GET api/ValuesController/getRecommendations_retrieve?attraction_name=Miami Beach
        // If doesn't work in postman enter 
        // api/ValuesController/getRecommendations_retrieve?attraction_name=Miami%20Beach
        [HttpGet]
        [Route("getRecommendations_retrieve")]
        public ActionResult<IEnumerable<string>> getRecommendations_retrieve(string attraction_name)
        {
            DatabaseModel dbm = new DatabaseModel();
            DataTable dt = dbm.getRecommendations_retrieve(attraction_name);
            return Ok(dt);
        }
        
        // GET api/ValuesController/getLocal_business_info?city_id=2
        [HttpGet]
        [Route("getLocal_business_info")]
        public ActionResult<IEnumerable<string>>getLocal_business_info(int city_id)
        {
            //List<string> listTourGuides = new List<string>();
            DatabaseModel dbm = new DatabaseModel();
            DataTable dt = dbm.getLocal_business_info(city_id);
             return Ok(dt);
        }
       //POST api/ValuesController/PostAdd_Recommendation
         [HttpPost]
         [Route("PostAdd_Recommendation")]
         public ActionResult<IEnumerable<string>> PostAdd_Recommendation([FromBody] JObject rec)
         {


                string title = rec["rtitle"].ToString();
                DateTime creation_date= (DateTime)rec["rcreation_date"];
                DateTime posting_time = (DateTime)rec["rposting_time"];
                int post_rating = (int)rec["rpost_rating"];
                string tips = rec["rtips"].ToString();
                string description = rec["rdescription"].ToString();
                string personal_info = rec["rpersonal_info"].ToString();
                int attraction_id = (int)rec["rattraction_id"];
                int city_id = (int)rec["rcity_id"];
                int local_uid= (int)rec["rlocal_uid"];
                int tour_guide_id=(int)rec["rtour_guide_id"];
                int tourist_id =(int)rec["rtourist_id"];
                string title_name = rec["rtitle"].ToString();
                DatabaseModel dbm = new DatabaseModel();
                string res = dbm.PostAdd_Recommendation(title,creation_date,posting_time,post_rating,tips,description,personal_info,
                attraction_id,city_id,local_uid,tour_guide_id,tourist_id);
                return Ok(res.ToString());
        }

        // PUT api/ValuesController/updateLocalRatings
        [HttpPut]
        [Route("updateLocalRatings")]
        public ActionResult<IEnumerable<string>> updateLocalRatings([FromBody] JObject rat)
        {
            // Retrieve the attributes from the json object to be passed through the function
            int uid = (int)rat["uid"];
            int updated_rating = (int)rat["updatedRating"];
            
            DatabaseModel dbm = new DatabaseModel();
            int response = dbm.updateLocalRatings(uid,updated_rating);
            
            return Ok(response.ToString());
        }

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
            
            DatabaseModel dbm = new DatabaseModel();
            int response = dbm.addLocal(super_local_uid, local_user_id, city_id, super_local_flag);
            
            return Ok(response.ToString());
        }

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

            DatabaseModel dbm = new DatabaseModel();
            int response = dbm.verifyLocalBusiness(super_local_uid, business_license_number, name, address, city_id);
            
            return Ok(response.ToString());
        }

    }
}
