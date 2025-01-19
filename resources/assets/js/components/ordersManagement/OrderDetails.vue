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
                    <h4 class="text-center">Order #: {{order.invoice_id}}</h4>
                    <hr>
                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12">
                            <table width="100%"  align="center" style="width: 80%; margin: auto;">
                                <tbody>
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
                                                        <th align="left">Created By</th>
                                                        <th align="left">Updated By</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>&nbsp;</td>
                                                    </tr>
                                                    <tr v-for="(item, index) in order.order_items_logs" :key="index" v-if="item.price > 0" :style="isDifferentOrder(index) ? 'border-bottom: 1px solid #ddd;' : ''">
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
                                                        </td>
                                                        <td style="vertical-align:top; color:#253453;">{{ item.created_by }}</td>
                                                        <td style="vertical-align:top;">{{ item.updated_by }}</td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>                           
                        </div>
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
                order: {}
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
                            instance.order = response.data;
                            console.log(response.data);
                            instance.hidePreLoader = true;
                        },
                        function (response) {

                        },
                    );
                },
                goBack(){
                    let instance = this;
                    instance.redirect(`/${this.routeName}`);
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
                },
                isDifferentOrder(index) {
                    let instance = this;
                    if (index === 0) return true; // Always add border for the first row
                    return instance.order.order_items_logs[index].order_id !== instance.order.order_items_logs[index - 1].order_id;
                }
            },
    }
</script>