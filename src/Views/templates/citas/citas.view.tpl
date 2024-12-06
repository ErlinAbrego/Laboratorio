<link rel="stylesheet" href="public/css/cards.css">
<link rel="stylesheet" href="public/css/butons.css">
<h1>Listado de Citas</h1>
<form method="get" action="index.php" class="buscar-form">
    <input type="hidden" name="page" value="Citas-CitasList">
    <div>
        {{with login}}
        <span class="usercod">{{usercod}} </span>
        {{endwith login}}
        <label for="usercod">Buscar por Código de Usuario:</label>
        <input type="text" name="usercod" id="usercod" value="{{usercod}}">
        <button type="submit">Buscar <i class="fas fa-search"></i></button>
        {{if ~MostrarDatos_enable}}
        <button type="submit" name="mostrar_todas" class="mostrar-todas-citas-btn">Mostrar Todas las Citas</button>
        {{endif ~MostrarDatos_enable}}
    </div>
</form>

<section class="wwerl">
    <table>
        <thead>
            <tr>
                <th>Código de la Cita</th>
                <th>Código de Usuario</th>
                <th>Fecha de la Cita</th>
                <th>Código de Examen</th>
                <th>Estado de la Cita</th>
                {{if FechaCreacion_enable}}
                <th>Fecha Creacion</th>
                {{endif FechaCreacion_enable}}
                <th>Fecha de Modificación</th>
                <th><a href="index.php?page=Citas-CitasForm&mode=INS"><i class="fa-solid fa-suitcase-medical"
                            style="color: #fff;"></i></a></th>
            </tr>
        </thead>
        <tbody>
            {{foreach citas}}
            <tr>
                <td>{{CitaID}}</td>
                <td>{{usercod}}</td>
                <td>{{FechaCita}}</td>
                <td>{{ExamenID}}</td>
                <td>{{EstadoCita}}</td>
                {{if ~FechaCreacion_enable}}
                <td>{{citas_FechaCreacion}}</td>
                {{endif ~FechaCreacion_enable}}
                <td>{{FechaModificacion}}</td>
                <td style="display:flex; gap:1rem; justify-content:center; align-items:center">
                    {{if ~UPD_enable}}
                    <a href="index.php?page=Citas-CitasForm&mode=UPD&CitaID={{CitaID}}"><i class="fas fa-user-pen"
                            style="color: #16a34a;"></i></a>
                    {{endif ~UPD_enable}}
                    {{if ~DEL_enable}}
                    <a href="index.php?page=Citas-CitasForm&mode=DEL&CitaID={{CitaID}}"><i class="fas fa-trash-can"
                            style="color: #16a34a;"></i></a>
                    {{endif ~DEL_enable}}
                    <a href="index.php?page=Citas-CitasForm&mode=DSP&CitaID={{CitaID}}"><i class="fas fa-search"
                            style="color: #16a34a;"></i></a>

                    {{if ~Confirmar_enable}}
                    <form method="POST" action="index.php?page=Citas-CitasList">
                        <input type="hidden" name="citaID" value="{{CitaID}}" />
                        <button type="submit" name="confirmar" class="confirmar-cita-btn">Confirmar</button>
                    </form>
                    {{endif ~Confirmar_enable}}

                    <form method="POST" action="index.php?page=Checkout-Checkout">
                        <input type="hidden" name="citaID" value="{{CitaID}}" />
                        <input type="hidden" name="usercod" value="{{usercod}}" />
                        <input type="hidden" name="TipoExamen" value="{{TipoExamen}}" />
                        <button type="submit" name="pagar" class="confirmar-cita-btn"
                            style="background: none; border: none; padding: 0;">
                            <i class="fa-brands fa-cc-paypal" style="color: #003087; font-size: 50px;"></i>
                        </button>
                    </form>
                </td>
            </tr>
            {{endfor citas}}
        </tbody>
    </table>
</section>