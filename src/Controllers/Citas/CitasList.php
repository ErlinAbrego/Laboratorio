<?php

namespace Controllers\Citas;

use Controllers\PrivateController;
use Dao\Citas\Citas;
use Views\Renderer;

class CitasList extends PrivateController
{
    public function run(): void
    {
        // Verificar si se ha enviado una solicitud para confirmar una cita
        if (isset($_POST['confirmar'])) {
            $citaID = $_POST['citaID'];  // Asumiendo que el ID de la cita viene en el POST
            Citas::confirmarCita($citaID);
        }

        $usercod = $_GET['usercod'] ?? '';
        $mostrarTodas = isset($_GET['mostrar_todas']);
        $citasDao = [];

        if ($mostrarTodas) {
            $citasDao = Citas::obtenerCitas();
        } elseif (!empty($usercod)) {
            $citasDao = Citas::obtenerCitasPorUsuario($usercod);
        }

        foreach ($citasDao as &$cita) {
            $cita['EstadoCita'] = [
                "Pendiente" => "Pendiente",
                "Confirmada" => "Confirmada",
                "Cancelada" => "Cancelada",
                "Realizada" => "Realizada"
            ][$cita['EstadoCita']] ?? "Desconocido";
        }

        $viewData = [
            "citas" => $citasDao,
            "INS_enable" => $this->isFeatureAutorized('citas_INS_enabled'),
            "UPD_enable" => $this->isFeatureAutorized('citas_UPD_enabled'),
            "DEL_enable" => $this->isFeatureAutorized('citas_DEL_enabled'),
            "Confirmar_enable" => $this->isFeatureAutorized('citas_Confirmar_enabled'),
            "MostrarDatos_enable" => $this->isFeatureAutorized('citas_MostrarDatos_enabled'),
            "Pagar_enable" => $this->isFeatureAutorized('citas_Pagar_enabled'),
            "FechaCreacion_enable" => $this->isFeatureAutorized('citas_fechacreacion_enabled'),
            "usercod" => $usercod
        ];
        Renderer::render('citas/citas', $viewData);
    }
}
