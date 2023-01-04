<template id="order-packing-slip">
    <div>
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
            <div v-else class="row mx-0 modal-content-row">
                <div class="row">
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
                                                            <b>Noble Vanity & More</b>
                                                        </p>
                                                        <p>
                                                            5805 Kennedy Rd
                                                        </p>
                                                        <p>
                                                            Mississauga ON L4Z 2G3
                                                        </p>
                                                        <p>
                                                            (905) 890 1900
                                                        </p>
                                                        <p>
                                                            info@noblevanity.ca
                                                        </p>
                                                        <p>
                                                            www.noblevanity.ca
                                                        </p>
                                                        <p>
                                                            GST/HST Registration No.: 803470525
                                                        </p>
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
                                                    <td align="right"><b>DATE </b>{{ order.header_info.date }}</td>
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
                                        <table width="100%">
                                            <thead style="background-color: #a3d0e4; color: #2DABE1;">
                                                <tr>
                                                    <th align="left">DATE</th>
                                                    <th align="left">DESCRIPTION</th>
                                                    <th align="left">QTY</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>&nbsp;</td>
                                                </tr>
                                                <tr v-for="(item, index) in order.order_items" :key="index">
                                                    <td style="vertical-align:top;">{{ item.date }}</td>
                                                    <td>
                                                        <p>{{ item.title }}</p>
                                                        <ul>
                                                            <li v-for="(variation, i) in item.product_variations" :key="i">
                                                                <span v-if="i == 'hole' && variation != '' ">
                                                                    Hole: {{ variation }}
                                                                </span>
                                                                <span v-if="i == 'size' && variation != '' ">
                                                                    Dimensions: {{ variation }}
                                                                </span>
                                                                <span v-if="i == 'drawer_side' && variation != ''  ">
                                                                    DRAWERS SIDE: {{ variation }}
                                                                </span>
                                                                <span v-if="i == 'wall_side' && variation != '' ">
                                                                    WALL SIDE: {{ variation }}
                                                                </span>
                                                                <span v-if="i == 'handles' && variation != '' ">
                                                                    HANDLES: {{ variation }}
                                                                </span>
                                                                <span v-if="i == 'filler' && variation != '' ">
                                                                    FILLER:: {{ variation }}
                                                                </span>
                                                                <span v-if="i == 'color' && variation != '' ">
                                                                    COLOR: {{ variation }}
                                                                </span>
                                                            </li> 
                                                        </ul>
                                                    </td>
                                                    <td style="vertical-align:top;">{{ item.item_purchased }}</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        <hr />
                                    </td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        <p>To make any changes in your order please email at info@noblevanity.ca</p>
                                        <p>Refund Policy: 15% Restocking Fee will apply on all returned products after they are picked up and 7% cancelled charges will apply if</p>
                                        <p>order cancelled before pickup. No return after 30 Days.</p>
                                        <p>-Please check products condition before pick up. Noble Vanity & More is not liable for any product damage after pick up or delivery.</p>
                                    </td>
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
            <!-- <div class="row mx-0 modal-content-row">
                    <div class="col-md-12">
                        <hr class="custom-margin"/>
                        <span class="">
                            <button class="btn btn-block app-color payment-button"
                                    @click.prevent="updateSalesDate()">
                                {{ trans('lang.save') }}
                            </button>
                        </span>
                    </div>
                </div> -->
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
                        AppFunction.getAppUrl('css/app.css')
                    ],
                    style: 'body  { visibility: hidden; } #printMe {visibility: visible; border: none; }'
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
</style>