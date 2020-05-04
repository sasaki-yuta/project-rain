using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using System.Text.Encodings.Web;

// For more information on enabling MVC for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace ModelingTool.Controllers
{
    public class HelloWorldController : Controller
    {

        // GET: /HelloWorld/
#if true
        public IActionResult Index()
        {
            return View();
        }
#else
        public string Index()
        {
            return "This is my default action...";
        }
#endif

        // 
        // GET: /HelloWorld/Welcome/ 

#if false
        public string Welcome(string name, int ID = 1)
        {
            // HtmlEncoder.Default.Encode を使って、悪意のある入力 (つまり JavaScript) からアプリを保護します
            return HtmlEncoder.Default.Encode($"Hello {name}, ID: {ID}");
        }
#else
        public IActionResult Welcome(string name, int numTimes = 1)
        {
            ViewData["Message"] = "Hello " + name;
            ViewData["NumTimes"] = numTimes;

            return View();
        }
#endif


        // 
        // GET: /HelloWorld/Rain/ 

        public string Rain()
        {
            return "Rain...";
        }
    }
}
