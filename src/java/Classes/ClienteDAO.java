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
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author allex
 */
public class ClienteDAO {
    private String stmtInsert = "insert into cliente(nome,rg,cpf,st_cliente) values(?,?,?,?);";
    private String stmtCheckLogin = "select * from cliente where cpf =? and senha=?;";
    private String stmtGetEndereco = "select * from endereco where idcliente=?";
    private String stmtSelectById = "select * from cliente where id =?";
    private String stmtSelect = "select * from cliente";
    private String stmtUpdate = "update cliente set nome=?, rg=?, cpf=?, st_cliente=? where id=?";
    private String stmtDelete = "delete from cliente where id = ?";
    
    public List<Cliente> getLista(String pesquisa) throws SQLException {
        com.mysql.jdbc.Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            con = (com.mysql.jdbc.Connection) ConnectionFactory.getConnection();
            if (!pesquisa.trim().equals("")) {

                stmtSelect = stmtSelect + " where nome LIKE ? or cpf LIKE ?";
                stmt = con.prepareStatement(stmtSelect);
                stmt.setString(1, "%"+pesquisa+"%");
                stmt.setString(2, "%"+pesquisa+"%");

            }else{

                stmt = con.prepareStatement(stmtSelect);
            }
            rs = stmt.executeQuery();
            List<Cliente> lstcliente = new ArrayList();
           
            while (rs.next()) {
                // criando o objeto Usuario
                Cliente cliente = new Cliente();
                cliente.setId(rs.getInt("id"));
                cliente.setNome(rs.getString("nome"));
                cliente.setRg(rs.getString("rg"));
                cliente.setCpf(rs.getString("cpf"));
                cliente.setStatus(rs.getString("st_cliente"));

                // adicionando o objeto à lista
                lstcliente.add(cliente);
            }
            return lstcliente;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                rs.close();
            } catch (Exception ex) {
                System.out.println("Erro ao fechar result set. Ex=" + ex.getMessage());
            };
            try {
                stmt.close();
            } catch (Exception ex) {
                System.out.println("Erro ao fechar stmt. Ex=" + ex.getMessage());
            };
            try {
                con.close();
            } catch (Exception ex) {
                System.out.println("Erro ao fechar conexão. Ex=" + ex.getMessage());
            };
        }

    }
    
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
                cliente.setStatus(rs.getString("st_cliente"));
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
    
    public void update(Cliente cliente) {
        com.mysql.jdbc.Connection con = null;
        PreparedStatement stmt = null;
        try {

            con = (com.mysql.jdbc.Connection) ConnectionFactory.getConnection();
            stmt = con.prepareStatement(stmtUpdate);
            stmt.setString(1, cliente.getNome());
            stmt.setString(2, cliente.getRg());
            stmt.setString(3, cliente.getCpf());
            stmt.setString(4, cliente.getStatus());
            stmt.setInt(5, cliente.getId());
            stmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                stmt.close();
            } catch (Exception ex) {
                System.out.println("Erro ao fechar stmt. Ex=" + ex.getMessage());
            };
            try {
                con.close();
            } catch (Exception ex) {
                System.out.println("Erro ao fechar conexão. Ex=" + ex.getMessage());
            };
        }
    }    
    
    public void exclui(Cliente cliente) {
        com.mysql.jdbc.Connection con = null;
        PreparedStatement stmt = null;
        try {

            con = (com.mysql.jdbc.Connection) ConnectionFactory.getConnection();
            stmt = con.prepareStatement(stmtDelete);
            stmt.setInt(1, cliente.getId());
            stmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                stmt.close();
            } catch (Exception ex) {
                System.out.println("Erro ao fechar stmt. Ex=" + ex.getMessage());
            };
            try {
                con.close();
            } catch (Exception ex) {
                System.out.println("Erro ao fechar conexão. Ex=" + ex.getMessage());
            };
        }
    }
    
}
