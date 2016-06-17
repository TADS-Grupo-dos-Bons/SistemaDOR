/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ws;

import Classes.Cliente;
import Classes.ClienteDAO;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.Produces;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PUT;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 * REST Web Service
 *
 * @author Junior
 */
@Path("verifica")
public class VerificaResource {

    @Context
    private UriInfo context;

    /**
     * Creates a new instance of VerificaResource
     */
    public VerificaResource() {
    }
    
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public Response postJson(Cliente cliente) {
        Boolean ativo = false;
        ClienteDAO ClienteDAO = new ClienteDAO();
        Cliente ClienteDOR = new Cliente();
        
        try {
            ClienteDOR = ClienteDAO.getByCpf(cliente.getCpf());
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(VerificaResource.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return Response.status(Response.Status.OK).header("Access-Control-Allow-Origin", "*").entity(ClienteDOR).build();
    }

    /**
     * Retrieves representation of an instance of ws.VerificaResource
     * @return an instance of java.lang.String
     */
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public String getJson() {
        //TODO return proper representation object
        throw new UnsupportedOperationException();
    }

    /**
     * PUT method for updating or creating an instance of VerificaResource
     * @param content representation for the resource
     */
    @PUT
    @Consumes(MediaType.APPLICATION_JSON)
    public void putJson(String content) {
    }
}
