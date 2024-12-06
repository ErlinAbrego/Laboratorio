<?php

namespace Controllers\Checkout;

use Controllers\PublicController;

class Accept extends PublicController
{
    public function run(): void
    {
        $dataview = array();
        $token = $_GET["token"] ?: "";
        $session_token = $_SESSION["orderid"] ?: "";
        $defaultPrecio = 100; // Precio predeterminado en caso de no extraer
        $defaultImpuesto = 15; // Impuesto predeterminado

        // Verificar si el token de la URL coincide con el de la sesión
        if ($token !== "" && $token == $session_token) {
            // Capturar el pedido de PayPal
            $PayPalRestApi = new \Utilities\PayPal\PayPalRestApi(
                \Utilities\Context::getContextByKey("PAYPAL_CLIENT_ID"),
                \Utilities\Context::getContextByKey("PAYPAL_CLIENT_SECRET")
            );
            $result = $PayPalRestApi->captureOrder($session_token);

            // Si la captura fue exitosa
            if (isset($result->status) && $result->status == "COMPLETED") {
                // Obtener los detalles del pedido de PayPal
                $buyerName = $result->payer->name->full_name ?? 'Desconocido';
                $buyerEmail = $result->payer->email_address ?? 'email@dominio.com';
                $buyerCity = $result->payer->address->city ?? 'Desconocida';
                $buyerCountry = $result->payer->address->country_code ?? 'Desconocido';

                // Obtener los detalles de la cita
                $citaID = $_POST['citaID'] ?? null;
                $citaDetails = \Dao\Citas\Citas::getCitaDetailsById($citaID);

                $precioUnitario = $citaDetails['Precio'] ?? $defaultPrecio; // Usa precio predeterminado si no está definido
                $impuesto = $citaDetails['Impuesto'] ?? $defaultImpuesto; // Usa impuesto predeterminado si no está definido

                // Generar la factura en HTML con los datos del comprador
                $dataview['factura'] = $this->generateInvoice($citaDetails, $precioUnitario, $impuesto, $session_token, $buyerName, $buyerEmail, $buyerCity, $buyerCountry);
            } else {
                $dataview["orderjson"] = "Error al procesar el pago en PayPal.";
            }
        } else {
            $dataview["orderjson"] = "No Order Available!!!";
        }

        \Views\Renderer::render("paypal/accept", $dataview);
    }

    private function generateInvoice($citaDetails, $precioUnitario, $impuesto, $orderID, $buyerName, $buyerEmail, $buyerCity, $buyerCountry)
    {
        // Si los detalles de la cita son correctos
        $examenNombre = $citaDetails[''] ?? 'Desconocido';
        $total = $precioUnitario + $impuesto;

        // Factura en HTML con los detalles del comprador y la cita
        $invoiceHtml = "
        <h2>Factura de Compra</h2>
        <p><strong>Orden ID:</strong> $orderID</p>
        <p><strong>Comprador:</strong> $buyerName</p>
        <p><strong>Email:</strong> $buyerEmail</p>
        <p><strong>Ciudad:</strong> $buyerCity</p>
        <p><strong>País:</strong> $buyerCountry</p>
        <p><strong>Tipo de Examen:</strong> $examenNombre</p>
        <p><strong>Precio Unitario:</strong> \$ $precioUnitario</p>
        <p><strong>Impuesto:</strong> \$ $impuesto</p>
        <p><strong>Total:</strong> \$ $total</p>
        <hr>
        <p><strong>Gracias por tu compra. ¡Nos vemos pronto!</strong></p>";

        return $invoiceHtml;
    }
}
