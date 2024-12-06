<?php

namespace Dao\Citas;

use Dao\Table;

class Citas extends Table
{
    public static function obtenerCitas()
    {
        $sqlstr = 'SELECT * FROM citas;';
        return self::obtenerRegistros($sqlstr, []);
    }

    public static function obtenerCitaPorId($id)
    {
        $sqlstr = 'SELECT * FROM citas WHERE CitaID = :CitaID;';
        return self::obtenerUnRegistro($sqlstr, ["CitaID" => $id]);
    }

    public static function obtenerCitasPorUsuario($usercod)
    {
        $sqlstr = 'SELECT * FROM citas WHERE usercod = :usercod;';
        return self::obtenerRegistros($sqlstr, ["usercod" => $usercod]);
    }

    public static function getCitaDetailsById($citaID)
    {
        $sql = "SELECT 
                c.CitaID,
                c.usercod, 
                c.FechaCita,
                c.ExamenID, 
                c.EstadoCita, 
                c.telefono, 
                c.email, 
                te.Nombre AS TipoExamen, 
                te.Precio
            FROM Citas c
            INNER JOIN TiposDeExamenes te ON c.ExamenID = te.ExamenID
            WHERE c.CitaID = :citaID;";
        return self::obtenerUnRegistro($sql, array("citaID" => $citaID));
    }

    public static function agregarCita($cita)
    {
        try {
            // Validación de datos
            if (empty($cita['usercod']) || empty($cita['FechaCita']) || empty($cita['ExamenID']) || empty($cita['EstadoCita'])) {
                throw new \Exception("Faltan campos obligatorios en la cita");
            }

            // Eliminar campos automáticamente gestionados
            unset($cita['CitaID'], $cita['FechaCreacion'], $cita['FechaModificacion']);

            $sqlstr = 'INSERT INTO Citas (usercod, FechaCita, ExamenID, EstadoCita, telefono, email) 
                        VALUES (:usercod, :FechaCita, :ExamenID, :EstadoCita, :telefono, :email);';
            return self::executeNonQuery($sqlstr, $cita);
        } catch (\Exception $e) {
            error_log("Error al agregar cita: " . $e->getMessage());
            return false;
        }
    }

    public static function actualizarCita($cita)
    {
        $sqlstr = 'UPDATE Citas SET usercod = :usercod, 
                    FechaCita = :FechaCita, 
                    ExamenID = :ExamenID, 
                    EstadoCita = :EstadoCita, 
                    FechaCreacion = :FechaCreacion, 
                    FechaModificacion = :FechaModificacion,
                    telefono = :telefono,
                    email = :email
                    WHERE CitaID = :CitaID;';
        return self::executeNonQuery($sqlstr, $cita);
    }

    public static function eliminarCita($CitaID)
    {
        try {
            // Validación de la existencia de la cita
            if (empty($CitaID)) {
                throw new \Exception("ID de cita no válido");
            }

            $sqlstr = 'DELETE FROM citas WHERE CitaID = :CitaID;';
            return self::executeNonQuery($sqlstr, ["CitaID" => $CitaID]);
        } catch (\Exception $e) {
            error_log("Error al eliminar cita: " . $e->getMessage());
            return false;
        }
    }

    public static function confirmarCita($CitaID)
    {
        try {
            // Validación de la existencia de la cita
            if (empty($CitaID)) {
                throw new \Exception("ID de cita no válido");
            }

            $sqlstr = 'UPDATE citas SET EstadoCita = "Confirmada" WHERE CitaID = :CitaID;';
            return self::executeNonQuery($sqlstr, ["CitaID" => $CitaID]);
        } catch (\Exception $e) {
            error_log("Error al confirmar cita: " . $e->getMessage());
            return false;
        }
    }
}
