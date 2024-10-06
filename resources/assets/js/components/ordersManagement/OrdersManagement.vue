<template>
    <div class="main-layout-wrapper">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb bg-transparent m-0">
                <li class="breadcrumb-item">
                    <span>{{trans('lang.orders')}}</span>
                </li>
            </ol>
        </nav>
        <div class="main-layout-card">

            <div v-if="!hasData(tableOptions)">
                <pre-loader/>
            </div>
            <div v-else>
                <div class="main-layout-card-header-with-button">
                    <div class="main-layout-card-content-wrapper">
                        <div class="main-layout-card-header-contents">
                            <h5 class="m-0">Orders List</h5>
                        </div>
                    </div>
                </div>
                <datatable-component class="main-layout-card-content"
                                 :options="tableOptions"
                                 :exportData="exportToVue"
                                 exportFileName="orders"
                                 @resetStatus="resetExportValue"
                                 @printData="printData"
                                 @printBarcode="printBarcode"
                                 :tab_name="tabName"
                                 :route_name="routeName"/>
                
                <!-- Modal Due-->
                <div class="modal fade"
                     id="due-amount-edit-modal"
                     tabindex="-1"
                     role="dialog"
                     aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered short-modal-dialog" role="document">
                        <cart-due-payment class="modal-content"
                                          v-if="isActive"
                                          :rowdata="selectedItemId"
                                          :orderType="order_type"
                                          :modalID="modalID"
                                          :modalTitle="trans('lang.due_total')"
                                          :pre_loader="dueModalPreloader"
                                          @cartItemsToStore="cartItemsToStore"
                                          @emitForIsActive="emitForIsActive"/>
                    </div>
                </div>
                <!-- Modal date edit-->
    
                <div id="date-edit-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                            <sale-date-edit class="modal-content"
                                            v-if="isDateEditActive"
                                            :modalIdForSalesDateEdit="modalIdForSalesDateEdit"
                                            :row-data="selectedSalesForDateEdit"
                                            :pre_loader="dueModalPreloader"
                                            @emitForIsActiveEdit="emitForIsActiveEdit"
                                            :modal-title="trans('lang.sales_date_edit')"/>
                    </div>
                </div>


                

            </div>
            <!-- generate packing slip modal generate-packing-slip-modal-->
            <div id="generate-packing-slip-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-xl modal-xxl" role="document">
                        <order-packing-slip class="modal-content"
                                        v-if="isGeneratePackingSlip"
                                        :modalIdForGeneratePackingSlip="modalIdForGeneratePackingSlip"
                                        :row-data="selectedSalesForGeneratePackingSlip"
                                        :pre_loader="dueModalPreloader"
                                        @emitForGeneratePackingSlip="emitForGeneratePackingSlip"
                                        :modal-title="trans('lang.generate_packing_slip')"/>
                </div>
            </div>

            <!--generate invoice-->
            <div id="generate-invoice-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-xl modal-xxl" role="document">
                        <invoice-slip class="modal-content"
                                        v-if="isGenerateInvoice"
                                        :modalIdForGenerateInvoice="modalIdForGenerateInvoice"
                                        :row-data="selectedSalesForGenerateInvoice"
                                        :pre_loader="dueModalPreloader"
                                        @emitForGenerateInvoice="emitForGenerateInvoice"
                                        :modal-title="trans('lang.generate_packing_slip')"/>
                </div>
            </div>

            <!-- Generate Payments History -->
            <div id="generate-payments-history-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-xl modal-xxl" role="document">
                        <payments-history class="modal-content"
                                        v-if="isGeneratePaymentsHistory"
                                        :modalIdForGeneratePaymentsHistory="modalIdForGeneratePaymentsHistory"
                                        :row-data="selectedSalesForGeneratePaymentsHistory"
                                        :pre_loader="dueModalPreloader"
                                        @emitForGeneratePaymentsHistory="emitForGeneratePaymentsHistory"
                                        :modal-title="trans('lang.generate_packing_slip')"/>
                </div>
            </div>


            <!-- change order status popup-->
            <div id="change-order-status-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                        <order-status class="modal-content"
                                        v-if="isChangeOrderStatus"
                                        :modalIdForChangeOrderStatus="modalIdForChangeOrderStatus"
                                        :row-data="selectedSalesForChangeOrderStatus"
                                        :pre_loader="dueModalPreloader"
                                        @emitForChangeOrderStatus="emitForChangeOrderStatus"
                                        :modal-title="trans('lang.change_order_status')"/>
                </div>
            </div>

            <!-- Delete Modal -->
            <confirmation-modal id="confirm-delete" :message="'sales_list_deleted_permanently'" :firstButtonName="'yes'"
                                :secondButtonName="'no'"
                                @confirmationModalButtonAction="confirmationModalButtonAction"></confirmation-modal>
        </div>
    </div>
