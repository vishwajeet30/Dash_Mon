<%@ page language = "java" import = "java.sql.*, java.io.IOException, java.lang.*,java.text.*,java.util.*,java.awt.*,javax.naming.*,javax.sql.*"%>
<html>
<head>
	<title>Database</title>
	  
	<!--http://192.168.62.201:8889/Imm/vishwajeet/im_flight_routes_dashboard_00.jsp-->
	<script>	
	function openDetails(tagname)
	{
		if(tagname == 'arrival')
		{
			modelWindow_download("im_flight_routes_dashboard_01_arr.jsp?tagname="+tagname,'_blank', '0.80');
		}
		if(tagname == 'departure')
		{
			modelWindow_download("im_flight_routes_dashboard_02_dep.jsp?tagname="+tagname,'_blank', '0.80');
		}
		if (tagname == 'domestic') 
		{
			modelWindow_download("im_flight_routes_dashboard_03_domestic.jsp?tagname="+tagname,'_blank', '0.80');
		}
		if (tagname == 'neither') 
		{
			modelWindow_download("im_flight_routes_dashboard_04_neither.jsp?tagname="+tagname,'_blank', '0.80');
		}
		if (tagname == 'arrival_Hop')
		{
			modelWindow_download("im_flight_routes_dashboard_05_arr_hop.jsp?tagname="+tagname,'_blank', '0.80');
		}
		if (tagname == 'departure_Hop')
		{
			modelWindow_download("im_flight_routes_dashboard_06_dep_hop.jsp?tagname="+tagname,'_blank', '0.80');
		}
		if (tagname == 'country') 
		{
			modelWindow_download("im_flight_routes_dashboard_07_country.jsp?tagname="+tagname,'_blank', '0.80');
		}
		if (tagname == 'carrier') 
		{
			modelWindow_download("im_flight_routes_dashboard_08_carrier.jsp?tagname="+tagname,'_blank', '0.80');
		}
		if (tagname == 'airport') 
		{
			modelWindow_download("im_flight_routes_dashboard_09_airport.jsp?tagname="+tagname,'_blank', '0.80');
		}
		if (tagname == 'flight_Length_5') 
		{
			modelWindow_download("im_flight_routes_dashboard_flight_length_5.jsp?tagname="+tagname,'_blank', '0.80');
		}
		if (tagname == 'flight_Length_6') 
		{
			modelWindow_download("im_flight_routes_dashboard_flight_length_6.jsp?tagname="+tagname,'_blank', '0.80');
		}
		if (tagname == 'flight_Length_7') 
		{
			modelWindow_download("im_flight_routes_dashboard_flight_length_7.jsp?tagname="+tagname,'_blank', '0.80');
		}
		if (tagname == 'flight_Length_8') 
		{
			modelWindow_download("im_flight_routes_dashboard_flight_length_8.jsp?tagname="+tagname,'_blank', '0.80');
		}
		if (tagname == 'flight_Length_9') 
		{
			modelWindow_download("im_flight_routes_dashboard_flight_length_9.jsp?tagname="+tagname,'_blank', '0.80');
		}
		if (tagname == 'flight_Length_10') 
		{
			modelWindow_download("im_flight_routes_dashboard_flight_length_10.jsp?tagname="+tagname,'_blank', '0.80');
		}
	}

	var popupWindow = null;
	function closeWindow() 
	{  
  		popupWindow.close();  
	} 
	function modelWindow_download (mypage, myname, v_size)
	{
		var tmp_width = Math.round(screen.width * 0.70);
		var tmp_height = Math.round(screen.height * 0.80);
		var LeftPosition = (screen.width) ? (screen.width-tmp_width)/2 : 0;
		var TopPosition = (screen.height) ? (screen.height-tmp_height)/2 : 0;

		settings = 'dialogWidth:'+tmp_width+'px; dialogHeight:'+tmp_height+'px; dialogLeft:'+LeftPosition+'px;'+';dialogTop:'+TopPosition+'px;'+';toolbar=no;location=no;directories=no;menubar=no;scrollbars=yes;resizable=yes;';
		//win2 = window.showModalDialog(mypage, settings, settings);
			//window.open(mypage,"_blank","toolbar=yes,scrollbars=yes,resizable=yes,top=500,left=500,width=400,height=400");
			
			if(popupWindow && !popupWindow.closed){
				popupWindow.focus();

				document.onmousedown = popupWindow.focus();
				document.onkeyup = popupWindow.focus();
				document.onmousemove = popupWindow.focus();
			}
			else{

				popupWindow = window.open(mypage,"_blank","toolbar=yes,scrollbars=yes,resizable=0,location=yes,directories=no,menubar=yes,width="+tmp_width+",height="+tmp_height+",left="+LeftPosition+",top="+TopPosition);

				popupWindow.focus();
				
				document.onmousedown = popupWindow.focus();
				document.onkeyup = popupWindow.focus();
				document.onmousemove = popupWindow.focus();
			}
	}

	</script>
