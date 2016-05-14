<%-- 
    Document   : principal
    Created on : 10/05/2016, 20:05:40
    Author     : allex
--%>

<%@page import="com.sun.glass.ui.Pixels.Format"%>
<%@page import="Classes.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>DOR</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link type="text/css" rel="stylesheet" href="css/bootstrap.css">
    <link type="text/css" rel="stylesheet" href="css/tudo.css">
    <link type="text/css" rel="stylesheet" href="css/bootstrap-switch.css">
    <script src="js/jquery-2.2.1.js"></script>
    <script src="js/bootstrap.js"></script>
    <script src="js/bootstrap-switch.js"></script>
    <script type="text/javascript">
        function mostramodal(){
            $('#myModal2').modal('show');
        }
        function mostramodal1(){
            $('#myModal1').modal('show');
        }


        $( document ).ready(function() {

            $(".principal").addClass('active');

            $('#myTabs a').click(function (e) {
              e.preventDefault()
              $(this).tab('show')
            });
            
        });


    </script>
   
</head>
 <%  
    HttpSession sessionUsu = request.getSession();
    Usuario usuario = (Usuario) sessionUsu.getAttribute("Usuario");
        
    Format frm = new Format();
        
//    if(usuario != null ){
%>
<body>


    <jsp:include page="topo.jsp"/>

    <div class="container" >
    <br>
        <div class="panel panel-default conta">
            <div class="panel-heading ">
                <h4 class="panel-title">
                    <a class="accordion-toggle " data-toggle="collapse" data-parent="#accordion">
                        
                    </a>
                    <button type="button" onclick="mostramodal()" class="btn btn-primary btn-novo">Novo</button>
                </h4>
            </div>
            <div class="panel-body">

                <input class="form-control" type="text" name="usuario" placeholder="Busca por nome / CPF">
                <br>    
                <table class="table table-bordered table-striped" aria-describedby="dataTable1_info">
                    <thead>
                        <tr>
                            <th>
                                Numero
                            </th>                        
                            <th>
                                Nome  
                            </th>
                            <th>
                                RG
                            </th>
                            <th>
                                CPF
                            </th>
                            <th>
                                Status
                            </th>
                            <th>
                                Opções
                            </th>
                        </tr>                 
                    </thead>
                            
                    <tbody role="alert" aria-live="polite" aria-relevant="all" id="conteudo">
                        <tr>
                            <td>001</td>
                            <td>Allex</td>
                            <td>448456</td>
                            <td>111111</td>
                            <td>Inativo</td>
                            <td><button type="button" class="btn btn-warning" onclick="mostramodal1()">Relatório</button>&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-success"  onclick="mostramodal();">Editar</button></td>
                        </tr>
                        <tr>
                            <td>002</td>
                            <td>Dráuzio</td>
                            <td>000000</td>
                            <td>2222222</td>
                            <td>Inativo</td>
                            <td><button type="button" class="btn btn-warning" onclick="mostramodal1()">Relatório</button>&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-success " onclick="mostramodal2();">Editar</button></td>
                        </tr>
                    </tbody>
                </table>
                            
                  
            </div>  
        </div>  

    </div>

</body>
</html>



<!-- Modal Novo -->

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Novo</h4>
            </div>
            <div class="modal-body">
                

                <div class='row'>
                    <div class='col-md-8 col-md-offset-3'>
                        <br>
                        <div class="cel1">
                            <label for="cod_analise">Nome</label>&nbsp;&nbsp;&nbsp;&nbsp;
                            <input class="nome" type="text" name="data"/>
                        </div><br>
                        <div class="cel1">
                            <label for="cod_analise">RG</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input class="rg" type="text" name="data"/>
                        </div><br>
                        <div class="cel1">
                            <label for="cod_analise">CPF</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input class="cpf" type="text" name="data"/>
                        </div><br>
                        <br>

                        
                    </div>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                <button type="button" onclick='#' class="btn btn-primary">Cadastrar</button>
            </div>
        </div>
    </div>
</div>



<!-- Modal Relatório -->

<div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Relatório</h4>
            </div>
            <div class="modal-body">
                

                <div class='row'>
                    
                    <div class='col-md-8 col-md-offset-3'>
                        <br>                    
                        <div class="cel1">
                            <label for="cod_analise">Nome</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input class="nome" type="text" name="data"/>
                        </div><br>

                        <div class="cel1">
                            <label for="cod_analise">CPF</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input class="cpf" type="text" name="data"/>
                        </div><br>

                        <div class="cel1">
                            <label for="cod_analise">Vezes Ativo</label>&nbsp;&nbsp;&nbsp;&nbsp;
                            <input class="nome" type="text" name="data"/>
                        </div><br>

                        <div class="cel1">
                            <label for="cod_analise">Status Atual</label>&nbsp;&nbsp;&nbsp;
                            <input class="nome" type="text" name="data"/>
                        </div><br>
                    </div>    
                        <div class='col-md-12'>
                        <u>Histórico</u><br><br>

                
                        <table class="table table-bordered table-striped" aria-describedby="dataTable1_info">
                            <thead>
                                <tr>
                                    <th>
                                        Numero
                                    </th>                        
                                    <th>
                                        Data-Ativo  
                                    </th>
                                    <th>
                                        Data-Inativo 
                                    </th>
                                    <th>
                                        Empresa
                                    </th>
                                    
                                </tr>                 
                            </thead>
                                    
                            <tbody role="alert" aria-live="polite" aria-relevant="all" id="conteudo">
                                
                                
                                <tr>
                                    <td>001</td>
                                    <td>04/10/2015</td>
                                    <td>02/03/2016</td>
                                    <td>Seila 1</td>
                                    
                                </tr>
                                <tr>
                                    <td>002</td>
                                    <td>07/04/2016</td>
                                    <td>02/06/2016</td>
                                    <td>Seila 2</td>
                                    
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                <button type="button" onclick='#' class="btn btn-primary">Imprimir</button>
            </div>
        </div>
    </div>
</div>


<!-- Modal Editar -->

<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Novo</h4>
            </div>
            <div class="modal-body">
                

                <div class='row'>
                    <div class='col-md-8 col-md-offset-3'>
                        <br>
                        <div class="cel1">
                            <label for="cod_analise">Nome</label>&nbsp;&nbsp;&nbsp;&nbsp;
                            <input class="nome" type="text" name="data"/>
                        </div><br>
                        <div class="cel1">
                            <label for="cod_analise">RG</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input class="rg" type="text" name="data"/>
                        </div><br>
                        <div class="cel1">
                            <label for="cod_analise">CPF</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input class="cpf" type="text" name="data"/>
                        </div><br>

                        <label><input type="radio" name="optradio"> Ativo</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <label><input type="radio" name="optradio">  Inativo</label>
                    </div>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                <button type="button" onclick='#' class="btn btn-primary">Salvar</button>
            </div>
        </div>
    </div>
</div>
