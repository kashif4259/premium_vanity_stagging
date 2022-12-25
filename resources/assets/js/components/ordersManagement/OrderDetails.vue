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
                // hidePreLoader: true,
                // price: '',
                // purchase_price: '',
                // selling_price: '',
                // products: {},
                // tableOptions: {
                //     tableName: 'products',
                //     columns: [
                //         {
                //             title: 'lang.item_image',
                //             key: 'image',
                //             type: 'images',
                //             source: '/uploads/products',
                //             imagefield: 'imageURL',
                //             sortable: false
                //         },
                //         {title: 'lang.variant_title', key: 'variant_title', type: 'text', sortable: true},
                //         {title: 'lang.attribute_values', key: 'attribute_values', type: 'text', sortable: false},
                //         {title: 'lang.selling_price', key: 'selling_price', type: 'text', sortable: true},
                //         {title: 'lang.receiving_price', key: 'purchase_price', type: 'text', sortable: true},
                //     ],
                //     formatting : ['selling_price','purchase_price'],
                //     source: '/products/variantDetails/' + this.id,
                // },
            }
        },

        created() {
            // this.getProductDetails('/products/getDetails/' + this.id);
        },
        mounted(){
            this.tabName = this.tab_name;
            this.routeName = this.route_name;
        },
        methods: {
                // getProductDetails(route) {
                //     let instance = this;
                //     instance.hidePreLoader = false;
                //     instance.axiosGet(route,
                //         function (response) {
                //             instance.products = response.data.productDetails;
                //             if (instance.products.taxable === 0) {
                //                 instance.products.taxable = instance.trans('lang.no_tax');
                //             }
                //             else {
                //                 instance.products.taxable = instance.products.tax_type;
                //             }
                //             let productType = response.data.productDetails.product_type;
                //             if (productType === 'standard') {
                //                 instance.price = response.data.variant.price;
                //                 instance.purchase_price = response.data.variant.purchase_price;
                //                 instance.selling_price = response.data.variant.selling_price;
                //             }
                //             instance.hidePreLoader = true;
                //         },
                //         function (response) {

                //         },
                //     );
                // },
                goBack(){
                    let instance = this;
                    instance.redirect(`/${this.routeName}`);
                }
            },
    }
</script>