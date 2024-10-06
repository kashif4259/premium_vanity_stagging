<template>
    <div class="main-layout-wrapper">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb bg-transparent m-0">
                <li class="breadcrumb-item">
                    <span>{{trans('lang.todos')}}</span>
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
                        <h5 class="m-0">Todos List</h5>
                    </div>
                    <div class="main-layout-card-header-contents text-right d-flex justify-content-end">
                        <div class="p-1">
                            <button class="btn btn-primary app-color"
                                    @click.prevent="addEditAction(''), openProductModal()">
                                {{ trans('lang.add') }}
                            </button>
                        </div>
                        
                    </div>
                </div>
            </div>
            <!-- <div class="modal fade"
                 id="todos-add-edit-modal"
                 tabindex="-1"
                 role="dialog"
                 aria-labelledby="myLargeModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <todos-add-edit-common-modal :id="selectedItemId"
                                                       :modalID="modalID"/>
                    </div>
                </div>
            </div> -->
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
                <!-- <div class="modal fade"
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
                </div> -->
                <!-- Modal date edit-->
    
                <!-- <div id="date-edit-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                            <sale-date-edit class="modal-content"
                                            v-if="isDateEditActive"
                                            :modalIdForSalesDateEdit="modalIdForSalesDateEdit"
                                            :row-data="selectedSalesForDateEdit"
                                            :pre_loader="dueModalPreloader"
                                            @emitForIsActiveEdit="emitForIsActiveEdit"
                                            :modal-title="trans('lang.sales_date_edit')"/>
                    </div>
                </div> -->


                

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
                isActiveTodo: false,
                isActive: false,
                isDateEditActive: false,
                selectedSalesForDateEdit: null,
                selectedSalesForGeneratePackingSlip: null,
                selectedSalesForChangeOrderStatus: null,
                isActiveAttributeModal: false,
                isActiveAttributeModalEdit: false,
                selectedItemId: "",
                modalID: "#due-amount-edit-modal",
                modalIdForSalesDateEdit: "#date-edit-modal",
                modalIdForGeneratePackingSlip: '#generate-packing-slip-modal',
                modalIdForChangeOrderStatus: '#change-order-status-modal',
                order_type: "sales",
                hidePreLoader: false,
                exportToVue: false,
                buttonLoader: false,
                isDisabled: false,
                isActiveText: false,
                tableOptions: {},
                dueModalPreloader: true,
                tabName: "todos",
                routeName: "todos",
                hasData: value => {
                    return !_.isEmpty(value);
                },
                currentBranch: JSON.parse(this.current_branch),
                isGeneratePackingSlip: false,
                isGeneratePackingSlipAttributeModal: false,
                isChangeOrderStatus: false,
                isChangeOrderStatusAttributeModal: false,
                modalID: "#todos-add-edit-modal",
            };
        },
        created() {
            this.getTotdosListData();
        },
        mounted() {
            let instance = this;
            

            // this.$hub.$on("productEdit", function (id) {
            //     instance.isActiveProduct = true;
            //     instance.addEditAction(id);
            // });

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
            getTotdosListData() {
                let instance = this;
                instance.axiosGet(
                    "/todos/filters",
                    function (response) {
                        if (response.data) {
                            /*Appending cash register static value(All) with dynamic cash register title from db*/
                            // let customers = [
                            //     {text: "All", value: "all", selected: true},
                            //     ...response.data.customers
                            // ];
                            instance.tableOptions = {
                                tableName: "todos",
                                columns: [
                                    {
                                        title: "lang.to_do_title",
                                        key: "title",
                                        type: "text",
                                        sortable: true
                                    },
                                    {
                                        title: "lang.assigned_to",
                                        key: "assigned_to",
                                        type: "text",
                                        sortable: true
                                    },
                                    {
                                        title: "lang.log_status",
                                        key: "completed",
                                        type: "text",
                                        sortable: false,
                                    },
                                    {
                                        title: "lang.assigned_by",
                                        key: "created_by",
                                        type: "text",
                                        sortable: false,
                                    },
                                    {
                                        title: "lang.note",
                                        key: "description",
                                        type: "text",
                                        sortable: true
                                    },
                                    {
                                        title: "lang.action",
                                        type: "component",
                                        componentName: "totos-list-action-component"
                                    }
                                ],
                                source: "/todos/list/",
                                summary: false,
                                search: true,
                                sortedBy: "id",
                                sortedType: "DESC",
                                // formatting: [
                                //     "total",
                                //     "sub_total",
                                //     "tax",
                                //     "discount",
                                //     "due_amount"
                                // ],
                                // dateFormatting: ["date"],
                                // right_align: [
                                //     "sub_total",
                                //     "item_purchased",
                                //     "tax",
                                //     "discount",
                                //     "total",
                                //     "due_amount"
                                // ],
                                // summation: [
                                //     "sub_total",
                                //     "item_purchased",
                                //     "tax",
                                //     "discount",
                                //     "total",
                                //     "due_amount"
                                // ],
                                summationKey: ["to_do_title"],
                                // filters: [
                                //     {
                                //         title: "lang.customer",
                                //         key: "customers",
                                //         type: "dropdown",
                                //         languageType: "raw",
                                //         options: customers
                                //     },
                                //     {
                                //         title: 'lang.payment_type', type: 'dropdown', key: 'payment_type', options: [
                                //             {text: 'lang.all', value: 'all', selected: true},
                                //             {text: 'lang.paid', value: 'paid'},
                                //             {text: 'lang.due', value: 'due'},
                                //         ]
                                //     },
                                //     {
                                //         title: 'lang.order_status', type: 'dropdown', key: 'order_status', options: [
                                //             {text: 'lang.all', value: 'all', selected: true},
                                //             {text: 'lang.order_status_pending', value: 'pending'},
                                //             {text: 'lang.order_status_processing', value: 'processing'},
                                //             {text: 'lang.order_status_ready', value: 'ready'},
                                //             {text: 'lang.order_status_pickedup', value: 'pickedup'},
                                //             {text: 'lang.order_status_cancelled', value: 'cancelled'},
                                //         ]
                                //     }
                                // ]
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
            openProductModal() {
                this.isActiveTodo = true;
                $("#todos-add-edit-modal").modal("show");
            },
        }
    };
</script>