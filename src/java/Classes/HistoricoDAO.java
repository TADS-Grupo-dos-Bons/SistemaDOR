
package Classes;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author marco.sanchotene
 */
public class HistoricoDAO {
    private String stmtInsert = "insert into historico(dtInicio,dtFim,id_cliente,id_usuario,id_empresa_usuario) values(?,?,?,?,?);";
    private String stmtSelectListaById = "select * from historico where id_cliente=?";
    private String stmtSelectUltimoHistorico = "select * from historico where id_cliente=? and dtFim is null";
    private String stmtUpdate = "update historico set dtFim=? where id=?";
    
    public List<Historico> getListaById(String id) throws SQLException {
        com.mysql.jdbc.Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            con = (com.mysql.jdbc.Connection) ConnectionFactory.getConnection();
            stmt = con.prepareStatement(stmtSelectListaById, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, id);
            
            rs = stmt.executeQuery();
            List<Historico> lsthistorico = new ArrayList();
           
            while (rs.next()) {
                // criando o objeto Historico
                Historico historico = new Historico();
                historico.setId(rs.getInt("id"));
                historico.setDtInicio(rs.getDate("dtInicio"));
                historico.setDtFim(rs.getDate("dtFim"));
                historico.setId_cliente(rs.getInt("id_cliente"));
                historico.setId_usuario(rs.getInt("id_usuario"));
                historico.setId_empresa_usuario(rs.getInt("id_empresa_usuario"));

                // adicionando o objeto à lista
                lsthistorico.add(historico);
            }
            return lsthistorico;
        
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
    
    public void insert(Historico historico) {
        Connection con=null;
        PreparedStatement stmt = null;
        int idObjeto = 0;
        try {
            con = ConnectionFactory.getConnection();
            stmt = con.prepareStatement(stmtInsert, Statement.RETURN_GENERATED_KEYS);
            
            stmt.setDate(1, (Date) historico.getDtInicio());
            stmt.setDate(2, (Date) historico.getDtFim()); 
            stmt.setInt(3, historico.getId_cliente()); 
            stmt.setInt(4, historico.getId_usuario());
            stmt.setInt(5, historico.getId_empresa_usuario());
            stmt.execute();
            //Seta o id do sistema
            ResultSet rs = stmt.getGeneratedKeys();
            while(rs.next()){
                idObjeto = rs.getInt(1);
            }

            historico.setId(idObjeto);
            
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally{
            try{stmt.close();}catch(Exception ex){System.out.println("Erro ao fechar stmt. Ex="+ex.getMessage());};
            try{con.close();}catch(Exception ex){System.out.println("Erro ao fechar conexão. Ex="+ex.getMessage());};
        }
    }
    
    public Historico getUltimoHistorico(String id) throws SQLException {
        com.mysql.jdbc.Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            con = (com.mysql.jdbc.Connection) ConnectionFactory.getConnection();
            stmt = con.prepareStatement(stmtSelectUltimoHistorico, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, Integer.parseInt(id));
            
            rs = stmt.executeQuery();
            Historico historico = new Historico();
           
            while (rs.next()) {
                historico.setId(rs.getInt("id"));
                historico.setDtInicio(rs.getDate("dtInicio"));
                historico.setDtFim(rs.getDate("dtFim"));
                historico.setId_cliente(rs.getInt("id_cliente"));
                historico.setId_usuario(rs.getInt("id_usuario"));
                historico.setId_empresa_usuario(rs.getInt("id_empresa_usuario"));
            }
            return historico;
        
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
    
    public void update(Historico historico) {
        com.mysql.jdbc.Connection con = null;
        PreparedStatement stmt = null;
        try {

            con = (com.mysql.jdbc.Connection) ConnectionFactory.getConnection();
            stmt = con.prepareStatement(stmtUpdate);
            stmt.setDate(1, (Date) historico.getDtFim());
            stmt.setInt(2, historico.getId());
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
