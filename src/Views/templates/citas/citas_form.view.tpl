<link rel="stylesheet" href="public/css/styles.css">
<h1>{{modes_dsc}}</h1>
<section>
    <form action="index.php?page=Citas-CitasForm&mode={{mode}}&CitaID={{CitaID}}" method="post">
    {{with cita}}
    <div>
        <label for="CitaID">Cita ID</label>
        <input type="text" name="CitaID" id="CitaID" value="{{CitaID}}" readonly>
        <input type="hidden" name="xssToken" value="{{~xssToken}}">
    </div>
    <div>
        <label for="usercod">Código Usuario</label>
        <input type="text" name="usercod" id="usercod" value="{{usercod}}" {{~readonly}}>
        {{if ~usercod_haserror}}
        <div class="error">
            <ul>
                {{foreach ~usercod_error}}
                <li>{{this}}</li>
                {{endfor ~usercod_error}}
            </ul>
        </div>
        {{endif ~usercod_haserror}}
    </div>
    <div>
        <label for="FechaCita">Fecha de la Cita</label>
        <input type="datetime-local" name="FechaCita" id="FechaCita" value="{{FechaCita}}" {{~readonly}}>
        {{if ~FechaCita_haserror}}
        <div class="error">
            <ul>
                {{foreach ~FechaCita_error}}
                <li>{{this}}</li>
                {{endfor ~FechaCita_error}}
            </ul>
        </div>
        {{endif ~FechaCita_haserror}}
    </div>
    <div>
        <label for="ExamenID">ID de los Exámenes</label>
        <input type="text" name="ExamenID" id="ExamenID" value="{{ExamenID}}" {{~readonly}}>
        {{if ~ExamenID_haserror}}
        <div class="error">
            <ul>
                {{foreach ~ExamenID_error}}
                <li>{{this}}</li>
                {{endfor ~ExamenID_error}}
            </ul>
        </div>
        {{endif ~ExamenID_haserror}}
    </div>
    <div>
        <label for="EstadoCita">Estado de la Cita</label>
        <input type="text" name="EstadoCita" id="EstadoCita" value="{{EstadoCita}}" readonly>
        {{if ~EstadoCita_haserror}}
        <div class="error">
            <ul>
                {{foreach ~EstadoCita_error}}
                <li>{{this}}</li>
                {{endfor ~EstadoCita_error}}
            </ul>
        </div>
        {{endif ~EstadoCita_haserror}}
    </div>
    <div>
        <label for="FechaCreacion">Fecha de Creación</label>
        <input type="datetime-local" name="FechaCreacion" id="FechaCreacion" value="{{FechaCreacion}}" {{~readonly}}>
        {{if ~FechaCreacion_haserror}}
        <div class="error">
            <ul>
                {{foreach ~FechaCreacion_error}}
                <li>{{this}}</li>
                {{endfor ~FechaCreacion_error}}
            </ul>
        </div>
        {{endif ~FechaCreacion_haserror}}
    </div>
    <div>
        <label for="FechaModificacion">Fecha de Modificación</label>
        <input type="datetime-local" name="FechaModificacion" id="FechaModificacion" value="{{FechaModificacion}}"
            {{~readonly}}>
        {{if ~FechaModificacion_haserror}}
        <div class="error">
            <ul>
                {{foreach ~FechaModificacion_error}}
                <li>{{this}}</li>
                {{endfor ~FechaModificacion_error}}
            </ul>
        </div>
        {{endif ~FechaModificacion_haserror}}
    </div>
    <div>
        <label for="telefono">Teléfono</label>
        <input type="text" name="telefono" id="telefono" value="{{telefono}}" {{~readonly}}>
        {{if ~telefono_haserror}}
        <div class="error">
            <ul>
                {{foreach ~telefono_error}}
                <li>{{this}}</li>
                {{endfor ~telefono_error}}
            </ul>
        </div>
        {{endif ~telefono_haserror}}
    </div>
    <div>
        <label for="email">Email</label>
        <input type="text" name="email" id="email" value="{{email}}" {{~readonly}}>
        {{if ~email_haserror}}
        <div class="error">
            <ul>
                {{foreach ~email_error}}
                <li>{{this}}</li>
                {{endfor ~email_error}}
            </ul>
        </div>
        {{endif ~email_haserror}}
    </div>
    <div>
        {{if ~showConfirm}}
        <button type="submit">Confirmar</button>&nbsp;
        {{endif ~showConfirm}}
        <button id="btnCancelar" class="btn">Cancelar</button>
    </div>
    {{if ~global_haserror}}
    <div class="error">
        <ul>
            {{foreach ~global_error}}
            <li>{{this}}</li>
            {{endfor ~global_error}}
        </ul>
    </div>
    {{endif ~global_haserror}}
    {{endwith cita}}
</form>

</section>
<script>
    document.addEventListener("DOMContentLoaded", () => {
        const btnCancelar = document.getElementById("btnCancelar");
        btnCancelar.addEventListener("click", (e) => {
            e.preventDefault();
            e.stopPropagation();
            window.location.assign("index.php?page=Citas-CitasList");
        });
    });
</script>