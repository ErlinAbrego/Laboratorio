<?php

namespace Utilities;

use FPDF;

class InvoiceGenerator
{
    public static function generateInvoice(array $orderData, string $outputFilePath)
    {
        $pdf = new FPDF();
        $pdf->AddPage();
        $pdf->SetFont('Arial', 'B', 16);

        // Header
        $pdf->Cell(190, 10, 'Invoice', 0, 1, 'C');
        $pdf->Ln(10);

        // Order Details
        $pdf->SetFont('Arial', '', 12);
        $pdf->Cell(190, 10, 'Order ID: ' . $orderData['id'], 0, 1);
        $pdf->Cell(190, 10, 'Buyer: ' . $orderData['payer']['name']['given_name'] . ' ' . $orderData['payer']['name']['surname'], 0, 1);
        $pdf->Cell(190, 10, 'Email: ' . $orderData['payer']['email_address'], 0, 1);
        $pdf->Ln(10);

        // Items
        $pdf->SetFont('Arial', 'B', 12);
        $pdf->Cell(80, 10, 'Item Name', 1);
        $pdf->Cell(30, 10, 'Quantity', 1);
        $pdf->Cell(40, 10, 'Price', 1);
        $pdf->Cell(40, 10, 'Total', 1);
        $pdf->Ln();

        $pdf->SetFont('Arial', '', 12);
        foreach ($orderData['purchase_units'][0]['items'] as $item) {
            $pdf->Cell(80, 10, $item['name'], 1);
            $pdf->Cell(30, 10, $item['quantity'], 1);
            $pdf->Cell(40, 10, $item['unit_amount']['value'] . ' ' . $item['unit_amount']['currency_code'], 1);
            $pdf->Cell(40, 10, ($item['unit_amount']['value'] * $item['quantity']) . ' ' . $item['unit_amount']['currency_code'], 1);
            $pdf->Ln();
        }

        // Total
        $pdf->Ln(5);
        $pdf->SetFont('Arial', 'B', 12);
        $pdf->Cell(190, 10, 'Total: ' . $orderData['purchase_units'][0]['amount']['value'] . ' ' . $orderData['purchase_units'][0]['amount']['currency_code'], 0, 1, 'R');

        // Save to file
        $pdf->Output('F', $outputFilePath);
    }
}
