<template id="change-order-status">
    <div class="p-3">
        <div class="row mb-4">
            <div class="col-md-6">
                <h5>{{ modalTitle }}</h5>
            </div>
            <div class="col-md-5 text-right payment-amount">
            </div>
            <div class="col-md-1 text-right">
                <a href="#" data-dismiss="modal" aria-label="Close" class="close">
                    <i class="la la-close text-grey"/>
                </a>
            </div>
        </div>
        <div>
            <pre-loader v-if="!hideEditSalesDatePreloader"/>
            <div v-else>
                <div>
                    <div class="row mb-3">
                        <label class="col-md-4 col-form-label">{{trans('lang.sales_date')}}</label>
                        <div class="col-md-8 pl-0">
                            <select     
                                v-validate="'required'"
                                data-vv-as="order status"
                                id="orderStatus"
                                name="orderStatus"
                                class="form-control"
                                v-model="orderStatus"
                                >
                                <option value="" disabled selected>{{ trans('lang.choose_one') }}</option>
                                <option value="Ready" v-if="order.order_status == 'Processing' ">Ready</option>
                                <option value="Pickedup" v-if="order.order_status == 'Ready' ">Pickedup</option>
                            </select>
                            <div class="heightError">
                                <small class="text-danger" v-show="errors.has('orderStatus')">
                                    {{ errors.first('orderStatus') }}
                                </small>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <hr class="custom-margin"/>

                        <span class="col-md-12 mt-3">
                            <button class="btn btn-block app-color payment-button"
                                @click.prevent="updateOrderStatus()">
                                {{ trans('lang.save') }}
                            </button>
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import axiosGetPost from "../../../helper/axiosGetPostCommon";
    // import Datepicker from 'vuejs-datepicker';

    export default {
        extends: axiosGetPost,
        props: ["rowData", "modalIdForChangeOrderStatus", "modalTitle", "orderType", "pre_loader"],
        // components: {
        //     Datepicker
        // },
        data() {
            return {
                // date: null,
                order: '',
                orderStatus:'',
            };
        },
        created() {

            
            this.hideEditSalesDatePreloader = this.pre_loader;
            // this.hidePaymentListGetLoader = true;
        },
        mounted() {
            this.order = this.rowData;
            let instance = this;
            $("#change-order-status-modal").on("hidden.bs.modal", function (e) {
                instance.$emit("emitForChangeOrderStatus", false);
            });
        },

        watch: {
            pre_loader: function (value) {
                this.hideEditSalesDatePreloader = value;
            }
        },

        methods: {
            updateOrderStatus() {
                this.submitted = true;
                this.$validator.validateAll().then((result) => {
                    if (result) {
                        if (this.rowData.id) {
                            this.postDataMethod('/orders/updateOrderStatus/' + this.rowData.id, {
                                'order_status': this.orderStatus
                            });
                        }
                    }
                });

            },
            postDataThenFunctionality() {
                $(this.modalIdForChangeOrderStatus).modal('hide');
            },
            postDataCatchFunctionality() {
                $(this.modalIdForChangeOrderStatus).modal('hide');
            }
        }
    };
</script>
