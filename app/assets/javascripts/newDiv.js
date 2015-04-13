var daysCounter = 1;
var daysLimit = 7;
var marketCounter = 1;
var marketLimit = 7;
function addInput(divName)
{
     if (daysCounter == daysLimit)  {
          alert("You have reached the limit of adding " + daysCounter + " inputs");
     }
     else {
          var newdiv = document.createElement('div');
          newdiv.innerHTML = "<div class=\"col-md-4\"><label for=\"openDays\">Days Open</label><select class=\"form-control\"> <option>Monday</option> <option>Tuesday</option> <option>Wednesday</option> <option>Thursday</option> <option>Friday</option> <option>Saturday</option> <option>Sunday</option> </select> </div> <div class=\"col-md-3 col-md-offset-0\"><div class=\"form-group\"><label for=\"yearFounded\">From</label><input type=\"marketName\" class=\"form-control\" id=\"marketName1\" placeholder=\"e.g. 1400\"></div></div> <div class=\"col-md-3 col-md-offset-0\"> <div class=\"form-group\" > <label for=\"yearFounded\">Till</label> <input type=\"marketName\" class=\"form-control\" id=\"marketName1\" placeholder=\"e.g. 1700\"></div></div>";
          document.getElementById(divName).appendChild(newdiv);
          daysCounter++;
     }
}
function addMarket(divName)
{
     if (marketCounter == marketLimit)  {
          alert("You have reached the limit of adding " + marketCounter + " inputs");
     }
     else {
          var newdiv = document.createElement('div');
          newdiv.innerHTML = "<div class=\"col-md-3 col-md-offset-0\"> <div class=\"form-group\" > <label for=\"yearFounded\"><br>Seperate Seasonal Market:</label> </div> </div> <div class=\"col-md-3 col-md-offset-0\"> <div class=\"form-group\"> <label for=\"yearFounded\">Opening Day</label> <input type=\"marketName\" class=\"form-control\" id=\"marketName1\" placeholder=\"Day/Month/Year\"> </div> </div> <div class=\"col-md-3 col-md-offset-0\"> <div class=\"form-group\" > <label for=\"yearFounded\">Closing Day</label> <input type=\"marketName\" class=\"form-control\" id=\"marketName1\" placeholder=\"Day/Month/Year\"> </div> </div> <div> <div class=\"clearfix\"></div>";
          document.getElementById(divName).appendChild(newdiv);
          marketCounter++;
     }
}
