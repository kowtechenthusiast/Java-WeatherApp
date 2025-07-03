<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Weather Forecast</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      background: linear-gradient(to bottom right, #0f2027, #203a43, #2c5364);
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      color: #fff;
      height: 100vh;
      overflow: hidden;
    }

    .container {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      min-height: 100vh;
      padding: 40px;
      text-align: center;
    }

    form {
      display: flex;
      flex-direction: row;
      align-items: center;
      justify-content: center;
      margin-bottom: 20px;
      gap: 10px;
    }

    input[type="text"] {
      padding: 10px;
      font-size: 16px;
      border-radius: 5px;
      border: none;
      width: 220px;
      outline: none;
    }

    input[type="submit"], button {
      padding: 10px 20px;
      background-color: #00bcd4;
      border: none;
      outline: none;
      border-radius: 5px;
      color: white;
      font-weight: bold;
      cursor: pointer;
      transition: background 0.3s;
    }

    input[type="submit"]:hover, button:hover {
      background-color: #0097a7;
    }

    .weather-box {
      background-color: rgba(255, 255, 255, 0.05);
      border-radius: 10px;
      padding: 30px;
      max-width: 500px;
      width: 90%;
      backdrop-filter: blur(6px);
    }

    .weatherIcon img {
      width: 100px;
      margin-bottom: 10px;
    }

    .weather-data h2, .weather-data span {
      margin: 10px 0;
    }

    .row {
      display: flex;
      justify-content: space-around;
      margin-top: 20px;
      gap: 20px;
    }

    .row div {
      text-align: center;
    }

    .row img {
      height: 40px;
      margin-bottom: 5px;
    }

    @media (max-width: 600px) {
      form {
        flex-direction: column;
      }

      input[type="text"] {
        width: 100%;
        margin-bottom: 10px;
      }

      .row {
        flex-direction: column;
        align-items: center;
      }
    }
  </style>
</head>
<body>

<div class="container">

  <div class="weather-box">
    <!-- 📬 Input Form Inside Box -->
    <form action="MyServlet" method="post">
      <input type="text" name="city" placeholder="Enter City Name" required>
      <input type="submit" value="Get Weather">
    </form>

    <!-- 🌤️ Weather Data -->
    <div class="weatherIcon">
      <img src="" id="weather-icon">
    </div>

    <div class="weather-data">
      <h2>${temperature} °C</h2>
      <span><strong>${city}</strong> - ${date}</span>
    </div>

    <input type="hidden" id="wc" value="${weatherCondition}">

    <div class="row">
      <div>
        <img src="images/thermometer.png" alt="Humidity">
        <div>
          <span>Humidity</span>
          <h2>${humidity}%</h2>
        </div>
      </div>

      <div>
        <img src="images/wind.png" alt="Wind Speed">
        <div>
          <span>Wind Speed</span>
          <h2>${windSpeed} km/h</h2>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- 🧠 JS to Set Weather Icon -->
<script>
  const weatherIcon = document.getElementById("weather-icon");
  const val = document.getElementById("wc").value;

  switch (val) {
    case 'Clouds':
      weatherIcon.src = "images/Clouds.png";
	  weatherIcon.alt = "Clouds";
      break;
    case 'Clear':
      weatherIcon.src = "images/Clear.png";
	  weatherIcon.alt = "Clear";
      break;
    case 'Rain':
      weatherIcon.src = "images/rainy.png";
	  weatherIcon.alt = "Rain";
      break;
    case 'Mist':
      weatherIcon.src = "images/mist.png";
	  weatherIcon.alt = "Mist";
      break;
    case 'Snow':
      weatherIcon.src = "images/snow.png";
	  weatherIcon.alt = "Snow";
      break;
    case 'Haze':
      weatherIcon.src = "images/haze.png";
	  weatherIcon.alt = "Haze";
      break;
  }
</script>

</body>
</html>
