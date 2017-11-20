package com.lojaappweb.model;

//Importa todas as bibliotecas necessárias
import java.util.Date;
import java.text.SimpleDateFormat;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class CompraModel {
	public static void compraAplicativo(Connection conn, int idAplicativo, int idUsuario) throws SQLException {
		// Efetua cadastro na tabela compra para linkar usuário com aplicativo
        String sql = "Insert into compra(idAplicativo, idUsuario, preco, dataHoraCompra, compraFinalizada) values (?,?,?,?,?)";
 
        PreparedStatement pstm = conn.prepareStatement(sql);
        
        String timeStamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
 
        pstm.setInt(1, idAplicativo);
        pstm.setInt(2, idUsuario);
        pstm.setDouble(3, 0);
        pstm.setString(4, timeStamp);
        pstm.setInt(5, 1);
 
        pstm.executeUpdate();
    }
}
