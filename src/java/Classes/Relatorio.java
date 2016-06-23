package Classes;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRResultSetDataSource;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.view.JasperViewer;

/**
 *
 * @author marco.sanchotene
 */
@WebServlet(name = "Relatorio", urlPatterns = {"/Relatorio"})
public class Relatorio extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    
        
            int id = Integer.parseInt((request.getParameter("id")));

//            Cliente cliente = new Cliente();
//            ClienteDAO clienteDAO = new ClienteDAO();
//            Historico historico = new Historico();
//            HistoricoDAO historicoDAO = new HistoricoDAO();
//            List<Historico> lsthistorico = new ArrayList();
            
            
            Connection con = null;

            try {
                
                Cliente cliente = new Cliente();
                ClienteDAO clienteDAO = new ClienteDAO();
                           
                // Conexão com o banco
                Class.forName("com.mysql.jdbc.Driver");

                con = DriverManager.getConnection("jdbc:mysql://localhost/dor", "root", "");
                // Caminho contextualizado do relatório compilado

                String jasper = request.getContextPath() + "/dor.jasper";

                // Host onde o servlet esta executando
                String host = "http://" + request.getServerName() + ":" + request.getServerPort();

                // URL para acesso ao relatório
                URL jasperURL = new URL(host + jasper);

                // Parâmetros do relatório
                HashMap params = new HashMap();
                
                cliente = clienteDAO.getById(id);
                
                String stCliente = "";
                
                if(cliente.getStatus().equals("A")){
                    stCliente = "ATIVO";
                }else{
                    stCliente = "INATIVO";
                }
                
                
         
                params.put("id", id);
                params.put("idClienteStatus",stCliente);

                // Geração do relatório
                byte[] bytes = JasperRunManager.runReportToPdf(jasperURL.openStream(), params, con);
                if (bytes != null) {

                    // A página será mostrada em PDF
                    response.setContentType("application/pdf");

                    // Envia o PDF para o Cliente
                    OutputStream ops = response.getOutputStream();

                    ops.write(bytes);

                }

            } catch (ClassNotFoundException e) {

                request.setAttribute("mensagem", "Driver BD não encontrado : " + e.getMessage());

                request.getRequestDispatcher("erro.jsp").forward(request, response);

            } catch (SQLException e) {

                request.setAttribute("mensagem", "Erro de conexão ou query: " + e.getMessage());

                request.getRequestDispatcher("erro.jsp").forward(request, response);

            } catch (JRException e) {
                String teste = e.getMessage();
                String bla = "bla";
                request.setAttribute("mensagem", "Erro no Jasper : " + e.getMessage());

                request.getRequestDispatcher("erro.jsp").forward(request, response);

            } finally {

                if (con != null) {
                    try {
                        con.close();
                    } catch (Exception e) {
                    }
                }

            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            

//            try {
//                // Conexão com o banco
//                com.mysql.jdbc.Connection con = null;
//                PreparedStatement stmt = null;
//
//                String query = "select nome from cliente;";
//                ResultSet rs = null;
//                
//                try {
//                    con = (com.mysql.jdbc.Connection) ConnectionFactory.getConnection();
//                    stmt = con.prepareStatement(query);
//                    rs = stmt.executeQuery(query);
//                } catch (SQLException ex) {
//                    Logger.getLogger(Relatorio.class.getName()).log(Level.SEVERE, null, ex);
//                }
//
//                JRResultSetDataSource jrRS = new JRResultSetDataSource(rs);
//
//                Map parametros = new HashMap();
//
//                cliente = clienteDAO.getById(id);
//                String nome = cliente.getNome();
////                String rg = cliente.getRg();
////                String cpf = cliente.getCpf();
////                String status = cliente.getStatus();
////                
//                parametros.put("nome", nome);
////                parametros.put("rg", rg);
////                parametros.put("cpf", cpf);
////                parametros.put("status", status);
//
//                try {
////                    String jasperPrint = JasperFillManager.fillReportToFile("/relatorio_dor.jasper", parametros, jrRS);//Aqui vc chama o relatório
//                    String jasper = request.getContextPath() + "/relatorioDOR.jasper";
//
//                    // Host onde o servlet esta executando
//                    String host = "http://" + request.getServerName() + ":" + request.getServerPort();
//
//                    // URL para acesso ao relatório
//                    URL jasperURL = new URL(host + jasper);
//
//                    byte[] bytes = JasperRunManager.runReportToPdf(jasperURL.openStream(), parametros, jrRS);
//
//                    if (bytes != null) {
//
//                        // A página será mostrada em PDF
//                        response.setContentType("application/pdf");
//
//                        // Envia o PDF para o Cliente
//                        OutputStream ops = response.getOutputStream();
//
//                        ops.write(bytes);
//
//                    }
//                    
//                
//                } catch (JRException ex) {
//                    Logger.getLogger(Relatorio.class.getName()).log(Level.SEVERE, null, ex);
//                }
//
//            } catch (ClassNotFoundException ex) {
//                Logger.getLogger(EditaCliente.class.getName()).log(Level.SEVERE, null, ex);
//            }
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
