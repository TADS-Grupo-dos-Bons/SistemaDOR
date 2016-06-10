    <%-- 
        Document   : index.jsp
        Created on : 07/05/2016, 18:18:07
        Author     : allex
    --%>

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
        <script src="js/jquery.mask.js"></script>
        <script src="js/bootstrap-switch.js"></script>
        <script type="text/javascript">
            function mostramodal(){
                $('#myModal').modal('show');
            }

            $(document).ready(function(){
                $('.cpfmascara').mask("999.999.999-99");
                $(".telefonemask").mask("(99) 9999-9999");
            });

        </script>
    </head>
    <body class="login">

        <div class="login-container">
            <h2>DOR</h2>
            <br>
            <form action="ProcessaLogin" method="post">
                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"><i>Usuario</i></span><input class="form-control" type="text" name="usuario" placeholder="Usuario">
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"><i>Senha</i></span><input class="form-control" type="password" name="senha" placeholder="Senha">
                    </div>

                </div>

                <button class="btn btn-block btn-large btn-primary login-submit" >Acessar</button>
                <br>

          </form>
        </div>

    </body>
    </html>


    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Cadastro de Usuario</h4>
                </div>
                <div class="modal-body">
                    <form action="#cadastro......." method="post">
                        <div class="form-group">
                            <div class='row'>

                                <div class='col-md-4'>
                                    <u>Dados Pessoais</u><br><br>
                                    <label>Nome:<br></label><input class="nome" type="text" name="usuario"><br><br>
                                    <label>CPF:<br></label><input class="cpf cpfmascara" type="text" name="cpf"><br><br>
                                    <u>Empresa</u><br><br>
                                    <label>Cargo:<br></label><input class="logradouro" type="text" name="logradouro"><br><br>
                                    <u>Contato</u><br><br>
                                    <label>Telefone Comercial:<br></label><input class="bairro telefonemask" type="text" name="bairro"><br><br>
                                    <label>Senha:<br></label><input class="senha" type="text" name="senha"><br><br>

                                </div>
                                <div class='col-md-4'>
                                    <br><br><label>Sobrenome:<br></label><input class="sobrenome" type="text" name="sobrenome"><br><br>
                                    <label>Data de Nascimento:<br></label><input class="dt-nasc" type="text" name="dt-nasc"><br><br><br><br>
                                    <label>Setor:<br></label><input class="numero" type="text" name="numero"><br><br><br><br>
                                    <label>Email:<br></label><input class="estado" type="text" name="estado"><br><br>
                                    <label>Confirma Senha:<br></label><input class="conf-senha" type="text" name="conf-senha"><br><br>

                                </div>
                                <div class='col-md-4'>
                                    <br><br><label>RG:<br></label><input class="rg" type="text" name="rg"><br><br>

                                </div>
                            </div>
                        </div>

                    </form>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                    <button type="button" onclick='#' class="btn btn-primary">Cadastrar</button>
                </div>
            </div>
        </div>
    </div>
