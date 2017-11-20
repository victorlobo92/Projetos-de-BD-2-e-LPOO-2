package com.lojaappweb.model;

//Importa todas as bibliotecas necessárias
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
 
import com.lojaappweb.beans.Categoria;
 
public class CategoriaModel {
 
    public static List<Categoria> listaCategorias(Connection conn) throws SQLException {
    	// Busca todas as categorias
        String sql = "SELECT * "
        		+ "FROM categoria";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
        ResultSet rs = pstm.executeQuery();
 
        List<Categoria> list = new ArrayList<Categoria>();
        while(rs.next()) {
            int idCategoria = rs.getInt("idCategoria");
            String categoria = rs.getString("categoria");
            Categoria categ = new Categoria(idCategoria, categoria);
            list.add(categ);
        }
        return list;
    }
 
}