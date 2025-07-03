package MyPackage;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.util.Date;
import java.util.Scanner;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

/**
 * Servlet implementation class MyServlet
 */
@WebServlet("/MyServlet")
public class MyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.sendRedirect("index.html");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String city = request.getParameter("city");
		String apiKey = "1f64b6a107ded85a78701cfe7e837186";
		String apiUrl = String.format("https://api.openweathermap.org/data/2.5/weather?q=%s&appid=%s", city,apiKey);
		
		try {
			URI uri = URI.create(apiUrl);
			URL url = uri.toURL();        

			
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setRequestMethod("GET");
			
			InputStream inputStream = connection.getInputStream();
			InputStreamReader reader = new InputStreamReader(inputStream);
			
			Scanner scanner = new Scanner(reader);
			
			StringBuilder apiResponse = new StringBuilder();
			
			while(scanner.hasNext()) {
				apiResponse.append(scanner.nextLine());
			}
			
			scanner.close();
			
			Gson gson = new Gson();
			JsonObject jsonObject = gson.fromJson(apiResponse.toString(), JsonObject.class);
					
			
			double windSpeed = jsonObject.getAsJsonObject("wind").get("speed").getAsDouble();
			int humidity = jsonObject.getAsJsonObject("main").get("humidity").getAsInt();
			long dateTimestamp = jsonObject.get("dt").getAsLong() * 1000;
            String date = new Date(dateTimestamp).toString();
			String weatherCondition = jsonObject.getAsJsonArray("weather").get(0).getAsJsonObject().get("main").getAsString();
			double tempKelvin = jsonObject.getAsJsonObject("main").get("temp").getAsDouble();
			int tempCelsius = (int)(tempKelvin-273.15);
			
			
			
			request.setAttribute("date", date);
            request.setAttribute("city", city);
            request.setAttribute("temperature", tempCelsius);
            request.setAttribute("weatherCondition", weatherCondition); 
            request.setAttribute("humidity", humidity);    
            request.setAttribute("windSpeed", windSpeed);
            request.setAttribute("weatherData", apiResponse.toString());
            
            connection.disconnect();
			
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		request.getRequestDispatcher("result.jsp").forward(request, response);
	}

}
