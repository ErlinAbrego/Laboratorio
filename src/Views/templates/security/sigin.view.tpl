<link rel="stylesheet" href="public/css/login.css">
<section class="fullCenter">
  <!-- Fondo de video -->
  <div class="video-background">
    <video autoplay loop muted>
      <source src="SIA.mp4" type="video/mp4">
      Tu navegador no soporta el elemento de video.
    </video>
  </div>

  <div class="container">
    <div class="login-section">
      <div class="form-box login">
        <h2>Crea tu cuenta</h2>
        <form method="post" action="index.php?page=sec_register">
          <div class="input-box">
            <label for="txtEmail">Correo Electrónico</label>
            <span class="icon">📧</span>
            <input class="form-input" type="email" id="txtEmail" name="txtEmail" value="{{txtEmail}}" />
            {{if errorEmail}}
            <div class="error-message">{{errorEmail}}</div>
            {{endif errorEmail}}
          </div>
          <div class="input-box">
            <label for="txtPswd">Contraseña</label>
            <span class="icon">🔒</span>
            <input class="form-input" type="password" id="txtPswd" name="txtPswd" value="{{txtPswd}}" />
            {{if errorPswd}}
            <div class="error-message">{{errorPswd}}</div>
            {{endif errorPswd}}
          </div>
          <div class="form-actions">
            <button class="btn" id="btnLogin" type="submit">Crear Cuenta</button>
          </div>
          <div class="create-account">
  <p>¿Ya tienes cuenta?<a href="index.php?page=sec_login">Iniciar sesión</a></p>
</div>

        </form>
      </div>
    </div>
  </div>
</section>