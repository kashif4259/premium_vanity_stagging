<template id="invoice-slip">
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
                <div class="row order-print-main page-break">
                    <div class="col-md-12 ">
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
                                                    <td align="left" style="color:#212F47"><h1>INVOICE</h1></td>
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
                                        <table class="item-tbl-print" width="100%" style="border-spacing: 10px;">
                                            <thead style="background-color: #C2C2C2; color: #212F47;">
                                                <tr>
                                                    <th align="left">DATE</th>
                                                    <th align="left">DESCRIPTION</th>
                                                    <th align="left">Notes</th>
                                                    <th align="left">QTY</th>
                                                    <th align="left">Unit Price</th>
                                                    <th align="left">Total Price</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>&nbsp;</td>
                                                </tr>
                                                <tr v-for="(item, index) in order.order_items" :key="index" v-if="item.price > 0" >
                                                    <td style="vertical-align:top; padding: 10px;" width="5%">{{ item.date }}</td>
                                                    <td width="25%" style="padding: 10px;">
                                                        <p>{{ item.title }}</p>
                                                        <ul v-if="item.category_id == 1 && Object.keys(item.product_variations).length > 0" style="list-style: none; padding: 0; margin: 0;">
                                                            <!-- Fillers Section -->
                                                            <table style="width: 100%; border-collapse: collapse; text-align: left;">
                                                                <thead>
                                                                    <tr>
                                                                        <th colspan="2" style="border: 1px solid #ddd; padding: 8px; text-align: center; background-color: rgb(194, 194, 194); color: rgb(33, 47, 71);"><b>Fillers</b></th>
                                                                    </tr>
                                                                    <tr>
                                                                        <th style="border: 1px solid #ddd; padding: 8px; text-align: center; background-color: rgb(194, 194, 194); color: rgb(33, 47, 71);">Attribute</th>
                                                                        <th style="border: 1px solid #ddd; padding: 8px; text-align: center; background-color: rgb(194, 194, 194); color: rgb(33, 47, 71);">Value</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <td style="border: 1px solid #ddd; padding: 8px;">Quantity</td>
                                                                        <td style="border: 1px solid #ddd; padding: 8px;">{{ item.product_variations.filler.quantity }}</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="border: 1px solid #ddd; padding: 8px;">Size</td>
                                                                        <td style="border: 1px solid #ddd; padding: 8px;">{{ item.product_variations.filler.size }}</td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                            <!-- Handles Section -->
                                                            <table style="width: 100%; border-collapse: collapse; text-align: left;">
                                                                <thead>
                                                                    <tr>
                                                                        <th colspan="2" style="border: 1px solid #ddd; padding: 8px; text-align: center; background-color: rgb(194, 194, 194); color: rgb(33, 47, 71);"><b>Handles</b></th>
                                                                    </tr>
                                                                    <tr>
                                                                        <th style="border: 1px solid #ddd; padding: 8px; text-align: center; background-color: rgb(194, 194, 194); color: rgb(33, 47, 71);">Attribute</th>
                                                                        <th style="border: 1px solid #ddd; padding: 8px; text-align: center; background-color: rgb(194, 194, 194); color: rgb(33, 47, 71);">Value</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <td style="border: 1px solid #ddd; padding: 8px;">Name</td>
                                                                        <td style="border: 1px solid #ddd; padding: 8px;">{{ item.product_variations.handles.name }}</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="border: 1px solid #ddd; padding: 8px;">Quantity</td>
                                                                        <td style="border: 1px solid #ddd; padding: 8px;">{{ item.product_variations.handles.quantity }}</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="border: 1px solid #ddd; padding: 8px;">Drawer/Door</td>
                                                                        <td style="border: 1px solid #ddd; padding: 8px;">{{ capitalizeFirstLetter(item.product_variations.handles.handle_drawer_or_door) }}</td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                            <!-- </li> -->
                                                            <!-- Knobs Section -->
                                                            <table style="width: 100%; border-collapse: collapse; text-align: left;">
                                                                <thead>
                                                                    <tr>
                                                                        <th colspan="2" style="border: 1px solid #ddd; padding: 8px; text-align: center; background-color: rgb(194, 194, 194); color: rgb(33, 47, 71);"><b>Knobs</b></th>
                                                                    </tr>
                                                                    <tr>
                                                                        <th style="border: 1px solid #ddd; padding: 8px; text-align: center; background-color: rgb(194, 194, 194); color: rgb(33, 47, 71);">Attribute</th>
                                                                        <th style="border: 1px solid #ddd; padding: 8px; text-align: center; background-color: rgb(194, 194, 194); color: rgb(33, 47, 71);">Value</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <td style="border: 1px solid #ddd; padding: 8px;">Name</td>
                                                                        <td style="border: 1px solid #ddd; padding: 8px;">{{ item.product_variations.knobs.name }}</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="border: 1px solid #ddd; padding: 8px;">Quantity</td>
                                                                        <td style="border: 1px solid #ddd; padding: 8px;">{{ item.product_variations.knobs.quantity }}</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="border: 1px solid #ddd; padding: 8px;">Drawer/Door</td>
                                                                        <td style="border: 1px solid #ddd; padding: 8px;">{{ capitalizeFirstLetter(item.product_variations.knobs.knobs_drawer_or_door) }}</td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                            <!-- Counter Top Section -->
                                                            <table style="width: 100%; border-collapse: collapse; text-align: left;">
                                                                <thead>
                                                                    <tr>
                                                                        <th colspan="2" style="border: 1px solid #ddd; padding: 8px; text-align: center; background-color: rgb(194, 194, 194); color: rgb(33, 47, 71);"><b>Counter Top</b></th>
                                                                    </tr>
                                                                    <tr>
                                                                        <th style="border: 1px solid #ddd; padding: 8px; text-align: center; background-color: rgb(194, 194, 194); color: rgb(33, 47, 71);">Attribute</th>
                                                                        <th style="border: 1px solid #ddd; padding: 8px; text-align: center; background-color: rgb(194, 194, 194); color: rgb(33, 47, 71);">Value</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <td style="border: 1px solid #ddd; padding: 8px;">Name</td>
                                                                        <td style="border: 1px solid #ddd; padding: 8px;">{{ item.product_variations.counter_top.name }}</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="border: 1px solid #ddd; padding: 8px;">Quantity</td>
                                                                        <td style="border: 1px solid #ddd; padding: 8px;">{{ item.product_variations.counter_top.quantity }}</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="border: 1px solid #ddd; padding: 8px;">Back Splash</td>
                                                                        <td style="border: 1px solid #ddd; padding: 8px;">{{ capitalizeFirstLetter(item.product_variations.counter_top.counter_top_back_splash) }}</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="border: 1px solid #ddd; padding: 8px;">Side Splash</td>
                                                                        <td style="border: 1px solid #ddd; padding: 8px;">{{ capitalizeFirstLetter(item.product_variations.counter_top.counter_top_side_splash) }}</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="border: 1px solid #ddd; padding: 8px;">Faucet Hole</td>
                                                                        <td style="border: 1px solid #ddd; padding: 8px;">{{ formatText(capitalizeFirstLetter(item.product_variations.counter_top.counter_top_faucet_hole)) }}</td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                            <!-- Other Section -->
                                                            <table style="width: 100%; border-collapse: collapse; text-align: left;">
                                                                <thead>
                                                                    <tr>
                                                                        <th colspan="2" style="border: 1px solid #ddd; padding: 8px; text-align: center; background-color: rgb(194, 194, 194); color: rgb(33, 47, 71);"><b>Other Details</b></th>
                                                                    </tr>
                                                                    <tr>
                                                                        <th style="border: 1px solid #ddd; padding: 8px; text-align: center; background-color: rgb(194, 194, 194); color: rgb(33, 47, 71);">Attribute</th>
                                                                        <th style="border: 1px solid #ddd; padding: 8px; text-align: center; background-color: rgb(194, 194, 194); color: rgb(33, 47, 71);">Value</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <td style="border: 1px solid #ddd; padding: 8px;">Drawer Side</td>
                                                                        <td style="border: 1px solid #ddd; padding: 8px;">{{ capitalizeFirstLetter(item.product_variations.other_details.drawer_side) }}</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="border: 1px solid #ddd; padding: 8px;">Wall Side</td>
                                                                        <td style="border: 1px solid #ddd; padding: 8px;">{{ capitalizeFirstLetter(item.product_variations.other_details.wall_side) }}</td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </ul>
                                                        
                                                        <!-- <ul>
                                                            <li v-for="(variation, i) in item.product_variations" :key="i" v-if=" !['size','hole','color'].includes(i)">
                                                                <span v-if="i == 'filler' && variation != '' ">
                                                                    FILLER: {{ variation }}
                                                                </span>
                                                            </li> 
                                                        </ul> -->
                                                    </td>
                                                    <td style="vertical-align:top; padding: 10px;" width="30%">{{ item.note }}</td>
                                                    <td style="vertical-align:top; padding: 10px;" width="5%">{{ item.item_purchased }}</td>
                                                    <td style="vertical-align:top; padding: 10px;" width="5%">{{numberFormat(item.price)}}</td>
                                                    <td style="vertical-align:top; padding: 10px;" width="5%">{{numberFormat(item.price*item.item_purchased)}}</td>
                                                </tr>
                                                <tr>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                    <td style="vertical-align:top; color:#253453;">SubTotal</td>
                                                    <td style="vertical-align:top;">{{numberFormat(order.order_footer.sub_total)}}</td>
                                                </tr>
                                                <tr>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                    <td style="vertical-align:top; color:#253453;">Tax</td>
                                                    <td style="vertical-align:top;">{{numberFormat(order.order_footer.total_tax)}}</td>
                                                </tr>
                                                <tr>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                    <td style="vertical-align:top; color:#253453;">Deilivery</td>
                                                    <td style="vertical-align:top;">{{numberFormat(order.order_footer.delivery_charges)}}</td>
                                                </tr>
                                                <tr>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                    <td style="vertical-align:top; color:#253453;">Total</td>
                                                    <td style="vertical-align:top;">{{numberFormat(order.order_footer.total)}}</td>
                                                </tr>
                                                <tr>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                    <td style="vertical-align:top; color:#253453;">Balance</td>
                                                    <td style="vertical-align:top;">{{numberFormat(order.order_footer.due_amount)}}</td>
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
                                Print Invoice
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
        props: ["rowData", "modalIdForGenerateInvoice", "modalTitle", "orderType", "pre_loader"],
        // components: {
        //     Datepicker
        // },
        data() {
            // print code
            return {
                selectedOrderId: '',
                order:{
                    header_info:'',
                    order_items:'',
                    order_footer:''
                },
                printOptions: {
                    printable: 'printMe',
                    type: 'html',
                    maxWidth: '',
                    maxHeight:'100%',
                    scanStyles: false,
                    css: [
                        AppFunction.getAppUrl('css/invoice.css'),
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
            instance.getOrderDetails('/orders/getInvoiceDetails/' +instance.selectedOrderId);
            
            $("#generate-invoice-modal").on("hidden.bs.modal", function (e) {
                instance.$emit("emitForGenerateInvoice", false);
            });
            
            
        },

        watch: {
            pre_loader: function (value) {
                this.hideEditSalesDatePreloader = value;
            }
        },

        methods: {

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
            },
            capitalizeFirstLetter(string) {
                if (!string) return "";
                return string.charAt(0).toUpperCase() + string.slice(1);
            },
            formatText(text) {
                return text
                    .split("_") // Split the string by underscores
                    .map(word => word.charAt(0).toUpperCase() + word.slice(1)) // Capitalize each word
                    .join(" "); // Join the words with a space
            }
        }
    };
</script>


<style type="text/css">
hr {
    background-color: #212F47;
    height: 1px;
    border: 0;
}

@media print { 
    .payment-button {
        display: none;
    }

    body * { 
        visibility: hidden; 
    } 

    #printMe, #printMe * { 
        visibility: visible; 
        border: none; 

        width: 100%;
        margin: 0 auto;
        page-break-after: auto;
    }

    /* Enforce a page break after each item */
    table {
        page-break-inside: avoid; /* Prevent the table from splitting */
    }

    tr, td {
        page-break-inside: avoid; /* Prevent rows or cells from splitting */
    }

    .page-break {
        page-break-before: always; /* Force the start of a new page */
    }

    
}
</style>
