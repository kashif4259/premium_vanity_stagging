<template>
    <div>
        <div class="main-layout-wrapper">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb bg-transparent m-0">
                    <li class="breadcrumb-item">
                        <span>{{trans('lang.order_details')}}</span>
                        <span><a href="#" @click="goBack()" >({{trans('lang.back_page')}})</a></span>
                    </li>
                </ol>
            </nav>
            <div class="main-layout-card">
                <div v-if="!hidePreLoader" class="productsLayout">
                    <pre-loader class="modal-layout-content"></pre-loader>
                </div>

                <div v-else class="productsLayout">
                    <h4 class="text-center">Order #: {{ order.invoice_id }}</h4>
                    <hr>
                    <div class="row">
                        <div class="pxs-0 col-12 col-sm-12 col-md-4 col-lg-4 col-xl-4">
                            <img class="img-thumbnail" :src="publicPath+'/uploads/products/' + order.imageURL">
                        </div>
                        <div class="pxs-0 offset-md-1 col-xs-12 col-sm-12 col-md-7 col-lg-7 col-xl-7">
                            <table class="table mb-0 product-detail-table">
                                <tr v-if="order.cat_name !== null">
                                    <th>{{ trans('lang.category') }}</th>
                                    <td>{{order.cat_name}}</td>
                                </tr>
                                <tr v-if="order.brand_name !== null">
                                    <th>{{ trans('lang.brand') }}</th>
                                    <td>{{order.brand_name}}</td>
                                </tr>
                                <tr>
                                    <th>{{ trans('lang.description') }}</th>
                                    <td>{{order.product_des}}</td>
                                </tr>
                                <tr>
                                    <th>{{ trans('lang.created_by') }}</th>
                                    <td>{{order.created_by}}</td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div class="variantData" v-if="order.product_variations !== null">
                        <datatable-component class="main-layout-card-content"
                                             :options="tableOptions"></datatable-component>
                    </div>
                </div>
                
            </div>
        </div>
    </div>
</template>

<script>
    import axiosGetPost from '../../helper/axiosGetPostCommon';

    export default {
        extends: axiosGetPost,
        props: ['id','tab_name', 'route_name'],
        data() {
            return {
                hidePreLoader: true,
                order: {},
                tableOptions: {
                    tableName: 'orders',
                    columns: [
                        
                        {title: 'lang.product_title', key: 'title', type: 'text', sortable: true},
                        {title: 'lang.item_qtty', key: 'item_purchased', type: 'text', sortable: false},
                        {title: 'lang.created_by', key: 'created_by', type: 'text', sortable: true},
                        {title: 'lang.date', key: 'date', type: 'text', sortable: true},
                        // {title: 'lang.vanity_color', key: 'color', type: 'text', sortable: true},
                        // {title: 'lang.vanity_size', key: 'size', type: 'text', sortable: true},
                    ],
                    source: '/orders/audit/details/' + this.id,
                },
            }
        },

        created() {
            this.getOrderDetails('/orders/getDetails/' + this.id);
        },
        mounted(){
            this.tabName = this.tab_name;
            this.routeName = this.route_name;
        },
        methods: {
            getOrderDetails(route) {
                    let instance = this;
                    instance.hidePreLoader = false;
                    instance.axiosGet(route,
                        function (response) {
                            instance.order = response.data.orderDetails;
                            console.log(response.data.orderDetails);
                            instance.hidePreLoader = true;
                        },
                        function (response) {

                        },
                    );
                },
                goBack(){
                    let instance = this;
                    instance.redirect(`/${this.routeName}`);
                }
            },
    }
</script>