</head>

<body style="background-color: #f6f2ff; background-image: url('pic10.jpg');
  background-repeat: no-repeat;
  background-attachment: fixed;
  background-size: cover;">

  <!--background-color: #D0DDEA;-->
			
		<h1 style="font-family: Arial; color: #347FAA; font-size: 50px;"><center>International Flight Routes Statistics</center></h1><br><br>

		<!--http://192.168.62.201:8889/Imm/vishwajeet/im_flight_routes_dashboard_00.jsp-->

		<%
	////////////////////////////////////////////////////////////////////////////


Context ctx = null;
Connection con = null;

ctx = new InitialContext();
Context envCtx = (Context)ctx.lookup("java:comp/env");
DataSource ds = (DataSource)envCtx.lookup("jdbc/im_pax_flights");
con = ds.getConnection();

PreparedStatement psTemp = null;
ResultSet rsTemp = null;

	/////////////////////////////////////////////////////	Summary Table	//////////////////////////////////////////////////////////

String selectQuery= ""; String totalflights= ""; String arrflights = ""; String depflights = ""; String neitherFlights = "";
String flightNumber1 = "";String  sourcePort1 = "" ;String  destinationPort1 = "" ;String sourceCountryCode1 = "";String  destinationCountryCode1 = "" ;
String flightNumber2 = "";String  sourcePort2 = "" ;String  destinationPort2 = "" ;String sourceCountryCode2 = "";
String destinationCountryCode2 = "" ; String dep_flt_no = ""; String selectSummary = ""; String total_Flights_By_Digits = ""; String bothIndiaFlights = "";
String selectHopping = ""; String arr_Hop = ""; String dep_Hop = ""; String dep_Count = "";
int arr_dep_matched_flts = 0;
int arr_dep_not_matched_flts = 0;
int arr_dep_not_defined_matched_flts = 0;
	
	try{
			
		try
		{
			selectSummary = "select count(1) from IM_FLIGHT_ROUTES";
			psTemp = con.prepareStatement(selectSummary);
			
			rsTemp = psTemp.executeQuery();
			if(rsTemp.next())
			{
					totalflights = rsTemp.getString(1);
			} 			
				rsTemp.close();
				psTemp.close();
		}

			catch(Exception e){
				out.println("All Flights Exception");
			}	
				try
				{
						selectSummary = "select count(1) from IM_FLIGHT_ROUTES where DEST_COUNTRY_CODE='IND' and SRC_COUNTRY_CODE <> 'IND'";
						psTemp = con.prepareStatement(selectSummary);
						rsTemp = psTemp.executeQuery();
						if(rsTemp.next())
						{
								arrflights = rsTemp.getString(1);
						} 
						rsTemp.close();
						psTemp.close();
				}
					catch(Exception e){
						out.println("Arrival Exception");
					}

				try
				{
						selectSummary = "select count(1) from IM_FLIGHT_ROUTES where SRC_COUNTRY_CODE='IND' and DEST_COUNTRY_CODE <>'IND' ";
						psTemp = con.prepareStatement(selectSummary);
						rsTemp = psTemp.executeQuery();
						if(rsTemp.next())
						{
								depflights = rsTemp.getString(1);
						} 
						rsTemp.close();
						psTemp.close();
				}
					catch(Exception e){
						out.println("Departure Exception");
					}
				
				try
				{
						selectSummary = "SELECT count(1) FROM IM_FLIGHT_ROUTES where SRC_COUNTRY_CODE <> 'IND' and  DEST_COUNTRY_CODE <> 'IND' ";
						psTemp = con.prepareStatement(selectSummary);
						rsTemp = psTemp.executeQuery();
						if(rsTemp.next())
						{
								neitherFlights = rsTemp.getString(1);
						} 
						rsTemp.close();
						psTemp.close();
				}				
					 catch(Exception e){
						out.println("Neither Arrival nor Departure Exception");
					}

					try
					{
						selectSummary = "SELECT count(1) FROM IM_FLIGHT_ROUTES where SRC_COUNTRY_CODE = 'IND' and  DEST_COUNTRY_CODE = 'IND' ";
						psTemp = con.prepareStatement(selectSummary);
						rsTemp = psTemp.executeQuery();
						if(rsTemp.next())
						{
								bothIndiaFlights = rsTemp.getString(1);
						} 
						rsTemp.close();
						psTemp.close();

				}
				
					 catch(Exception e){
						out.println("both Arrival and Departure Exception");
					}
			}
					catch(Exception e)  
						{    
								
							out.println("selectQuery Exception");  
						}  		
