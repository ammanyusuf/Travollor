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
    [Route("api/ValuesController")]
    [ApiController]
    public class ValuesController : ControllerBase
    {
        // Test Connection To Database
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
                int post_rating = (int)rec["post_rating"];
                string tips = rec["rtips"].ToString();
                string description = rec["rdescription"].ToString();
                string personal_info = rec["rpersonal_info"].ToString();
                int attraction_id = (int)rec["rattraction_id"];
                int city_id = (int)rec["rcity_id"];
                int local_uid= (int)rec["local_uid"];
                int tour_guide_id=(int)rec["rtour_guide_id"];
                int tourist_id =(int)rec["rtourist_id"];
                string title_name = rec["rtitle"].ToString();

                DatabaseModel dbm = new DatabaseModel();
                int res = dbm.PostAdd_Recommendation(title,creation_date,posting_time,post_rating,tips,description,personal_info,
                attraction_id,city_id,local_uid,tour_guide_id,tourist_id,title_name);
                return Ok(res.ToString());
        }


    }
}
