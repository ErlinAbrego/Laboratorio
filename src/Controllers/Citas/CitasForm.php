<?php

namespace Controllers\Citas;

use Controllers\PrivateController;
use Utilities\Site;
use Views\Renderer;
use Dao\Citas\Citas;
use Utilities\Validators;

class CitasForm extends PrivateController
{
    private $viewData = [];
    private $modeDscArr = [
        "DSP" => "Detalle de Cita (%s)",
        "INS" => "Nueva Cita",
        "UPD" => "Editar Cita (%s)",
        "DEL" => "Eliminar Cita (%s)"
    ];
    private $mode = '';
    private $errors = [];
    private $xssToken = '';

    private $cita = [
        "CitaID" => 0,
        "usercod" => '',
        "FechaCita" => '',
        "ExamenID" => 0,
        "EstadoCita" => 'Pendiente',
        "FechaCreacion" => '',
        "FechaModificacion" => '',
        "telefono" => '',
        "email" => ''
    ];

    // Agregar un error al arreglo de errores
    private function addError($error, $context = 'global')
    {
        if (!isset($this->errors[$context])) {
            $this->errors[$context] = [];
        }
        $this->errors[$context][] = $error;
    }

    // Método principal para ejecutar la lógica
    public function run(): void
    {
        $this->inicializarForm();
        if ($this->isPostBack()) {
            $this->cargarDatosDelFormulario();
            if ($this->validarDatos()) {
                $this->procesarAccion();
            }
        }
        $this->generarViewData();
        Renderer::render('citas/citas_form', $this->viewData);
    }

    // Inicializar formulario basado en el modo
    private function inicializarForm()
    {
        if (isset($_GET["mode"]) && isset($this->modeDscArr[$_GET["mode"]])) {
            $this->mode = $_GET["mode"];
            if ($this->mode !== 'DSP') {
                if (!$this->isFeatureAutorized("citas_" . $this->mode . "_enabled")) {
                    Site::redirectToWithMsg("index.php?page=Citas-CitasList", "Acción no autorizada.");
                }
            }
        } else {
            Site::redirectToWithMsg("index.php?page=Citas-CitasList", "Modo inválido.");
            die();
        }

        if ($this->mode !== 'INS' && isset($_GET["CitaID"])) {
            $this->cita["CitaID"] = $_GET["CitaID"];
            $this->cargarDatosCita();
        }
    }

    // Cargar los datos de la cita desde la base de datos
    private function cargarDatosCita()
    {
        $tmpCita = Citas::obtenerCitaPorId($this->cita["CitaID"]);
        if ($tmpCita) {
            $this->cita = $tmpCita;
        } else {
            Site::redirectToWithMsg("index.php?page=Citas-CitasList", "No se encontró la cita.");
        }
    }

    // Cargar los datos del formulario POST
    private function cargarDatosDelFormulario()
    {
        $this->cita["usercod"] = $_POST["usercod"];
        $this->cita["FechaCita"] = $_POST["FechaCita"];
        $this->cita["ExamenID"] = $_POST["ExamenID"];
        $this->cita["EstadoCita"] = $_POST["EstadoCita"];
        $this->cita["FechaCreacion"] = $_POST["FechaCreacion"];
        $this->cita["FechaModificacion"] = $_POST["FechaModificacion"];
        $this->cita["telefono"] = $_POST["telefono"];
        $this->cita["email"] = $_POST["email"];
        $this->xssToken = $_POST["xssToken"];
    }

    // Validar los datos del formulario
    private function validarDatos()
    {
        if (!$this->validarAntiXSSToken()) {
            Site::redirectToWithMsg("index.php?page=Citas-CitasList", "Error de seguridad al procesar la solicitud.");
        }

        if (Validators::IsEmpty($this->cita["usercod"])) {
            $this->addError("El código de usuario no puede estar vacío.", "usercod");
        }

        if (Validators::IsEmpty($this->cita["FechaCita"])) {
            $this->addError("La fecha de la cita no puede estar vacía.", "FechaCita");
        }

        if (Validators::IsEmpty($this->cita["ExamenID"])) {
            $this->addError("El ID del examen no puede estar vacío.", "ExamenID");
        }

        if (!Validators::IsEmpty($this->cita["email"]) && !Validators::IsValidEmail($this->cita["email"])) {
            $this->addError("El formato del correo electrónico es inválido.", "email");
        }

        return count($this->errors) === 0;
    }

    // Procesar la acción según el modo
    private function procesarAccion()
    {
        switch ($this->mode) {
            case 'INS':
                $result = Citas::agregarCita($this->cita);
                $this->redirectAfterAction($result, "registrada");
                break;
            case 'UPD':
                $result = Citas::actualizarCita($this->cita);
                $this->redirectAfterAction($result, "actualizada");
                break;
            case 'DEL':
                $result = Citas::eliminarCita($this->cita['CitaID']);
                $this->redirectAfterAction($result, "eliminada");
                break;
        }
    }

    // Redirigir después de una acción (insertar, actualizar, eliminar)
    private function redirectAfterAction($result, $accion)
    {
        if ($result) {
            Site::redirectToWithMsg("index.php?page=Citas-CitasList", "Cita $accion satisfactoriamente.");
        } else {
            Site::redirectToWithMsg("index.php?page=Citas-CitasList", "Hubo un error al $accion la cita.");
        }
    }

    // Generar el token anti-XSS
    private function generateAntiXSSToken()
    {
        $_SESSION["Citas_Form_XSST"] = hash("sha256", time() . "Citas_Form");
        $this->xssToken = $_SESSION["Citas_Form_XSST"];
    }

    // Validar el token anti-XSS
    private function validarAntiXSSToken()
    {
        return isset($_SESSION["Citas_Form_XSST"]) && $this->xssToken === $_SESSION["Citas_Form_XSST"];
    }

    // Preparar los datos para la vista
    private function generarViewData()
    {
        $this->viewData["mode"] = $this->mode;
        $this->viewData["modes_dsc"] = sprintf($this->modeDscArr[$this->mode], $this->cita["CitaID"]);
        $this->viewData["cita"] = $this->cita;
        $this->viewData["readonly"] = ($this->viewData["mode"] === 'DEL' || $this->viewData["mode"] === 'DSP') ? 'readonly' : '';
        foreach ($this->errors as $context => $errores) {
            $this->viewData[$context . '_error'] = $errores;
            $this->viewData[$context . '_haserror'] = count($errores) > 0;
        }
        $this->viewData["showConfirm"] = ($this->viewData["mode"] !== 'DSP');
        $this->generateAntiXSSToken();
        $this->viewData["xssToken"] = $this->xssToken;
    }
}