%>
<table align="center" width="80%" border="1" cellspacing="0" cellpadding="8" bordercolorlight="#e5f6ff" bodercolordark="#e5f6ff" bodercolor="#e5f6ff" style="border-collapse: collapse;background-color: #FFFFFF; font-family: verdana;font-size: 8pt;text-align: left; border-color:#e5f6ff;">
	<tr style=" background-color: #E6AD80;font-family: Verdana; font-size: 20px; font-weight: bold; color: white;height: 65%;">
		<td bgcolor="#ADB643" width="15%"><center>Total Flights<!--<br><br><font style="font-size:8px;font-weight: normal; ">select count(1) from IM_FLIGHT_ROUTES--></center></td>
		<td bgcolor="#9f1853" width="15%"><center>Arrival Flights<!--<br><br><font style="font-size:8px; color: white; font-weight: normal; ">DEST_COUNTRY_CODE='IND' and SRC_COUNTRY_CODE <> 'IND'</font>--></center></td>
		<td bgcolor="#D46545" width="15%"><center>Departure Flights<!--<br><br><font style="font-size:8px; color: white; font-weight: normal;">SRC_COUNTRY_CODE='IND' and DEST_COUNTRY_CODE <>'IND'</font>--></center></td>
		<td bgcolor="#818A59" width="15%"><center>Domestic Flights<!--<br><br><font style="font-size:8px; color:white; font-weight: normal;">SRC_COUNTRY_CODE = 'IND' and  DEST_COUNTRY_CODE = 'IND'</font>--></center></td>
		<td bgcolor="#E89C2D" width="15%"><center>Flights neither Arriving nor Departing<br> from India<!--<br><br><font style="font-size:8px; color: white; font-weight: normal;">SRC_COUNTRY_CODE <> 'IND' and DEST_COUNTRY_CODE <> 'IND'</font>--></center></td>
	</tr>

	<tr style="font-family: Verdana; font-size: 18px; color:white;font-weight: bold">
		<td bgcolor="#ADB643" ><center><%=totalflights%></center></td>
		<td bgcolor="#9f1853"><center><a style="text-decoration:none;color:white;" href="javascript:void(0);" href="" onclick="openDetails('arrival')">
			<%=arrflights%></a></center></td>
		<td bgcolor="#D46545"><center><a style="text-decoration:none;color:white;" href="javascript:void(0);" href="" onclick="openDetails('departure')">
			<%=depflights%></a></center></td>
		<td bgcolor="#818A59"><center><a style="text-decoration:none;color:white;" href="javascript:void(0);" href="" onclick="openDetails('domestic')">
			<%=bothIndiaFlights%></a></center></td>
		<td bgcolor="#E89C2D" ><center><a style="text-decoration:none;color:white;" href="javascript:void(0);" href="" onclick="openDetails('neither')"><%=neitherFlights%></a></center></td>
	</tr>
	</table><br><br><p>
							<%///////////////////////////////////////////		Summary Table - End 	///////////////////////////////////////%>


		<%////////////////////////////////////////////////////////////  Hoping Table - Start  //////////////////////////////////////////////////////////////////////%>

