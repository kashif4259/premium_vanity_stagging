<template>
    <div v-if="(rowData.invoice_id != 'Total' && rowData.invoice_id != 'Grand Total') && (due != 0 || salesListDelete == 1 || salesListEdit == 1)" class="action-button-wrapper">
        <div class='action-button-container'>
            <a v-if="due != 0" href="" class='action-button' data-toggle="modal"
               data-target="#due-amount-edit-modal"
               @click.prevent="viewCustomerEdit(rowData,rowIndex)">
                <i class="la la-money la-2x"/>
            </a>

            <a v-if="salesListDelete == 1 && this.rowData.order_status != 'Cancelled'" href="" class='action-button'  data-toggle="modal" data-target="#confirm-delete" @click.prevent="selectedDeletableId(rowData.id,rowIndex)"><i class="la la-trash-o la-2x"></i></a>

            <a v-if="salesListEdit == 1 && (this.rowData.order_status != 'Pending' || this.rowData.order_status != 'Processing' || this.rowData.order_status != 'Hold') && (this.rowData.order_status != 'Cancelled') " 
                :href="publicPath+'/orders/'+rowData.id+'/edit'"  class='action-button'>
                <i class="la la-edit la-2x"></i>
            </a>

            <!-- generate packing slip button here-->
            <a v-if="salesListEdit == 1 && this.rowData.order_status != 'Cancelled' " href="" class='action-button'  data-toggle="modal"
               data-target="#generate-packing-slip-modal"
               @click.prevent="generatePackingSlip(rowData,rowIndex)">
                <i class="la la-file la-2x"></i>
            </a>

            <a v-if="salesListEdit == 1 && this.rowData.order_status != 'Pending' && this.rowData.order_status != 'Pickedup' && this.rowData.order_status != 'Cancelled' && this.rowData.order_status != 'Hold' " href="" class='action-button'  data-toggle="modal"
               data-target="#change-order-status-modal"
               @click.prevent="changeOrderStatus(rowData,rowIndex)">
                <i class="la la-building la-2x"></i>
            </a>

            <!-- generate invoice --> 
            <a v-if="salesListEdit == 1 " href="" class='action-button'  data-toggle="modal"
               data-target="#generate-invoice-modal"
               @click.prevent="generateInvoice(rowData,rowIndex)">
               <i class="la-align-justify"/>
            </a>

            <!-- generate payments --> 
            <a v-if="salesListEdit == 1 " href="" class='action-button'  data-toggle="modal"
               data-target="#generate-payments-history-modal"
               @click.prevent="generatePaymentsHistory(rowData,rowIndex)">
               <i class="la la-list-alt"/>
            </a>
        </div>

        <i class="la la-ellipsis-v la-1x"/>
    </div>
</template>
<script>

    const {unformat} = require('number-currency-format');

    export default {
        props: ['rowData', 'rowIndex'],
        data(){
            return{
                selectedRowData : this.rowData,
                due : unformat(this.rowData.due_amount),
            }
        },
        mounted(){
            $(".action-button-wrapper")
                .on("mouseover", function () {
                    $(this).addClass("active");
                })
                .on("mouseleave", function () {
                    $(this).removeClass("active");
                });
        },
        methods:{
            viewCustomerEdit(rowData){
                this.$hub.$emit('viewSalesReportEdit', rowData);
            },
            selectedDeletableId(id,index) {
                this.$hub.$emit('selectedDeletableId', id, index);
            },
            editSalesDate(rowdata, index) {
                this.$hub.$emit('editSalesDate', rowdata, index);
            },
            generatePackingSlip(rowdata, index){
                this.$hub.$emit('generatePackingSlip', rowdata, index);
            },
            generateInvoice(rowdata, index){
                this.$hub.$emit('generateInvoice', rowdata, index);
            },
            generatePaymentsHistory(rowdata, index){
                this.$hub.$emit('generatePaymentsHistory', rowdata, index);
            },
            changeOrderStatus(rowData, index){
                this.$hub.$emit('changeOrderStatus', rowData, index);
            }

        }
    }
</script>
