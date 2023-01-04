<?php

namespace App\Console\Commands\Orders;

use App\User;
use Carbon\Carbon;
use App\Models\Order;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Mail;
use Zend\Diactoros\Request;

class OrderDeliveryStatusUpdate extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'run:update-order-delivery-status';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Cron Job to update order delivery status daily';

    /**
     * Create a new command instance.
     *
     * @return void
     *
     */
    public function __construct()
    {
        parent::__construct();
    }

    public function handle()
    {
        $orders = Order::getOrdersForNotificationsCommand();

        foreach($orders as $order)
        {
            $diff = $this->getDeliveryStatusWithCurrentDateDifference($order);

            if($diff == 14)
            {
                $order->order_status = 'hold';

                $order->update();
            }
        }

        $this->info('New Service/ Event Notification has been send successfully');
    }

    private function getDeliveryStatusWithCurrentDateDifference($order)
    {
        // $oder->delivery_or_pickup;
        $orderDate = $order->delivery_or_pickup_date;
        
        $orderDate = Carbon::parse($orderDate);
        
        $now = Carbon::now();

        return $orderDate->diffInDays($now);
    }
}