<table align="center" width="20%" border="1" cellspacing="0" cellpadding="8" bordercolorlight="#e5f6ff" bodercolordark="#e5f6ff" bodercolor="#e5f6ff" style="border-collapse: collapse;background-color: #FFFFFF; font-family: verdana;font-size: 8pt;text-align: left; border-color:#e5f6ff;">		

<tr style=" background-color: #E6AD80;font-family: Verdana; font-size: 20px; font-weight: bold; color: white;">
	<!--<td bgcolor="#f6f2ff">&nbsp;</td>-->
	<td bgcolor="#599e94" width="50%"><center>Arrival Hopping Flights</center></td>
	<td bgcolor="#76c8c8" width="50%"><center>Departure Hopping Flights	</center></td>
</tr>
	<%
try
{
	selectHopping = "SELECT count(1) as arr_count FROM IM_FLIGHT_ROUTES where SRC_COUNTRY_CODE <> 'IND' and  DEST_COUNTRY_CODE = 'IND' and (HOP1_PORT_CODE is not null or HOP2_PORT_CODE is not null)";
		psTemp = con.prepareStatement(selectHopping);
		rsTemp = psTemp.executeQuery();
   if(rsTemp.next())
   {
			arr_Hop = rsTemp.getString("arr_count");
   }
   rsTemp.close();
   psTemp.close();

   selectHopping = "SELECT count(1) as dep_Count FROM IM_FLIGHT_ROUTES where SRC_COUNTRY_CODE = 'IND' and  DEST_COUNTRY_CODE <> 'IND' and (HOP1_PORT_CODE is not null or HOP2_PORT_CODE is not null)";
		psTemp = con.prepareStatement(selectHopping);
		rsTemp = psTemp.executeQuery();
    if(rsTemp.next())
    {
  	  dep_Hop = rsTemp.getString("dep_Count");
    }
    rsTemp.close();
    psTemp.close();        
	%>

	<tr style=" background-color: #E6AD80;font-family: Verdana; font-size: 18px; font-weight: bold; color: white;">
		<!--<td bgcolor="#f6f2ff">&nbsp;</td>-->
		<td bgcolor="#599e94"><center><a style="text-decoration:none;color:white;" href="javascript:void(0);" href="" onclick="openDetails('arrival_Hop')">
			<%=arr_Hop %></a></center></td>
		<td bgcolor="#76c8c8"><center><a style="text-decoration:none;color:white;" href="javascript:void(0);" href="" onclick="openDetails('departure_Hop')">
			<%=dep_Hop %></a></center></td>
		<!--<td bgcolor="#f6f2ff">&nbsp;</td>-->
		<!--<td bgcolor="#f6f2ff">&nbsp;&nbsp;</td>-->
	</tr>
  </table><br><br><p>
<%
	}
		catch(Exception e){
			out.println("Hoping Table Exception");
		} 
						
							//////////////////////////////////////////////////////////	End of Hoping Table 	////////////////////////////////////////////////////////


		////////////////////////////////////////////////////////////	Flight No. Length Table Start ///////////////////////////////////////////////////////////

