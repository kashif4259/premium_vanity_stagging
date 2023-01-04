<?php

namespace App\Console\Commands\Orders;

use App\User;
use Carbon\Carbon;
use App\Models\Order;
use App\Libraries\Email;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Mail;
use Zend\Diactoros\Request;

class Notifications extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'run:order-notifications';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Cron Job to send order notifications daily';

    protected $email;

    /**
     * Create a new command instance.
     *
     * @return void
     *
     */
    public function __construct()
    {
        parent::__construct();

        $this->email = app(Email::class);
    }

    /**
     * Execute the console command.
     *
     * @return mixed
     *
     * $cron_status = $request->cron_status;
    Setting::where('setting_name','offday_setting')->update(['setting_value'=> $cron_status]);
     */
    public function handle()
    {
        $orders = Order::getOrdersForNotificationsCommand();
        $users = User::all();
        foreach($orders as $order)
        {
            $diff = $this->getDeliveryStatusWithCurrentDateDifference($order);

            if($diff < 14 && $order->order_status == 'hold')
            {
                foreach ( $users as $user)
                {
                    $this->email->sendEmail("Please check order # {$order->invoice_id}", $user->email, "Order Status Notication of Invoice # {$order->invoice_id}");
                    // {
                    // Mail::raw("This is automatically generated Update", function ($message) use ($user){
                    //     $message->from('gain@booking.com', 'Noble POS');
                    //     $message->to($user->email)->subject('New Service/ Event Notification');
                    // });
                }
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
