<?php
namespace Controllers\Checkout;

use Controllers\PrivateController;

class Checkout extends PrivateController
{
    public function run(): void
    {
        $viewData = array();
        if ($this->isPostBack()) {
            // Datos predeterminados
            $defaultPrecio = 100; // Precio predeterminado en caso de no extraer
            $defaultImpuesto = 15; // Impuesto predeterminado

            // Extraer información de la cita
            $citaID = $_POST['citaID'] ?? null;
            $citaDetails = \Dao\Citas\Citas::getCitaDetailsById($citaID);
            
            $precioUnitario = $citaDetails['Precio'] ?? $defaultPrecio; // Usa precio predeterminado si no está definido
            $impuesto = $citaDetails['Impuesto'] ?? $defaultImpuesto; // Usa impuesto predeterminado si no está definido

            // Crear la orden de PayPal
            $PayPalOrder = new \Utilities\Paypal\PayPalOrder(
                "test" . (time() - 10000000),
                "http://localhost/ww6/mvc_2024/index.php?page=Checkout_Error",
                "http://localhost/ww6/mvc_2024/index.php?page=Checkout_Accept"
            );

            $PayPalOrder->addItem(
                $citaDetails['TipoExamen'] ?? 'Examen Desconocido', // Nombre del examen o por defecto
                "Examen " . ($citaID ?? 'Desconocido'),
                "PRD" . ($citaID ?? '0000'),
                $precioUnitario,
                $impuesto,
                1,
                "DIGITAL_GOODS"
            );

            $PayPalRestApi = new \Utilities\PayPal\PayPalRestApi(
                \Utilities\Context::getContextByKey("PAYPAL_CLIENT_ID"),
                \Utilities\Context::getContextByKey("PAYPAL_CLIENT_SECRET")
            );

            $PayPalRestApi->getAccessToken();
            $response = $PayPalRestApi->createOrder($PayPalOrder);

            if (isset($response->id)) { // Verificar si 'id' está definido
                $_SESSION["orderid"] = $response->id;
                foreach ($response->links as $link) {
                    if ($link->rel == "approve") {
                        // Redirigir a PayPal para aprobar la orden
                        \Utilities\Site::redirectTo($link->href);
                    }
                }
            } else {
                // Manejar el caso donde no se puede crear la orden
                error_log("No se pudo crear la orden en PayPal");
                \Utilities\Site::redirectTo("index.php?page=Checkout_Error");
            }
            die();
        }

        // Si la orden fue aceptada
        if (isset($_GET['page']) && $_GET['page'] == 'Checkout_Accept' && isset($_SESSION['orderid'])) {
            $orderID = $_SESSION['orderid'];

            // Recuperar los detalles de la cita para la factura
            $citaID = $_POST['citaID'] ?? null;
            $citaDetails = \Dao\Citas\Citas::getCitaDetailsById($citaID);
            $precioUnitario = $citaDetails['Precio'] ?? 100;
            $impuesto = $citaDetails['Impuesto'] ?? 15;

            // Generar la factura en HTML
            $viewData['factura'] = $this->generateInvoice($citaDetails, $precioUnitario, $impuesto, $orderID);
        }

        \Views\Renderer::render("paypal/checkout_accept", $viewData);
    }

    private function generateInvoice($citaDetails, $precioUnitario, $impuesto, $orderID)
    {
        $total = $precioUnitario + $impuesto;

        // Factura en HTML
        $invoiceHtml = "
        <h2>Factura de Examen</h2>
        <p><strong>Orden ID:</strong> $orderID</p>
        <p><strong>Tipo de Examen:</strong> {$citaDetails['TipoExamen']}</p>
        <p><strong>Precio Unitario:</strong> \$ $precioUnitario</p>
        <p><strong>Impuesto:</strong> \$ $impuesto</p>
        <p><strong>Total:</strong> \$ $total</p>
        <hr>
        <p><strong>Gracias por tu compra. ¡Nos vemos pronto!</strong></p>";

        return $invoiceHtml;
    }
}