String selectTotal = "";
String fiveDigitFlight = "";
String sixDigitFlight = "";
String sevenDigitFlight = "";
String eightDigitFlight = "";
String nineDigitFlight = "";
String tenDigitFlight = "";
try
{
	selectTotal = "select LENGTH(flight_no) as flight_no_length, count(1) as ccount from IM_FLIGHT_ROUTES group by LENGTH(flight_no) order by 1 asc";
	psTemp = con.prepareStatement(selectTotal);
	rsTemp = psTemp.executeQuery();

	%><table align="center" width="50%" border="1" cellspacing="0" cellpadding="8" bordercolorlight="#FF99CC" bodercolordark="#FF99CC" bodercolor="#FF99CC" style="border-collapse: collapse;background-color: #FFFFFF; font-family: verdana;font-size: 8pt;text-align: left; border-color:#e5f6ff;">
	<tr style=" background-color: #E6E6EA;font-family: Verdana; font-size: 15px; color:white;font-weight: normal;">
		<td bgcolor="#115f9a"><center>Flight No.<br>(length 5 char)</center></td>
		<td bgcolor="#1984c5"><center>Flight No.<br>(length 6 char)</td>
		<td bgcolor="#22a7f0"><center>Flight No.<br>(length 7 char)</center></td>
		<td bgcolor="#de6e56"><center>Flight No.<br>(length 8 char)</center></td>
		<td bgcolor="#e14b31"><center>Flight No.<br>(length 9 char)</center></td>
		<td bgcolor="#c23728"><center>Flight No.<br>(length 10 char)</center></td>
	</tr>
	<%	
		while(rsTemp.next())
		{
			if(rsTemp.getInt("FLIGHT_NO_LENGTH")==5) fiveDigitFlight=rsTemp.getString("CCOUNT");
			if(rsTemp.getInt("FLIGHT_NO_LENGTH")==6) sixDigitFlight=rsTemp.getString("CCOUNT");
			if(rsTemp.getInt("FLIGHT_NO_LENGTH")==7) sevenDigitFlight=rsTemp.getString("CCOUNT");
			if(rsTemp.getInt("FLIGHT_NO_LENGTH")==8) eightDigitFlight=rsTemp.getString("CCOUNT");
			if(rsTemp.getInt("FLIGHT_NO_LENGTH")==9) nineDigitFlight=rsTemp.getString("CCOUNT");
			if(rsTemp.getInt("FLIGHT_NO_LENGTH")==10) tenDigitFlight=rsTemp.getString("CCOUNT");
		}
		rsTemp.close();
		psTemp.close();
			%>
				<tr style="font-family: Verdana; font-size: 12pt; color:white;font-weight: bold">
				<td bgcolor="#115f9a"><center><a style="text-decoration:none;color:white;" href="javascript:void(0);" href="" onclick="openDetails('flight_Length_5')">
			<%=fiveDigitFlight%></a></center></td>
					<td bgcolor="#1984c5"><center><a style="text-decoration:none;color:white;" href="javascript:void(0);" href="" onclick="openDetails('flight_Length_6')">
					<%=sixDigitFlight%></a></center></td>
					<td bgcolor="#22a7f0"><center><a style="text-decoration:none;color:white;" href="javascript:void(0);" href="" onclick="openDetails('flight_Length_7')">
					<%=sevenDigitFlight%></a></center></td>
					<td bgcolor="#de6e56"><center><a style="text-decoration:none;color:white;" href="javascript:void(0);" href="" onclick="openDetails('flight_Length_8')">
					<%=eightDigitFlight%></a></center></td>
					<td bgcolor="#e14b31"><center><a style="text-decoration:none;color:white;" href="javascript:void(0);" href="" onclick="openDetails('flight_Length_9')">
					<%=nineDigitFlight%></a></center></td>
					<td bgcolor="#c23728"><center><a style="text-decoration:none;color:white;" href="javascript:void(0);" href="" onclick="openDetails('flight_Length_10')">
					<%=tenDigitFlight%></a></center></td>
				</tr>
			</table><br><br><p>
			<%
}
catch(Exception e)
{
	out.println("Digits Flights");
}
		/////////////////////////////////////////////////		Flight No. Length Table - End		/////////////////////////////////////////////////

		//////////////////////////////////////////		Country Arrival And Departure Table - Start (Demo)     ///////////////////////////////////////////

