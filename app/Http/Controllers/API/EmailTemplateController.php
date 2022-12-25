<?php

namespace App\Http\Controllers\API;

use App\Models\EmailTemplate;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Libraries\AllSettingFormat;
use App\Libraries\Email;
use App\Models\Branch;
use App\Models\Product;
use App\Models\Setting;
use PDF;
use File;
use Carbon\Carbon;
use Illuminate\Support\Facades\Config;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Lang;

class EmailTemplateController extends Controller
{

    public function index(Request $request)
    {
        $data = EmailTemplate::getEmailTemplate($request);
        $totalCount = EmailTemplate::countData();

        return ['datarows' => $data, 'count' => $totalCount];
    }

    public function show($id)
    {
        $emailTemplate = EmailTemplate::getOne($id);

        if ($emailTemplate->custom_content) {
            $response = [
                'emailSubject' => $emailTemplate->template_subject,
                'content' => $emailTemplate->custom_content,
                'isCustom' => true,
            ];
        } else {
            $response = [
                'emailSubject' => $emailTemplate->template_subject,
                'content' => $emailTemplate->default_content,
                'isCustom' => false,
            ];
        }

        return $response;
    }

    public function update(Request $request, $id)
    {
        $this->validate($request, [
            'subject' => 'required',
        ]);

        $success = EmailTemplate::updateData($id, [
            'template_subject' => $request->input('subject'),
            'custom_content' => $request->input('custom_content')
        ]);

        if (!$success) {
            return response()->json([
                'message' => Lang::get('lang.error_during_update')
            ], 404);
        }

        $response = [

            'message' => ucfirst(strtolower(Lang::get('lang.' . $request->template_name) . ' ' . Lang::get('lang.settings_saved_successfully')))
        ];

        return response()->json($response, 200);
    }

    public function lowStockTemplateToPrint($branch, $lowStockProducts)
    {

        $data = EmailTemplate::getLowStockTemplate();
        $itemDetails = $this->getItemDetailsForLowStock($lowStockProducts);

        $appName = Config::get('app_name');
        $invoiceLogo = Config::get('invoiceLogo');

        $publicPath = \Request::root();
        $src = $publicPath . '/uploads/logo/' . $invoiceLogo;

        $logo = '<div style="text-align: center;width: 100%;">
                    <img class="invoice-logo" style=" max-width: 200px;left:45%;position:relative;text-align: center; height: auto;" src= "' . $src . '" alt="Logo">
                </div>';

        $allSettingFormat = new AllSettingFormat;
        $dateTime = Carbon::now()->toDateString();

        $replace = array(
            '{app_name}' => $appName,
            '<p>{app_logo}</p>' => $logo,
            '{branch_name}' => $branch->name,
            '{branch_manager}' => $branch->manager,
            '{date}' => $allSettingFormat->getDate($dateTime),
            '{time}' => $allSettingFormat->timeFormat($dateTime),
            '<br><td style="padding: 7px 0;" class="text-center" colspan="5">{item_details}</td>' => $itemDetails,
        );
        return (['data' => strtr($data, $replace)]);
    }

    public function getItemDetailsForLowStock($itemDetails)
    {
        $allSettingFormat = new AllSettingFormat;
        $reOrder = Setting::getSettingValue('re_order')->setting_value;

        $row = "";

        foreach ($itemDetails as $item) {

            if ($item->variant_title == 'default_variant') {
                $item->variant_title = '';
            } else {
                $item->variant_title = " ( " . $item->variant_title . " ) ";
            }
            if ($item->re_order == null) $item->re_order = $reOrder;
            $newRow = '<tr>
                    <td style="padding: 7px 0; text-align: left; border-bottom: 1px solid #bfbfbf; border-spacing: 0;">' . $item->product_name . $item->variant_title . '</td>
                    <td style="padding: 7px 0; text-align: right; border-bottom: 1px solid #bfbfbf; border-spacing: 0;">' . $item->re_order . '</td>
                    <td style="padding: 7px 0; text-align: right; border-bottom: 1px solid #bfbfbf; border-spacing: 0;">' . $allSettingFormat->thousandSep($item->product_quantity) . '</td>
                </tr>';
            $row = $row . $newRow;
        }

        return $row;
    }

