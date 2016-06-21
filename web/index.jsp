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


