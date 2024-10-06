<?php

namespace App\Models;

use Illuminate\Support\Facades\DB;
use App\Http\Controllers\API\PermissionController;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Lang;


class OrderLog extends BaseModel
{
    protected $fillable = [
        'id',
        'date',
        'order_type',
        'sales_note',
        'sub_total',
        'total_tax',
        'all_discount',
        'total',
        'due_amount', 'type', 'profit', 'status', 'branch_id', 'transfer_branch_id', 'table_id', 'created_by', 'returned_invoice', 'return_type', 'customer_id', 'supplier_id', 'invoice_id', 'created_at', 'delivery_or_pickup', 'delivery_or_pickup_date', 'delivery_charges', 'order_status',
        'cart_info'];

    protected $casts = [
        'sub_total' => 'float',
        'total_tax' => 'float',
        'all_discount' => 'float',
        'total' => 'float',
        'due_amount' => 'float',
        'profit' => 'float',
        'branch_id' => 'int',
        'transfer_branch_id' => 'int',
        'table_id' => 'int',
        'created_by' => 'int',
        'customer_id' => 'int',
        'supplier_id' => 'int',
    ];    


    public static function orderCountByOrderInvoiceId($invoiceId)
    {
        return OrderLog::where('invoice_id', '=', $invoiceId)->count();
    }

    
}
