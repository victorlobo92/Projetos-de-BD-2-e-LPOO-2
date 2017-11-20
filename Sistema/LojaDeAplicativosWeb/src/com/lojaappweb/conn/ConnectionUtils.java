package com.lojaappweb.conn;

import java.sql.Connection;
import java.sql.SQLException;
 
public class ConnectionUtils {
 
    public static Connection getConnection() throws ClassNotFoundException, SQLException {
    	// Busca dados da conexão com BD
        return MySQLConnUtils.getMySQLConnection();
    }
     
    public static void closeQuietly(Connection conn) {
    	// Fecha conexão com BD
        try {
            conn.close();
        } catch (Exception e) {
        }
    }
 
    public static void rollbackQuietly(Connection conn) {
    	// Desfaz commit
        try {
            conn.rollback();
        } catch (Exception e) {
        }
    }
}