String select_Arr_CarrierTotal = "";
String select_Dep_CarrierTotal = "";
String srcCountryCode = "";
String srcCountryCode2 = "";
String carriersCount2 = "";
String carriersCount3 = "";
String carriersCount4 = "";
String CountQuery3 = "";
String CountQuery4 = "";
String QueryCount3 = "";
String QueryCount4 = "";
int carrierCount5 = 0;
int total_Arr_Country = 0;
int sum_Arr_Dep_Country = 0;
int count3 = 0;
int count4 = 0;
int sum_Countries_Record = 0;
	
	try
	{
		select_Arr_CarrierTotal = "select SRC_COUNTRY_CODE as src_country, count(1) as ca_arr_count from IM_FLIGHT_ROUTES WHERE SRC_COUNTRY_CODE <> 'IND' and  DEST_COUNTRY_CODE = 'IND' group by SRC_COUNTRY_CODE order by 2 desc";  
		try
		{
				CountQuery3 = "select count(1) from (" + select_Arr_CarrierTotal.toString() + ")"; //out.println("<br>" + CountQuery);
				psTemp = con.prepareStatement(CountQuery3);
				rsTemp = psTemp.executeQuery(); 
				if(rsTemp.next())
					{
						QueryCount3 = rsTemp.getString(1);
					}
					rsTemp.close();
					psTemp.close();						
					//out.println("      Your Query yields " + QueryCount3 + " Records");
					count3 = Integer.parseInt(QueryCount3);

		   }
		catch(Exception e)
		{
			out.println(e);
		}
		try
		{
			CountQuery4 = "select count(1) from (select DEST_COUNTRY_CODE as dest_country, count(1) as ca_dep_count from IM_FLIGHT_ROUTES WHERE SRC_COUNTRY_CODE = 'IND' and  DEST_COUNTRY_CODE <> 'IND' and DEST_COUNTRY_CODE in (select DEST_COUNTRY_CODE as dest_country from IM_FLIGHT_ROUTES WHERE SRC_COUNTRY_CODE = 'IND' and  DEST_COUNTRY_CODE <> 'IND' group by DEST_COUNTRY_CODE minus select SRC_COUNTRY_CODE as src_country from IM_FLIGHT_ROUTES WHERE SRC_COUNTRY_CODE <> 'IND' and  DEST_COUNTRY_CODE = 'IND' group by SRC_COUNTRY_CODE ) group by DEST_COUNTRY_CODE order by 2 desc)"; //out.println("<br>" + CountQuery);
			psTemp = con.prepareStatement(CountQuery4);
			rsTemp = psTemp.executeQuery(); 
			if(rsTemp.next())
				{
					QueryCount4 = rsTemp.getString(1);
				}
				rsTemp.close();
				psTemp.close();						
				//out.println("      Your Query yields " + QueryCount4 + " Records");
				count4 = Integer.parseInt(QueryCount4);
				sum_Countries_Record = count3 + count4;////MAIN 2
		}
			catch(Exception e)
			{
				out.println(e);
			}	
	}
	catch(Exception e){
		out.println("Carrier Arrival And Departure Table Exception");
	}


		///////////////////////////////////////////////////	Country Arrival And Departure Table - End  ////////////////////////////////////////////////////////////////////////////	
			
		//////////////////////////////////////////////////////	 Carriers Arr Dep List Table - Start  //////////////////////////////////////////////////////////////


