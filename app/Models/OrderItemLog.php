<?php

namespace App\Models;

use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\API\PermissionController;
use Illuminate\Support\Facades\DB;

class OrderItemLog extends BaseModel
{

    protected $fillable = ['id','product_id', 'variant_id', 'quantity', 'price', 'discount', 'tax_id', 'order_id', 'adjust_stock_type_id', 'type', 'sub_total', 'product_custom_details'];

    protected $casts = [
        'discount' => 'float',
        'price' => 'float',
        'sub_total' => 'float',
        'product_id' => 'int',
        'variant_id' => 'int',
        'tax_id' => 'int',
        'order_id' => 'int',
        'adjust_stock_type_id' => 'int',
    ];

    public static function getOrderAuditTrail($order_id)
    {
        $order = Order::getOldOrderDetails($order_id);
        
        $orderIds = OrderLog::where('invoice_id', '=', $order['invoice_id'])->pluck('id')->toArray();
        
        if(count($orderIds) > 0)
        {
            
            $query = OrderItemLog::query()->join('order_logs', 'order_logs.id', '=', 'order_item_logs.order_id')
            ->join('products', 'products.id', '=', 'order_item_logs.product_id')
            ->join('users', 'users.id', '=', 'order_logs.created_by')
            // ->leftJoin('taxes', 'taxes.id', '=', 'order_item_logs.tax_id')
            // ->leftJoin('customers', 'customers.id', '=', 'order_logs.customer_id')
            // ->leftJoin('branches', 'branches.id', 'order_logs.transfer_branch_id')
            // ->leftJoin('product_categories', 'product_categories.id', '=', 'products.category_id')
            // ->leftJoin('product_brands', 'product_brands.id', '=', 'products.brand_id')
            ->select(
                'order_item_logs.id',
                // 'branches.name as transfer_branch_name',
                 DB::raw('DATE_FORMAT(order_logs.date,"%m/%d/%Y") AS date '),
                // 'order_logs.type',
                // 'order_logs.sub_total',
                // 'order_logs.total_tax as tax',
                // 'order_logs.total',
                // 'order_logs.invoice_id',
                // 'order_logs.due_amount',
                'order_item_logs.product_custom_details as product_variations',
                'order_logs.order_status',
                // 'products.imageURL',
                'products.title',
                // 'product_categories.name as cat_name',
                // 'product_brands.name as brand_name',
                'products.description as product_des',
                // 'order_item_logs.type',
                DB::raw("CONCAT(users.first_name,' ',users.last_name)  AS created_by"),
                // DB::raw("users.id as user_id"),
                // DB::raw("CONCAT(customers.first_name,' ',customers.last_name)  AS customer"),
                // DB::raw("customers.id as customer_id")
                // DB::raw("((sum(((abs(order_item_logs.quantity)*order_item_logs.price)* order_item_logs.discount)/100))+ 
                // (select abs(order_item_logs.sub_total) from order_item_logs where order_item_logs.type ='discount' and order_item_logs.order_id = order_logs.id)) AS discount")
                // DB::raw('CONVERT(abs(SUM(CASE WHEN order_item_logs.type = "discount" THEN 0 ELSE order_item_logs.quantity END)),SIGNED INTEGER) as item_purchased')
            )
            ->where('order_logs.order_type', '=', 'sales')
            ->where('order_logs.status', '=', 'done')
            ->whereIn('order_item_logs.order_id',$orderIds)->get();
            
        }
        else
        {
            $query = OrderItemLog::getOrderAuditTrail2($order_id);
        }
        
        return $query;
    }

    public static function getItemDiscountAndItemPurchased($order_id)
    {
        return OrderItemLog::query()->join('order_logs', 'order_logs.id', '=', 'order_item_logs.order_id')->select(
            // DB::raw("((sum(((abs(order_items.quantity)*order_items.price)* order_items.discount)/100))+ 
            // (select abs(order_items.sub_total) from order_items where order_items.type ='discount' and order_items.order_id = orders.id)) AS discount"),
            DB::raw('CONVERT(abs(SUM(CASE WHEN order_item_logs.type = "discount" THEN 0 ELSE order_item_logs.quantity END)),SIGNED INTEGER) as item_purchased')
        )->where('order_item_logs.id', '=', $order_id)
        ->first();
    }

    public static function getOrderAuditTrail2($order_id)
    {
        return OrderItems::query()->join('orders', 'orders.id', '=', 'order_items.order_id')
        ->join('products', 'products.id', '=', 'order_items.product_id')
        ->join('users', 'users.id', '=', 'orders.created_by')
        // ->leftJoin('taxes', 'taxes.id', '=', 'order_items.tax_id')
        // ->leftJoin('customers', 'customers.id', '=', 'orders.customer_id')
        // ->leftJoin('branches', 'branches.id', 'orders.transfer_branch_id')
        // ->leftJoin('product_categories', 'product_categories.id', '=', 'products.category_id')
        // ->leftJoin('product_brands', 'product_brands.id', '=', 'products.brand_id')
        ->select(
            'order_items.id',
            // 'branches.name as transfer_branch_name',
             DB::raw('DATE_FORMAT(orders.date,"%m/%d/%Y") AS date '),
            // 'orders.type',
            // 'orders.sub_total',
            // 'orders.total_tax as tax',
            // 'orders.total',
            // 'orders.invoice_id',
            // 'orders.due_amount',
            'order_items.product_custom_details as product_variations',
            'orders.order_status',
            // 'products.imageURL',
            'products.title',
            // 'product_categories.name as cat_name',
            // 'product_brands.name as brand_name',
            'products.description as product_des',
            // 'order_items.type',
            DB::raw("CONCAT(users.first_name,' ',users.last_name)  AS created_by"),
            // DB::raw("users.id as user_id"),
            // DB::raw("CONCAT(customers.first_name,' ',customers.last_name)  AS customer"),
            // DB::raw("customers.id as customer_id")
            // DB::raw("((sum(((abs(order_items.quantity)*order_items.price)* order_items.discount)/100))+ 
            // (select abs(order_items.sub_total) from order_items where order_items.type ='discount' and order_items.order_id = orders.id)) AS discount")
            // DB::raw('CONVERT(abs(SUM(CASE WHEN order_items.type = "discount" THEN 0 ELSE order_items.quantity END)),SIGNED INTEGER) as item_purchased')
        )
        ->where('orders.order_type', '=', 'sales')
        
        ->where('order_items.order_id', '=', $order_id)->get();
    }

}
