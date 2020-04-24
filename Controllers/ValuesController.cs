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

    }
}
