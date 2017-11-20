package com.lojaappweb.conn;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MySQLConnUtils {
	public static Connection getMySQLConnection() throws ClassNotFoundException, SQLException {
		// Define dados da conexão com BD
	    String hostName = "localhost";
	    String dbName = "loja_aplicativos";
	    String userName = "root";
	    String password = "root";
	    return getMySQLConnection(hostName, dbName, userName, password);
	 }
	  
	 public static Connection getMySQLConnection(String hostName, String dbName, String userName, String password) throws SQLException, ClassNotFoundException {
		 // Sobrecarga
		 // Define dados da conexão com BD
		 Class.forName("com.mysql.jdbc.Driver");
		 String connectionURL = "jdbc:mysql://" + hostName + ":3306/" + dbName;
		 Connection conn = DriverManager.getConnection(connectionURL, userName, password);
		 return conn;
	 }
}