    public function callCornJob()
    {
        $branches = Branch::join('users', 'branches.user_id', 'users.id')->select(
            'branches.*',
            'users.email as email',
            DB::raw("CONCAT(users.first_name,' ',users.last_name)  as manager")
        )->get();
        $cornLog = new CornJobLogController;
        $cornLog->store(0);

        if (isset($branches) && !empty($branches)) {
            foreach ($branches as $item) {
                $cornLog->store($item->id);
                $mailText = "low stock list of $item->name";
                $subject = 'Low stock notification';
                $this->sendPdf($item, $mailText, $subject);
            }
        }
    }

    public function sendPdf($branch, $mailText, $subject)
    {
        
        // try {
            $emailSend = new Email;
            $lowStockProducts = Product::getLowStockProductList($branch->id);
            \Log::Info("low stock products array ". print_r($lowStockProducts, true));
            if (isset($lowStockProducts) && !empty($lowStockProducts)) {
                $template = $this->lowStockTemplateToPrint($branch, $lowStockProducts);
                $templateData = $template['data'];
                \Log::Info("temaplate data ". print_r($templateData, true));
                $appName = Config::get('app_name');
                $invoiceLogo = Config::get('invoiceLogo');
                $fileNameToStore = "Gain-Branch-$branch->id.pdf";
                $pdf = PDF::loadView('invoice.invoiceTemplate', compact('templateData'));
                $path = public_path('uploads/pdf/');
                if(!File::isDirectory($path)){
                    File::makeDirectory($path, 0777, true, true);
                }
                $pdf->save($path.$fileNameToStore);
                $mailText = '<div style="text-align: center; font-family: ">
                <div style="text-align: center;width: 100%;">
        <img class="invoice-logo" style=" max-width: 200px;left:45%;position:relative;text-align: center; height: auto;" src= "http://localhost/noble_pos/public/uploads/logo/default-logo.png" alt="Logo">
    </div>
                <h1 style="font-weight: lighter; margin-bottom: 0;">Noble POS</h1>
                <br>
                <small>Low Stock Notification</small>
                <br>
                <h3 style="text-align:center;">Out Of Stock List</h3>
            </div>
            <!--header bottom start-->
            <div style="margin-bottom:-30px; height:170px; width: 100%; overflow: hidden; display: block; font-family: ">
                    <div style="float:left; width: 50%;">
                        <p style="font-weight:bold;">Branch Name: <span>Main Branch</span></p>
                        <p style="font-weight:bold;">Branch Manager: <span>Kashif Asghar</span></p>
                    </div>
                    <div style="float:right; width: 45%;">
                        <p style="font-weight:bold; text-align: right;">Date : <span>2022-12-17</span></p>
                        <p style="font-weight:bold; text-align: right;">Time : <span>12:00 am</span></p>
                    </div>
            </div>
            <table style="border-top: 1px solid #bfbfbf; border-bottom: 1px solid #bfbfbf; border-collapse: collapse; font-weight:500; width: 100%; max-width: 100%; margin-bottom: 0; background-color: transparent; font-family: ">
                <tr>
                    <th style="text-align: left; padding: 7px 0; border-bottom: 1px solid #bfbfbf; width: 40%;">Item</th>
                    <th style="text-align: right; padding: 7px 0; border-bottom: 1px solid #bfbfbf;">Re Order</th>
                    <th style="text-align: right; padding: 7px 0; border-bottom: 1px solid #bfbfbf;">Qty</th>
                </tr><tr>
        <td style="padding: 7px 0; text-align: left; border-bottom: 1px solid #bfbfbf; border-spacing: 0;">36" LED mirror</td>
        <td style="padding: 7px 0; text-align: right; border-bottom: 1px solid #bfbfbf; border-spacing: 0;">10</td>
        <td style="padding: 7px 0; text-align: right; border-bottom: 1px solid #bfbfbf; border-spacing: 0;">-18.00</td>
    </tr></table>';
                $emailSend->sendEmail($mailText, $branch->email, $subject, null);
                // unlink(public_path('uploads/pdf/' . $fileNameToStore));

            }

            // $emailSend->sendEmail($mailText, $branch->email, $subject, $fileNameToStore);
        // } catch (\Exception $e) {
        //     \Log::Info("exception from sending cron email". print_r($e->getMessage(), true));
        // }
    }
}