</template>
<script>
    import { json } from 'body-parser';
import axiosGetPost from '../../helper/axiosGetPostCommon';
    // import ordersManagementMixin from './mixin/OrdersManagementMixin';

    export default {
        props: ["current_branch"],
        extends: axiosGetPost,
        // mixins: [ordersManagementMixin],
        data() {
            return {
                isActive: false,
                isDateEditActive: false,
                selectedSalesForDateEdit: null,
                selectedSalesForGeneratePackingSlip: null,
                selectedSalesForChangeOrderStatus: null,
                selectedSalesForGenerateInvoice:null,
                selectedSalesForGeneratePaymentsHistory: null,
                isActiveAttributeModal: false,
                isActiveAttributeModalEdit: false,
                selectedItemId: "",
                modalID: "#due-amount-edit-modal",
                modalIdForSalesDateEdit: "#date-edit-modal",
                modalIdForGeneratePackingSlip: '#generate-packing-slip-modal',
                modalIdForChangeOrderStatus: '#change-order-status-modal',
                modalIdForGenerateInvoice: '#generate-invoice-modal',
                modalIdForGeneratePaymentsHistory: '#generate-payments-history-modal',
                order_type: "sales",
                hidePreLoader: false,
                exportToVue: false,
                buttonLoader: false,
                isDisabled: false,
                isActiveText: false,
                tableOptions: {},
                dueModalPreloader: true,
                tabName: "orders",
                routeName: "orders",
                hasData: value => {
                    return !_.isEmpty(value);
                },
                currentBranch: JSON.parse(this.current_branch),
                isGeneratePackingSlip: false,
                isGenerateInvoice:false,
                isGeneratePaymentsHistory:false,
                isGeneratePackingSlipAttributeModal: false,
                isChangeOrderStatus: false,
                isChangeOrderStatusAttributeModal: false,
                isGenerateInvoiceAttributeModal: false,
                isGeneratePaymentsHistoryAttributeModal: false,
            };
        },
        created() {
            this.getSaleListData();
            
        },
        mounted() {
            let instance = this;
            
            $("#attributes-add-edit-modal").on("hidden.bs.modal", function (e) {
                instance.isActiveAttributeModal = false;
                $("body").addClass("modal-open");
            });

            this.$hub.$on("viewSalesReportEdit", function (rowdata) {
                instance.addEditAction(rowdata);
            });

            this.$hub.$on("editSalesDate", function (rowdata, index) {
                instance.isActiveAttributeModalEdit = false;
                instance.selectedSalesForDateEdit = rowdata;
                instance.isDateEditActive = true;
            });

            this.$hub.$on("generatePackingSlip", function (rowdata, index) {
                instance.isGeneratePackingSlipAttributeModal = false;
                instance.selectedSalesForGeneratePackingSlip = rowdata;
                instance.isGeneratePackingSlip = true;
            });

            this.$hub.$on("generateInvoice", function (rowdata, index) {
                instance.isGenerateInvoiceAttributeModal = false;
                instance.selectedSalesForGenerateInvoice = rowdata;
                instance.isGenerateInvoice = true;
            });

            this.$hub.$on("generatePaymentsHistory", function (rowdata, index) {
                instance.isGeneratePaymentsHistoryAttributeModal = false;
                instance.selectedSalesForGeneratePaymentsHistory = rowdata;
                instance.isGeneratePaymentsHistory = true;
            });

            this.$hub.$on("changeOrderStatus", function (rowdata, index) {
                instance.isChangeOrderStatusAttributeModal = false;
                instance.selectedSalesForChangeOrderStatus = rowdata;
                instance.isChangeOrderStatus = true;
            });

            $("#branch-or-cash-register-select-modal").on(
                "hidden.bs.modal",
                function (e) {
                    instance.$emit("resetBranchAndCashRegisterModal");
                }
            );
        },
        methods: {
            getSaleListData() {
                let instance = this;
                instance.axiosGet(
                    "/sales-due-filter",
                    function (response) {
                        if (response.data) {
                            
                            /*Appending cash register static value(All) with dynamic cash register title from db*/
                            let customers = [
                                {text: "All", value: "all", selected: true},
                                ...response.data.customers
                            ];
                            instance.tableOptions = {
                                tableName: "orders",
                                columns: [
                                    {
                                        title: "lang.invoice_id",
                                        key: "invoice_id_with_count",
                                        type: "clickable_link",
                                        source:"orders/details",
                                        uniquefield:"id",
                                        sortable: true
                                    },
                                    {
                                        title: "lang.sold_to",
                                        key: "customer",
                                        type: "text",
                                        source: "customer",
                                        sortable: true
                                    },
                                    {
                                        title: "lang.customer_phone_number",
                                        key: "phone_number",
                                        type: "text",
                                        sortable: true
                                    },
                                    {
                                        title: "lang.payment_status",
                                        key: "payment_status",
                                        type: "text",
                                        sortable: false,
                                    },
                                    {
                                        title: "lang.order_status",
                                        key: "order_status",
                                        type: "text",
                                        sortable: false,
                                    },
                                    {
                                        title: "lang.sold_by",
                                        key: "created_by",
                                        type: "text",
                                        source: "user",
                                        sortable: true
                                    },
                                    {
                                        title: "lang.sales_date",
                                        key: "date",
                                        type: "text",
                                        sortable: true
                                    },
                                    {
                                        title: "lang.order_delivery_type",
                                        key: "is_delivery_or_pickup",
                                        type: "text",
                                        sortable: true
                                    },
                                    {
                                        title: "lang.order_delivery_date",
                                        key: "delivery_date",
                                        type: "text",
                                        sortable: true
                                    },
                                    {
                                        title: "lang.order_pickup_date",
                                        key: "pickup_date",
                                        type: "text",
                                        sortable: true
                                    },
                                    {
                                        title: "lang.order_days",
                                        key: "days",
                                        type: "text",
                                        sortable: true
                                    },
                                    {
                                        title: "lang.total",
                                        key: "total",
                                        type: "text",
                                        sortable: false
                                    },
                                    {
                                        title: "lang.due",
                                        key: "due_amount",
                                        type: "text",
                                        sortable: false
                                    },
                                    {
                                        title: "lang.action",
                                        type: "component",
                                        componentName: "orders-list-action-component"
                                    }
                                ],
                                source: "/orders/sales-list-data/" + instance.currentBranch.id,
                                summary: true,
                                search: true,
                                sortedBy: "id",
                                sortedType: "DESC",
                                formatting: [
                                    "total",
                                    "sub_total",
                                    "tax",
                                    "discount",
                                    "due_amount"
                                ],
                                dateFormatting: ["date"],
                                right_align: [
                                    "sub_total",
                                    "item_purchased",
                                    "tax",
                                    "discount",
                                    "total",
                                    "due_amount"
                                ],
                                summation: [
                                    "sub_total",
                                    "item_purchased",
                                    "tax",
                                    "discount",
                                    "total",
                                    "due_amount"
                                ],
                                summationKey: ["invoice_id"],
                                filters: [
                                    {
                                        title: "lang.customer",
                                        key: "customers",
                                        type: "dropdown",
                                        languageType: "raw",
                                        options: customers
                                    },
                                    {
                                        title: 'lang.payment_type', type: 'dropdown', key: 'payment_type', options: [
                                            {text: 'lang.all', value: 'all', selected: true},
                                            {text: 'lang.paid', value: 'paid'},
                                            {text: 'lang.due', value: 'due'},
                                        ]
                                    },
                                    {
                                        title: 'lang.order_status', type: 'dropdown', key: 'order_status', options: [
                                            {text: 'lang.all', value: 'all', selected: true},
                                            {text: 'lang.order_status_pending', value: 'pending'},
                                            {text: 'lang.order_status_processing', value: 'processing'},
                                            {text: 'lang.order_status_ready', value: 'ready'},
                                            {text: 'lang.order_status_pickedup', value: 'pickedup'},
                                            {text: 'lang.order_status_cancelled', value: 'cancelled'},
                                        ]
                                    },
                                    {
                                        title: 'lang.order_delivery_type', type: 'dropdown', key: 'delivery_or_pickup', options: [
                                            {text: 'lang.all', value: 'all', selected: true},
                                            {text: 'lang.delivery', value: 'delivery'},
                                            {text: 'lang.pickedup', value: 'pickup'},
                                        ]
                                    }
                                ]
                            };
                        }
                        instance.setPreLoader(true);
                    },
                    function (response) {
                        instance.setPreLoader(true);
                    }
                );
            },
            cartItemsToStore(cartItemsToStore) {
                let instance = this;
                instance.hideSalesReturnsPreLoader = false;
                cartItemsToStore.paymentType = "credit";

                instance.axiosGETorPOST(
                    {
                        url: "/save-due-amount",
                        postData: {cartItemsToStore}
                    },
                    (success, responseData) => {
                        if (success) {
                            //response after then function
                            instance.showSuccessAlert(responseData.message);

                            $(`${this.modalID}`).modal("hide");
                            instance.$hub.$emit("reloadDataTable");
                            instance.hideSalesReturnsPreLoader = true;
                            instance.dueModalPreloader = true;
                        } else {
                            instance.hideSalesReturnsPreLoader = true;
                            instance.dueModalPreloader = true;
                            $(`${this.modalID}`).modal("hide");
                        }
                    }
                );
            },
            emitForIsActive(value) {
                this.isActive = value;
            },
            emitForIsActiveEdit(value) {
                this.isDateEditActive = value;
            },
            emitForGeneratePackingSlip(value) {
                this.isGeneratePackingSlip = value;
            },
            emitForGenerateInvoice(value) {
                this.isGenerateInvoice = value;
            },
            emitForGeneratePaymentsHistory(value) {
                this.isGeneratePaymentsHistory = value;
            },
            emitForChangeOrderStatus(value) {
                this.isChangeOrderStatus = value;
            },
            getActiveAttributeModal(isActive) {
                this.isActiveAttributeModal = isActive;
            },
            getActiveAttributeModal(isDateEditActive) {
                this.isActiveAttributeModalEdit = isDateEditActive;
            },
            exportStatus() {
                this.exportToVue = true;
                this.buttonLoader = true;
                this.isDisabled = true;
            },
            resetExportValue(value) {
                this.exportToVue = value;
                this.buttonLoader = false;
                this.isDisabled = false;
            },
            confirmationModalButtonAction() {
                this.deleteDataMethod('/orders/sales/list/delete/' + this.deleteID, this.deleteIndex);
            },
            printData(value) {
                this.barcodeData = value;
                this.adjustStockProductData = value;
            },
            printBarcode() {
                this.isPrintBarcode = true;
            },

            updateLocalStorageForGenrerateSlip(data, orderId) {
                console.log(data);
                console.log(orderId);
                // for (var i = 0; i < data.length; i++) {
                //     if (data[i][key] === value) {
                //         return array[i];
                //     }
                // }
            }
        }
    };
</script>