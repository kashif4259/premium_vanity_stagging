<template id="invoice-slip">
    <div style="height:100%">
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
                <div class="row">
                    <div class="col-md-12">
                        <table width="80%"  align="center" style="width: 80%; margin: auto;">
                            <tbody>
                                <tr>
                                    <td><hr style="color:#59627B"></td>
                                </tr>
                                <tr>
                                    <td>
                                        <table id="logo-with-address">
                                            <tbody>
                                                <tr>
                                                    <td style="vertical-align:top">
                                                        <p>
                                                            <b style="color:#59627B;">Premium Vanity & Flooring</b>
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
                                                    <td align="left" style="color:#212F47"><h1>Payments History</h1></td>
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
                                                <tr>
                                                    <td><b>Deilivery Type</b></td>
                                                    <td>&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td>{{ order.header_info.delivery_or_pickup }}</td>
                                                    <td>&nbsp;</td>
                                                    <td align="right"><b>Pickup/Deliver DATE </b>{{ order.header_info.delivery_or_pickup_date }}</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td><hr style="color:#59627B"></td>
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
                                            <thead style="background-color: #C2C2C2; color: #212F47;">
                                                <tr>
                                                    <th align="left">DATE</th>
                                                    <th align="left">Amount</th>
                                                    <th align="left">Paid By</th>
                                                    <th align="left">Received By</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>&nbsp;</td>
                                                </tr>
                                                <tr v-for="(item, index) in order.payments.data" :key="index">
                                                    <td style="vertical-align:top;">{{ item.date }}</td>
                                                    <td style="vertical-align:top;">{{numberFormat(item.paid)}}</td>
                                                    <td style="vertical-align:top;">{{capitalizeText(item.paid_by) }}</td>
                                                    <td style="vertical-align:top;">{{capitalizeText(item.received_by) }}</td>
                                                </tr>
                                                
                                            </tbody>
                                        </table>
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
                                    @click.prevent="print()">
                                Print
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
        props: ["rowData", "modalIdForGeneratePaymentsHistory", "modalTitle", "orderType", "pre_loader"],
        // components: {
        //     Datepicker
        // },
        data() {
            return {
                selectedOrderId: '',
                order:{
                    header_info:'',
                    payments:''
                },
                printOptions: {
                    printable: 'printMe',
                    type: 'html',
                    maxWidth: '',
                    maxHeight:'100%',
                    scanStyles: false,
                    css: [
                        AppFunction.getAppUrl('css/app.css')
                    ],
                    style: 'body  { visibility: hidden; } #printMe {visibility: visible; border: none; max-height:100%; overflow: visible } .payment-button {display: none}',
                    targetStyle: ["max-height"]
                }
                
                
            };
        },
        created() {
            this.selectedOrderId = this.rowData.id;
            console.log(this.selectedOrderId+"selected order id");
            this.hideEditSalesDatePreloader = this.pre_loader;
            // this.hidePaymentListGetLoader = true;
            
        },
        mounted() {
            
            let instance = this;
            instance.getOrderDetails('/orders/getPaymentsHistory/' +instance.selectedOrderId);
            
            $("#generate-payments-history-modal").on("hidden.bs.modal", function (e) {
                instance.$emit("emitForGeneratePaymentsHistory", false);
            });
            
            
        },

        watch: {
            pre_loader: function (value) {
                this.hideEditSalesDatePreloader = value;
            }
        },

        methods: {
            capitalizeText(value) {
            if (!value) return '';
            return value
                .toLowerCase()
                .replace(/\b\w/g, (char) => char.toUpperCase());
            },
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
                // ref: https://printjs.crabbly.com/#documentation
                printJS(this.printOptions)
            }
        }
    };
</script>

<style type="text/css">

hr{
        background-color: #212F47; height: 1px; border: 0;
    }
    
    @media print { 
     .payment-button{
     display:none;
     }
  body * { 
  visibility: hidden; 
  } 
  #printMe, #printMe * { 
  visibility: visible; border: none; 
  }
}
</style>