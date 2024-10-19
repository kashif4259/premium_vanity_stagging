<template id="order-packing-slip">
    <div class="main-containter" style="height:100%">
        <div class="modal-layout-content" id="printMe" >
            <div class="row">
                <div class="col-md-6">
                    <!-- <h5>{{ modalTitle }}</h5> -->
                </div>
                <div class="col-md-5 text-right payment-amount">    
                </div>
                <div class="col-md-1 text-right">
                    <a href="#" data-dismiss="modal" aria-label="Close" class="close">
                        <i class="la la-close text-grey"/>
                    </a>
                </div>
            </div>
            
            <pre-loader v-if="!hideEditSalesDatePreloader"/>
            <div v-else class="">
                <div class="row order-print-main">
                    <div class="col-md-12">
                        <table width="80%"  align="center" style="width: 80%; margin: auto;">
                            <tbody>
                                <tr>
                                    <td>
                                        <table id="logo-with-address">
                                            <tbody>
                                                <tr>
                                                    <td style="vertical-align:top">
                                                        <img :src="publicPath+'/uploads/logo/invoice.png'" alt width="50px" />
                                                    </td>
                                                    <td style="vertical-align:top">
                                                        <p>
                                                            <b>Premium Vanity & Flooring</b>
                                                        </p>
                                                        <p>
                                                            1620 Midland Ave
                                                        </p>
                                                        <p>
                                                            Scarborough
                                                        </p>
                                                        <p>
                                                            416-800-0875
                                                        </p>
                                                        <!-- <p>
                                                            info@noblevanity.ca
                                                        </p>
                                                        <p>
                                                            www.noblevanity.ca
                                                        </p>
                                                        <p>
                                                            GST/HST Registration No.: 803470525
                                                        </p> -->
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    <table width="100%">
                                            <tbody>
                                                <tr>
                                                    <td>&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td align="center" style="color:#2DABE1"><h1>Packing Slip</h1></td>
                                                </tr>
                                                <tr>
                                                    <td>&nbsp;</td>
                                                </tr>
                                            </tbody>
                                    </table> 
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table width="100%">
                                            <tbody>
                                                <tr>
                                                    <td><b>BILL TO</b></td>
                                                    <td>&nbsp;</td>
                                                    <td align="right"><b>INVOICE # </b>{{ order.header_info.invoice_id }}</td>
                                                </tr>
                                                <tr>
                                                    <td>{{ order.header_info.customer }}</td>
                                                    <td>&nbsp;</td>
                                                    <td align="right"><b>DATE: </b>{{ order.header_info.date }}</td>
                                                </tr>
                                                <tr>
                                                    <td><b>Deilivery Type</b></td>
                                                    <td>&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td>{{ order.header_info.delivery_or_pickup }}</td>
                                                    <td>&nbsp;</td>
                                                    <td align="right"><b>Pickup/Deliver DATE: </b>{{ order.header_info.delivery_or_pickup_date }}</td>
                                                </tr>
                                                <tr>
                                                    <td><b>Customer Type</b></td>
                                                    <td>&nbsp;</td>
                                                    <td align="right"><b>Received By: </b>{{ order.header_info.received_by}}</td>
                                                </tr>
                                                <tr>
                                                    <td>{{ order.header_info.customer_type }}</td>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td><hr style="color:#2DABE1"></td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        <table width="100%" style="border-spacing: 10px;">
                                            <thead style="background-color: #a3d0e4; color: #2DABE1;">
                                                <tr>
                                                    <th align="left">DATE</th>
                                                    <th align="left">DESCRIPTION</th>
                                                    <th align="left">Notes</th>
                                                    <th align="left">QTY</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>&nbsp;</td>
                                                </tr>
                                                <tr v-for="(item, index) in order.order_items" :key="index">
                                                    <td width="10%" style="vertical-align:top; padding: 10px;">{{ item.date }}</td>
                                                    <td width="20%" style="padding: 10px;">
                                                        <p>{{ item.title }}</p>
                                                        <ul>
                                                            <li v-for="(variation, i) in item.product_variations" :key="i" v-if=" !['size','hole','color'].includes(i)">
                                                                <!-- <span v-if="i == 'hole' && variation != '' ">
                                                                    Hole: {{ variation }}
                                                                </span> -->
                                                                <!-- <span v-if="i == 'size' && variation != '' ">
                                                                    Dimensions: {{ variation }}
                                                                </span> -->
                                                                <span v-if="i == 'drawer_side' && variation != ''  ">
                                                                    DRAWERS SIDE: {{ variation }}
                                                                </span>
                                                                <!-- <span v-if="i == 'wall_side' && variation != '' ">
                                                                    WALL SIDE: {{ variation }}
                                                                </span> -->
                                                                <span v-if="i == 'handles' && variation != '' ">
                                                                    HANDLES: {{ variation }}
                                                                </span>
                                                                <span v-if="i == 'filler' && variation != '' ">
                                                                    FILLER:: {{ variation }}
                                                                </span>
                                                                <!-- <span v-if="i == 'color' && variation != '' ">
                                                                    COLOR: {{ variation }}
                                                                </span> -->
                                                            </li> 
                                                        </ul>
                                                    </td>
                                                    <td width="40%" style="vertical-align:top; padding: 10px;">{{ item.note }}</td>
                                                    <td width="10%" style="vertical-align:top; padding: 10px;">{{ item.item_purchased }}</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td>&nbsp;</td>
                                </tr>
                               
                            </tbody>
                        </table>                           
                    </div>
                </div>
                <div class="row" style="width:90%; margin: auto;">
                    <div class="col-md-12">
                        <hr class="custom-margin"/>
                        <button class="btn btn-block app-color payment-button" style="margin-bottom:5px;"
                                    @click.prevent="updateOrderStatus()">
                                {{ trans('lang.print_packing_slip') }}
                            </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import axiosGetPost from "../../../helper/axiosGetPostCommon";
    import AppFunction from "../../../js/AppFuntion";

    export default {
        extends: axiosGetPost,
        props: ["rowData", "modalIdForGeneratePackingSlip", "modalTitle", "orderType", "pre_loader"],
        // components: {
        //     Datepicker
        // },
        data() {
            return {
                selectedOrderId: '',
                order:{
                    header_info:'',
                    order_items:''
                },
                printOptions: {
                    printable: 'printMe',
                    type: 'html',
                    maxWidth: '',
                    scanStyles: false,
                    css: [
                        AppFunction.getAppUrl('css/invoice.css')
                    ],
                    style: 'body  { visibility: hidden; } #printMe {visibility: visible; border: none; max-height:100%; overflow: visible } .payment-button {display: none}',
                    targetStyle: ["max-height"]
                }
                
                
            };
        },
        created() {
            this.selectedOrderId = this.rowData.id;
            this.hideEditSalesDatePreloader = this.pre_loader;
            // this.hidePaymentListGetLoader = true;
            
        },
        mounted() {
            let instance = this;
            instance.getOrderDetails('/orders/getPackingSlipDetails/' +instance.selectedOrderId);
            $("#generate-packing-slip-modal").on("hidden.bs.modal", function (e) {
                instance.$emit("emitForGeneratePackingSlip", false);
            });
            //generate-invoice-modal
            
        },

        watch: {
            pre_loader: function (value) {
                this.hideEditSalesDatePreloader = value;
            }
        },

        methods: {
            updateOrderStatus() {
                console.log(this.rowData.order_status);
                this.submitted = true;
                this.isActive = true;
                let dbOderStatus = this.rowData.order_status.toLowerCase();
                if(dbOderStatus == 'pending' || dbOderStatus == 'hold')
                {
                    this.postDataMethod('/orders/updateOrderStatus/' + this.rowData.id, {
                        'order_status':'Processing'
                    });
                }
                
                this.print();
            },
            // postDataThenFunctionality() {
            //     $(this.modalIdForSalesDateEdit).modal('hide');
            // },
            // postDataCatchFunctionality() {
            //     $(this.modalIdForSalesDateEdit).modal('hide');
            // },

            getOrderDetails(route){
                let instance = this;
                    instance.axiosGet(route,
                        function (response) {
                            instance.order = response.data;
                            console.log(instance.order);
                        },
                        function (response) {

                        },
                    );
            },
            print() {
                // this.$htmlToPaper("printMe");
                //ref: https://printjs.crabbly.com/#documentation
                printJS(this.printOptions)
            }
        }
    };
</script>

<!-- 
<style type="text/css">

hr{
        background-color: #2DABE1; height: 1px; border: 0;
    }
    
    @media print { 
  body * { 
  visibility: hidden; 
  } 
  #printMe, #printMe * { 
  visibility: visible; border: none; 
  }
}
</style> -->


<style type="text/css">

hr{
        background-color: #212F47; height: 1px; border: 0;
    }
    
    @media print { 
     .payment-button{
     display:none;
     }
  body * { 
  visibility: hidden !important; 
  } 
  #printMe, #printMe * { 
  visibility: visible; border: none !important; 
  }
}

</style>