String selectCarrier = "";
String carriers = "";
String carriersCount = "";
int carrierFlightCount = 0;
int total_Carrier_Arr_Count = 0;
int total_carrierFlightCount = 0;
int sum_Arr_Dep = 0;
int total_Arr_Carrier = 0;
int total_Final = 0;
String carrier_Arr = "";
String selectCarrierDep = "";
String selectCarrierArr = "";
String carrier_Arr_Count = "";
String carrier_Dep = "";
String carrier_Dep_Count = "";
String bgcolor="e8daff";
String QueryCount = "";
String CountQuery = "";
String QueryCount2 = "";
String CountQuery2 = "";
int sum_Carriers_Record = 0;
int count1 = 0;
int count2 = 0;
int query1 = 0;
int query2 = 0;

		try{
			selectCarrierArr= "select substr(flight_no,1,2) as flight_carriers_Arr, count(1) as ca_Arr_Count from IM_FLIGHT_ROUTES where SRC_COUNTRY_CODE <> 'IND' and  DEST_COUNTRY_CODE = 'IND' group by substr(flight_no,1,2) order by 2 desc";
				////Arrival	
			try{
					CountQuery = "select count(1) from (" + selectCarrierArr.toString() + ")"; //out.println("<br>" + CountQuery);
					psTemp = con.prepareStatement(CountQuery);
					rsTemp = psTemp.executeQuery(); 
					if(rsTemp.next())
						{
							QueryCount = rsTemp.getString(1);
						}
						rsTemp.close();
						psTemp.close();						
						//out.println("      Your Query yields " + QueryCount + " Records");
						count1 = Integer.parseInt(QueryCount);
				}
				catch(Exception e)
				{
					out.println(e);
				}

				try
				{
					CountQuery2 = "select count(1) from (select substr(flight_no,1,2) as flight_carriers, count(1) as ca_dep_new_count from IM_FLIGHT_ROUTES WHERE SRC_COUNTRY_CODE = 'IND' and  DEST_COUNTRY_CODE <> 'IND' and substr(flight_no,1,2) in (select substr(flight_no,1,2) as flight_carriers from IM_FLIGHT_ROUTES where SRC_COUNTRY_CODE = 'IND' and  DEST_COUNTRY_CODE <> 'IND' group by substr(flight_no,1,2) minus select substr(flight_no,1,2) as flight_carriers from IM_FLIGHT_ROUTES where SRC_COUNTRY_CODE <> 'IND' and  DEST_COUNTRY_CODE = 'IND' group by substr(flight_no,1,2)) group by substr(flight_no,1,2) order by 2 desc)"; 
					psTemp = con.prepareStatement(CountQuery2);
					rsTemp = psTemp.executeQuery(); 
					if(rsTemp.next())
						{
							QueryCount2 = rsTemp.getString(1);
						}
						rsTemp.close();
						psTemp.close();						
						//out.println("      Your Query yields " + QueryCount + " Records");
						count2 = Integer.parseInt(QueryCount2);
						sum_Carriers_Record = count1+count2;//////////MAIN 2		
				}
				catch(Exception e)
				{
					out.println(e);
				}
			
		}	
	catch(Exception e){
			out.println("Carrier list Arr Dep table Exception");
		}

		finally
	{
		try
		{
			if(con != null)
			{
				con.close();
			}
			if(ctx != null)
			{
				ctx.close();
			}
		}
		catch(Exception e)
		{
			//out.println(e.getMessage());
		}
	}
				/////////////////////////////////////////////			Carriers Arr Dep List Table - End		////////////////////////////////////////	


														///////////////////////// Airport table - Start ////////////////////////

String select_Dep_AirportTotal_00 = "";
String srcPortCode = "";
String srcPortCode2 = "";
String airportCount2 = "";
String airportcount30 = "";
String airportcount40 = "";
String CountQuery30 = "";
String CountQuery40 = "";
String Querycount300 = "";
String Querycount400 = "";
String select_Arr_CarrierTotal00 = "";
String error_bgColour = "";
int carrierCount5_00 = 0;
int total_Arr_Airport_00 = 0;
int sum_Arr_Dep_Airport_00 = 0;
int count30 = 0;
int count40 = 0;
int sum_Airport_Record_00 = 0;
String select_Arr_AirportTotal = "";
String lblQuery = "";

	//select SRC_PORT_CODE as src_port, count(1) as airport_arr_count from IM_FLIGHT_ROUTES WHERE SRC_PORT_CODE <> 'IND' and  DEST_COUNTRY_CODE = 'IND' group by SRC_PORT_CODE order by 2 desc
