<title>Iniciar Sesión</title>
<link rel="stylesheet" href="public/css/login.css">
<!-- Fondo de video -->
<div class="video-background">
  <video autoplay loop muted>
    <source src="SIA.mp4" type="video/mp4">
    Tu navegador no soporta el elemento de video.
  </video>
</div>

<!-- Contenedor del formulario -->
<div class="container">
  <div class="login-section">
    <div class="form-box login">
      <h2>Iniciar Sesión</h2>
      <form method="post" action="index.php?page=sec_login{{if redirto}}&redirto={{redirto}}{{endif redirto}}">
        <div class="input-box">
          <input type="email" id="txtEmail" name="txtEmail" value="{{txtEmail}}" required>
          <label for="txtEmail">Correo Electrónico</label>
          <span class="icon">📧</span>
          {{if errorEmail}}
          <div class="error">{{errorEmail}}</div>
          {{endif errorEmail}}
        </div>
        <div class="input-box">
          <input type="password" id="txtPswd" name="txtPswd" value="{{txtPswd}}" required>
          <label for="txtPswd">Contraseña</label>
          <span class="icon">🔒</span>
          {{if errorPswd}}
          <div class="error">{{errorPswd}}</div>
          {{endif errorPswd}}
        </div>
        {{if generalError}}
        <div class="error">{{generalError}}</div>
        {{endif generalError}}
        
        <button class="btn" id="btnLogin" type="submit">Iniciar Sesión</button>
        <div class="create-account">
          <p>¿No tienes cuenta? <a href="index.php?page=sec_register">Regístrate aquí</a></p>
        </div>
      </form>
    </div>
  </div>
</div>