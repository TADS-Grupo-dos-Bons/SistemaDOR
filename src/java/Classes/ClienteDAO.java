/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Classes;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author allex
 */
public class ClienteDAO {
    private String stmtInsert = "insert into cliente(nome,rg,cpf,status,senha) values(?,?,?,?,?);";
    private String stmtCheckLogin = "select * from cliente where cpf =? and senha=?;";
    private String stmtGetEndereco = "select * from endereco where idcliente=?";
    private String stmtSelectById = "select * from cliente where id =?";
    
    public void insert(Cliente cliente) {
        Connection con=null;
        PreparedStatement stmt = null;
        int idObjeto = 0;
        try {
            con = ConnectionFactory.getConnection();
            stmt = con.prepareStatement(stmtInsert, Statement.RETURN_GENERATED_KEYS);
            
            stmt.setString(1, cliente.getNome());
            stmt.setString(2, cliente.getRg()); 
            stmt.setString(3, cliente.getCpf()); 
            stmt.setString(4, cliente.getStatus());
            stmt.setString(5, cliente.getSenha());
            stmt.execute();
            //Seta o id do sistema
            ResultSet rs = stmt.getGeneratedKeys();
            while(rs.next()){
                idObjeto = rs.getInt(1);
            }

            cliente.setId(idObjeto);
            
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally{
            try{stmt.close();}catch(Exception ex){System.out.println("Erro ao fechar stmt. Ex="+ex.getMessage());};
            try{con.close();}catch(Exception ex){System.out.println("Erro ao fechar conexão. Ex="+ex.getMessage());};
        }
    }
    
    public Cliente getById(int id) throws ClassNotFoundException{
        Cliente cliente = new Cliente();
        Connection con=null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            con = ConnectionFactory.getConnection();
            stmt = con.prepareStatement(stmtSelectById, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            while (rs.next()) {
                cliente.setId(rs.getInt("id"));
                cliente.setNome(rs.getString("nome"));
                cliente.setRg(rs.getString("rg"));
                cliente.setCpf(rs.getString("cpf"));
                cliente.setStatus(rs.getString("status"));
                cliente.setSenha(rs.getString("senha"));
            }
            return cliente;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally{
            try{stmt.close();}catch(Exception ex){System.out.println("Erro ao fechar stmt. Ex="+ex.getMessage());};
            try{con.close();}catch(Exception ex){System.out.println("Erro ao fechar conexão. Ex="+ex.getMessage());};
        }
  
    }
        
    public Cliente verificaLogin(String cpf, String senha) throws ClassNotFoundException{
        Class.forName("com.mysql.jdbc.Driver");
        Cliente cliente = new Cliente();
        com.mysql.jdbc.Connection con=null;
        PreparedStatement stmt = null;
        
        ResultSet rs = null;
        try {
            con = (com.mysql.jdbc.Connection) ConnectionFactory.getConnection();
            
            stmt = con.prepareStatement(stmtCheckLogin, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, cpf);
            stmt.setString(2, senha);
            rs = stmt.executeQuery();
            while (rs.next()) {
                cliente.setId(rs.getInt("id"));
                cliente.setNome(rs.getString("nome"));
                cliente.setRg(rs.getString("rg"));
                cliente.setCpf(rs.getString("cpf"));
                cliente.setStatus(rs.getString("status"));
                cliente.setSenha(rs.getString("senha"));

            }
            
            return cliente;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally{
            try{stmt.close();}catch(Exception ex){System.out.println("Erro ao fechar stmt. Ex="+ex.getMessage());};
            try{con.close();}catch(Exception ex){System.out.println("Erro ao fechar conexão. Ex="+ex.getMessage());};
        }  
    }
    
    
}