try{
	con = ds.getConnection();
		select_Arr_AirportTotal = "select SRC_PORT_CODE as src_port, count(1) as airport_arr_count from IM_FLIGHT_ROUTES WHERE SRC_PORT_CODE <> 'IND' and  DEST_COUNTRY_CODE = 'IND' group by SRC_PORT_CODE order by 2 desc";
		//out.println("select_Arr_AirportTotal");
		////// COUNT ////
			 try{	//select count(1) from (select SRC_PORT_CODE as src_port, count(1) as airport_arr_count from IM_FLIGHT_ROUTES WHERE SRC_COUNTRY_CODE <> 'IND' and  DEST_COUNTRY_CODE = 'IND' group by SRC_PORT_CODE order by 2 desc)
				CountQuery30 = "select count(1) from (" + select_Arr_AirportTotal.toString() + ")"; //out.println("<br>" + CountQuery30);
				psTemp = con.prepareStatement(CountQuery30);
				rsTemp = psTemp.executeQuery();
				count30 = 0;
				if(rsTemp.next())
					{
						Querycount300 = rsTemp.getString(1);
					}
					rsTemp.close();
					psTemp.close();
					//out.println("      Your Query yields " + Querycount300 + " Records");
					count30 = Integer.parseInt(Querycount300);
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
				
			 try{
				CountQuery40 = "select count(1) from (select DEST_PORT_CODE as src_port, count(1) as airport_arr_count from IM_FLIGHT_ROUTES WHERE SRC_COUNTRY_CODE = 'IND' and  DEST_COUNTRY_CODE <> 'IND' and DEST_PORT_CODE in (select DEST_PORT_CODE as dest_port from IM_FLIGHT_ROUTES WHERE SRC_COUNTRY_CODE = 'IND' and  DEST_COUNTRY_CODE <> 'IND' group by DEST_PORT_CODE minus select SRC_PORT_CODE as src_port from IM_FLIGHT_ROUTES WHERE SRC_COUNTRY_CODE <> 'IND' and  DEST_COUNTRY_CODE = 'IND' group by SRC_PORT_CODE) group by DEST_PORT_CODE order by 2 desc)"; 
				//out.println("<br>" + CountQuery40);
				psTemp = con.prepareStatement(CountQuery40);
				rsTemp = psTemp.executeQuery(); 
				count40 = 0;
				if(rsTemp.next())
					{
						Querycount400 = rsTemp.getString(1);
					}
					rsTemp.close();
					psTemp.close();						
					//out.println("      Your Query yields " + Querycount400 + " Records");
					count40 = Integer.parseInt(Querycount400);
					sum_Airport_Record_00 = count30 + count40;

				}
				catch(Exception e)
				{
					out.println(e);
				}							
		}
		catch(Exception e){
			e.printStackTrace();
		}
finally
	{
		try
		{
			if(con != null)
			{
				con.close();
			}
		}
		catch(Exception e)
		{
			//out.println(e.getMessage());
		}
	}
										///////////////////////////  Airport table - End /////////////////////////////

							//////////////////////////////////   Countries Airports and Carriers - Start  /////////////////////////////////

%>
<table align="center" width="25%" border="1" cellspacing="0" cellpadding="8" bordercolorlight="#FF99CC" bodercolordark="#FF99CC" bodercolor="#FF99CC" style="border-collapse: collapse;background-color: #FFFFFF; font-family: verdana;font-size: 8pt;text-align: left; border-color:#e5f6ff;">
	<tr style=" background-color: #78a9ff;font-family: Verdana; font-size: 20px; color:white;font-weight: bold; height: 40px;">
		<td  bgcolor="#ea5545" align="center" width="20%">Countries</td>
		<td  bgcolor="#ef9b20" align="center" width="20%">Carriers</td>
		<td  bgcolor="#6929c4" align="center" width="20%">Airports</td>
	</tr>	
	<tr style="font-family: Verdana; font-size: 18px; color:white;font-weight: bold; height: 40px;">
		<td bgcolor="#ea5545" align="center" width="20%"20><a style="text-decoration:none;color:white;" href="javascript:void(0);" href="" onclick="openDetails('country')">
			<%=sum_Countries_Record%></a></td>
		<td bgcolor="#ef9b20" align="center"><a style="text-decoration:none;color:white;" href="javascript:void(0);" href="" onclick="openDetails('carrier')">
			<%=sum_Carriers_Record%></a></td>
		<td bgcolor="#6929c4" align="center"><a style="text-decoration:none;color:white;" href="javascript:void(0);" href="" onclick="openDetails('airport')">
			<%=sum_Airport_Record_00%></a></td>	
	</tr>
</table><br><p><p>
									<%///////////////////////////////	Countries Airports and Carriers - End  //////////////////////////////////%>
</body>
</html>