<template>
    <span>
        
        <div id="cart-section-1" class="modal-layout-header p-0">
            <div class="p-2">
                <h6 class="m-0 cart-product-details-parent">
                    <div class="cart-product-details-child" v-if="theOrderDetails.order_customer">
                        {{ theOrderDetails.order_customer.fullName }}
                        <br>
                         <small v-show="theOrderDetails.order_customer.email != null"> <i
                             class="la la-envelope"></i> {{ theOrderDetails.order_customer.email }}</small>
                         <small v-show="theOrderDetails.order_customer.phone_number != null"> <i
                             class="la la-phone-square"></i> {{ theOrderDetails.order_customer.phone_number }}</small>
                    </div>
                </h6>
            </div>
        </div>

        <div id="cart-section-2" class="cart-items-wrapper"
             :class="{'h-100 d-flex align-items-center justify-content-center' : parseInt(cart.length) === 0}">
            <span v-if="parseInt(cart.length) === 0">
                {{ trans('lang.empty_cart') }}
            </span>
            <div v-else class="cart-item-container py-1" v-for="(cartItem,index) in cart"
                 :class="{'active-cart-item': cartItem.showItemCollapse }"
                 
                 v-if="cartItem.orderType != 'delivery' && 
                        (
                            cartItem.price !== undefined &&
                            cartItem.price !== null &&
                            cartItem.price !== '' &&
                            parseFloat(cartItem.price) > 0
                        )
                 "
                 >
                <template >
                    <div class="form-row mx-0 px-1 cart-item">
                        <div class="col-6 p-0 cart-item-btn"
                            @click.prevent="cartItemCollapse(index,cartItem.variantID)">
                            <div class="row mx-0 my-auto">
                                <div class="col-1 p-0 m-auto">
                                    <i class="la la-chevron-circle-right la-2x cart-icon"
                                     @click="updateCustomization(cartItem, index)"></i>
                                </div>
                                <div class="col-11  my-auto mx-0 pr-0">
                                    <div class="row mx-0 cart-item-title"
                                        :class="{cartProduct: cartItem.productID == activeProductId && cartItem.variantID == activeVariantId && cartItem.orderType !== 'discount'}">
                                        <div class="col-12 pl-1 p-0 my-auto mx-0">
                                            {{ cartItem.productTitle }}
                                            <br>

                                            <span
                                                v-if="cartItem.variantTitle && cartItem.variantTitle !== 'default_variant' && cartItem.orderType !== 'discount'">( {{
                                                    cartItem.variantTitle
                                                }} )</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-3 my-auto px-0 ml-3 mr-0">
                            <div class="d-flex justify-content-between mr-1 cart-quantity">
                                <div class="pl-0 mx-0" v-if="cartItem.categoryID !== 1">
                                    <a href="#"
                                    :class="{disabled:cartItem.orderType ==='discount' || (salesOrReturnType ==='returns' && order_type === 'sales') || (order_type === 'receiving' && receiveOrReturnType === 'returns')}"
                                    @click.prevent="cartItemButtonAction(cartItem.productID,cartItem.variantID,cartItem.orderType,'-')">
                                        <i class="la la-minus-circle la-2x cart-icon-color"></i>
                                    </a>
                                </div>
                                <div class="align-self-center">
                                    {{ numberFormatting(cartItem.quantity) }}
                                </div>
                                <div class="" v-if="cartItem.categoryID !== 1">
                                    <a href="#"
                                    :class="{disabled:cartItem.orderType ==='discount'}"
                                    @click.prevent="cartItemButtonAction(cartItem.productID,cartItem.variantID,cartItem.orderType,'+')">
                                        <i class="la la-plus-circle la-2x cart-icon-color"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="col-3 d-flex pr-0 pl-0 cart-calculatedPrice">
                            <div class="align-self-center ml-auto">
                                <span>{{ numberFormat(cartItem.calculatedPrice) }}</span>
                            </div>
                            <div v-if="salesOrReturnType !== 'returns'" class="align-self-center ml-2">
                                <a href="#" class="red-text"
                                :class="{disabled:cart.length == 1 && !isConnected && offline == 1}"
                                @click.prevent="cartItemButtonAction(cartItem.productID,cartItem.variantID,cartItem.orderType,'delete')"><i
                                    class="la la-trash del-icon-color"></i></a>
                            </div>
                            <div v-else class="align-self-center ml-2">
                                <a href="#" class="red-text"
                                :class="{disabled: (cart.length == 2 && !isConnected && offline == 1) || (cartItem.orderType === 'discount' && (cart.length == return_cart_length || cart.length == 2))}"
                                @click.prevent="cartItemButtonAction(cartItem.productID,cartItem.variantID,cartItem.orderType,'delete')"><i
                                    class="la la-trash del-icon-color"></i></a>
                            </div>
                        </div>
                    </div>
                    <div class="form-row mx-0 px-2  collapse-animation"
                        style="overflow:auto !important;">
                        <div class="form-group pl-0 mb-zero" :class="[checkDiscount() ? 'col-4':'col-6']">
                            <label :for="'cart-item-quantity'+index" class="label-in-cart " v-if="cartItem.categoryID !== 1">
                                {{ trans('lang.quantity') }}</label>
                            <payment-input :id="'cart-item-quantity'+index"
                                        :inputValue="numberFormatting(cartItem.quantity)" :index="index"
                                        @input="setQuantityInCart">
                            </payment-input>
                        </div>
                        <div class="form-group pr-0 mb-zero" :class="[checkDiscount() ? 'col-4':'col-6']"
                            v-if="order_type ==='receiving' || manage_price == 1 ">
                            <label :for="'cart-item-price'+index" class="label-in-cart">{{ trans('lang.price') }}</label>
                            <payment-input :id="'cart-item-price'+index"
                                        :inputValue="cartItem.unformPrice" :index="index"
                                        @input="setProductNewPrice"></payment-input>
                        </div>
                        <div class="form-group pr-0 mb-zero" :class="[checkDiscount() ? 'col-4':'col-6']"
                            v-if="checkDiscountType()">
                            <label :for="'cart-item-discount'+index" class="label-in-cart w-100">
                                {{ trans('lang.item_discount') }} (%)
                            </label>
                            <div class="position-relative">
                                <payment-input :id="'cart-item-discount'+index" v-model="cartItem.discount"
                                            :inputValue="discount"
                                            @input="setCartItemsToCookieOrDB(1)">
                                </payment-input>
                            </div>
                        </div>
                        <div class="col-12 p-0 pb-2">
                            <label :for="'cart-item-note'+index" class="label-in-cart">{{ trans('lang.note') }}</label>
                            <textarea :id="'cart-item-note'+index"
                                    @keyup="setCartItemsToCookieOrDB(1)"
                                    class="form-control"
                                    v-model="cartItem.cartItemNote">
                            </textarea>
                        </div>
                    </div>

                    <div v-if="cartItem.categoryID == 1">
                    <!-- Start row 4 For Drawers-->
                    <div class="form-row mx-0 px-2  collapse-animation"
                         :class="{'collapsed':cartItem.showItemCollapse}" style="overflow:auto !important;">
                         <div class="form-group pl-0 mb-zero col-6" v-if="cartItem.isCustomization">
                            <label :for="'cart-drawerside-on-drawers-door' + index" class="label-in-cart">
                                Drawers Side
                            </label>
                            <select class="custom-select custom-tax-calculate"  v-model="cartItem.product_variations.drawer_side">
                                <option value="">Select Value</option>
                                <option value="left">Left</option>
                                <option value="right">Right</option>
                            </select>
                        </div>

                        <div class="form-group pl-0 mb-zero col-6" v-if="cartItem.isCustomization">
                            <label :for="'cart-wallside' + index" class="label-in-cart">
                                Wall Side
                            </label>
                            <select class="custom-select custom-tax-calculate"  v-model="cartItem.product_variations.wall_side">
                                <option value="">Select Value</option>
                                <option value="left">Left</option>
                                <option value="right">Right</option>
                                <option value="wall_to_wall">Wall to Wall</option>
                                <option value="free_standing">Freestanding</option>
                            </select>
                        </div>
                        
                    </div><!-- End row 4-->

                    <!-- start row 3 For Fillers -->
                    <div class="form-row mx-0 px-2  collapse-animation"
                         :class="{'collapsed':cartItem.showItemCollapse}" style="overflow:auto !important;">
                        
                         <div class="form-group pl-0 mb-zero col-4"  v-if="cartItem.isCustomization">
                            <label :for="'cart-vanity-filler'+index" class="label-in-cart ">
                                Select Filler</label>
                                <select class="custom-select custom-tax-calculate" v-model="cartItem.product_variations.filler" @change="fillerSize($event.target.value, cartItem, index)">
                                    <option value="">Select Filler</option>
                                    <option value="yes">Yes</option>
                                    <option value="no">No</option>
                                </select>
                        </div>
                        
                        <div class="form-group pl-0 mb-zero col-4"  v-if="cartItem.isCustomization">
                            <label :for="'cart-vanity-filler-quantity'+index" class="label-in-cart ">
                                Filler Quantity</label>
                                <select class="custom-select custom-tax-calculate"  v-model="cartItem.product_variations.filler_quantity">
                                    <option value="0">Select Quantity</option>
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                </select>
                        </div>
    
                        <div class="form-group pl-0 mb-zero col-4" v-if="cartItem.isCustomization">
                            <label :for="'cart-vanity-filler-size'+index" class="label-in-cart ">
                                {{ trans('lang.vanity_size') }}</label>
                                <input type="text"
                                    step="0.01"
                                    min="0"
                                    class="form-control" value="0.5" v-model="cartItem.product_variations.filler_size" @input="validateNumber(cartItem)">
                        </div>
                    </div><!-- End row 3-->
    
                    <!-- Start row 4 For Handles-->
                    <div class="form-row mx-0 px-2  collapse-animation"
                         :class="{'collapsed':cartItem.showItemCollapse}" style="overflow:auto !important;">
                         <div class="form-group pl-0 mb-zero col-3" v-if="cartItem.isCustomization">
                            <label :for="'cart-vanity-handles-on-drawers-door' + index" class="label-in-cart">
                                Handles On Drawers/Door
                            </label>
                            <select class="custom-select custom-tax-calculate"  v-model="cartItem.product_variations.handle_drawer_or_door" @change="getHandlesForVanity($event.target.value, cartItem, index)">
                                <option value="">Select Value</option>
                                <option value="drawers">Drawers</option>
                                <option value="door">Door</option>
                                <option value="both">Both</option>
                            </select>
                        </div>
    
                        <div class="form-group pl-0 mb-zero col-3" v-if="cartItem.isCustomization">
                            <label :for="'cart-vanity-handles' + index" class="label-in-cart">
                                Handles
                            </label>
                            <select class="custom-select custom-tax-calculate"  v-model="cartItem.product_variations.handles">
                                <option value="">Select Handles</option>
                            </select>
                        </div>
    
                        <div class="form-group pl-0 mb-zero col-3" v-if="cartItem.isCustomization">
                            <label :for="'cart-vanity-handles-quantity' + index" class="label-in-cart">
                                Quantity
                            </label>
                            <input type="text"
                                class="form-control" v-model="cartItem.product_variations.handles_quantity">
                        </div>
    
                        <div class="form-group pl-0 mb-zero col-3" v-if="cartItem.isCustomization">
                            <label :for="'cart-vanity-handles-others' + index" class="label-in-cart">
                                Others
                            </label>
                            <input type="text"
                                class="form-control" v-model="cartItem.product_variations.other_hanldes">
                        </div>
    
                    </div><!-- End row 4-->
    
                    <!-- Start row 4 For Knobs-->
                    <div class="form-row mx-0 px-2  collapse-animation"
                         :class="{'collapsed':cartItem.showItemCollapse}" style="overflow:auto !important;">
                         <div class="form-group pl-0 mb-zero col-3" v-if="cartItem.isCustomization">
                            <label :for="'cart-vanity-knobs-on-drawers-door' + index" class="label-in-cart">
                                Knobs On Drawers/Door
                            </label>
                            <select class="custom-select custom-tax-calculate"  v-model="cartItem.product_variations.knobs_drawer_or_door" @change="getKnobsForVanity($event.target.value, cartItem, index)">
                                <option value="">Select Value</option>
                                <option value="drawers">Drawers</option>
                                <option value="door">Door</option>
                                <option value="both">Both</option>
                            </select>
                        </div>
    
                        <div class="form-group pl-0 mb-zero col-3" v-if="cartItem.isCustomization">
                            <label :for="'cart-vanity-knobs' + index" class="label-in-cart">
                                Knobs
                            </label>
                            <select class="custom-select custom-tax-calculate"  v-model="cartItem.product_variations.knobs">
                                <option value="">Select Knobs</option>
                            </select>
                        </div>
                        
                        <div class="form-group pl-0 mb-zero col-3" v-if="cartItem.isCustomization">
                            <label :for="'cart-vanity-knob-quantity' + index" class="label-in-cart">
                                Quantity
                            </label>
                            <input type="text"
                                class="form-control" v-model="cartItem.product_variations.knobs_quantity">
                        </div>
    
                        <div class="form-group pl-0 mb-zero col-3" v-if="cartItem.isCustomization">
                            <label :for="'cart-vanity-knob-others' + index" class="label-in-cart">
                                Others
                            </label>
                            <input type="text"
                                class="form-control" v-model="cartItem.product_variations.other_knobs">
                        </div>
                    </div><!-- End row 4-->

                    <!-- Start row 4 For Counter Top-->
                    <div class="form-row mx-0 px-2  collapse-animation"
                         :class="{'collapsed':cartItem.showItemCollapse}" style="overflow:auto !important;">
                         <div class="form-group pl-0 mb-zero col-3" v-if="cartItem.isCustomization">
                            <label :for="'cart-vanity-counter-top-yes-no' + index" class="label-in-cart">
                                Counter Top
                            </label>
                            <select class="custom-select custom-tax-calculate"  v-model="cartItem.product_variations.counter_top_yes_no" @change="getCounterTopForVanity($event.target.value, cartItem, index)">
                                <option value="">Select Value</option>
                                <option value="yes">Yes</option>
                                <option value="no">No</option>
                            </select>
                        </div>
    
                        <div class="form-group pl-0 mb-zero col-3" v-if="cartItem.isCustomization">
                            <label :for="'cart-vanity-counter-top' + index" class="label-in-cart">
                                Select Counter Top
                            </label>
                            <select class="custom-select custom-tax-calculate"  v-model="cartItem.product_variations.counter_top">
                                <option value="">Select Counter Top</option>
                            </select>
                        </div>
                        
                        <div class="form-group pl-0 mb-zero col-2" v-if="cartItem.isCustomization">
                            <label :for="'cart-vanity-counter-top-side-splash' + index" class="label-in-cart">
                                Side Splash
                            </label>
                            <select class="custom-select custom-tax-calculate"  v-model="cartItem.product_variations.counter_top_side_splash">
                                <option value="0">Select Value</option>
                                <option value="left">Left</option>
                                <option value="right">Right</option>
                                <option value="both">Both</option>
                            </select>
                        </div>

                        <div class="form-group pl-0 mb-zero col-2" v-if="cartItem.isCustomization">
                            <label :for="'cart-vanity-counter-top-back-splash' + index" class="label-in-cart">
                                Back Splash
                            </label>
                            <select class="custom-select custom-tax-calculate"  v-model="cartItem.product_variations.counter_top_back_splash">
                                <option value="0">Select Value</option>
                                <option value="yes">Yes</option>
                                <option value="no">No</option>
                            </select>
                        </div>

                        <div class="form-group pl-0 mb-zero col-2" v-if="cartItem.isCustomization">
                            <label :for="'cart-vanity-counter-top-faucet-hole' + index" class="label-in-cart">
                                Faucet Hole
                            </label>
                            <select class="custom-select custom-tax-calculate"  v-model="cartItem.product_variations.counter_top_faucet_hole">
                                <option value="">Select Value</option>
                                <option value="single">Single</option>
                                <option value="four_inches">Four Inches</option>
                                <option value="eight_inches">Eight Inches</option>
                            </select>
                        </div>

                    </div><!-- End row 4-->

                </div>



                </template> 
            </div>
        </div>

        <div id="cart-section-3" class="position-absolute fixed-bottom product-card-font">
            <div class="row mx-0 px-3 py-2 font-weight-bold border-top border-bottom">
                <div class="col-6 p-0">
                    {{ trans('lang.sub_total') }}
                </div>
                <div class="col-6 p-0 text-right">
                    {{ numberFormat(subTotal) }}
                </div>
            </div>
            <div class="row mx-0 px-3 py-2  border-bottom" v-if="this.sales_or_receiving_type !== 'internal-transfer'">
                <div class="col-6 p-0">
                    Calculate Tax
                </div>
                <div class="col-6 p-0 text-right">
                    <select class="custom-select custom-tax-calculate" 
                        @change="onChangeTaxPercent($event)" 
                        v-model="taxPercentage"
                    >
                        <option value="0">0%</option>
                        <option value="13">13%</option>
                    </select>

                    <!-- <input type="number" @keyup="updateTaxOnTotal(tax)" class="form-control" v-model="tax">  -->
                </div>
            </div>
            <div class="row mx-0 px-3 py-2  border-bottom" v-if="this.sales_or_receiving_type !== 'internal-transfer'">
                <div class="col-6 p-0">
                    Tax
                </div>
                <div class="col-6 p-0 text-right">
                    {{ numberFormat(tax) }}
                </div>
            </div>
            <!-- <div class="row mx-0 px-3 py-2  border-bottom" id="pop_mouse1" v-popover:foo.right
                 v-if="this.sales_or_receiving_type !== 'internal-transfer'">
                <div class="col-6 p-0">
                    {{ trans('lang.discount_all_items_by_percent') }} (%)
                    <popover name="foo">
                        <payment-input :inputValue="newDiscount"
                                       :salesOrReturnType="salesOrReturnType"
                                       @input="allProductDiscount"
                                       :discountField="discountOnAllItem">
                        </payment-input>
                    </popover>
                </div>
                <div class="col-3 p-0 text-center">
                    <div class="btn-group dropright" role="group"></div>
                </div>
                <div class="col-3 p-0 text-right">
                    <span v-if="discount">
                        <i class="la la-edit discount-all-item-popover"></i>{{ decimalFormat(discount) + '%' }}
                    </span>
                    <span v-else>
                        <i class="la la-edit discount-all-item-popover"></i>{{ numberFormat(discount) + '%' }}
                    </span>
                </div>
            </div> -->
            <!-- <div class="row mx-0 px-3 py-2" id="pop_mouse2" v-popover:foo1.right
                 v-if="sales_or_receiving_type !== 'internal-transfer'">
                <div class="col-6 p-0">
                    {{ trans('lang.discount_on_sub_total') }}
                </div>

                <div class="col-3 p-0 text-center">
                    <div class="btn-group dropright" role="group">
                        <popover name="foo1">
                            <payment-input :inputValue="newOverAllDiscount"
                                           :productTotalWithoutDiscount="productTotalWithoutDiscount"
                                           :salesOrReturnType="salesOrReturnType"
                                           @input="addOverAllDiscount">
                            </payment-input>
                        </popover>
                    </div>
                </div>
                <div class="col-3 p-0 text-right">
                    <span v-if="overAllDiscount">
                        <i class="la la-edit discount-on-subtotal-popover"></i>{{ numberFormat(newOverAllDiscount) }}
                    </span>
                    <span v-else>
                        <i class="la la-edit discount-on-subtotal-popover"></i>{{ numberFormat(newOverAllDiscount) }}
                    </span>
                </div>
            </div> -->

            <!-- <div class="row mx-0 px-3 py-2" id="pop_mouse2" v-popover:foo1.right
                 v-if="sales_or_receiving_type !== 'internal-transfer'">
                <div class="col-6 p-0">
                    Deilvery Charges
                </div>

                <div class="col-3 p-0 text-center">
                    <div class="btn-group dropright" role="group">
                        <popover name="foo1">
                            <payment-input :inputValue="deliveryCharges"
                                           :productTotalWithoutDiscount="productTotalWithoutDiscount"
                                           :salesOrReturnType="salesOrReturnType"
                                           @input="editOrderDeliveryCharges">
                            </payment-input>
                        </popover>
                    </div>
                </div>
                <div class="col-3 p-0 text-right">
                    <span v-if="overAllDiscount">
                        <i class="la la-edit discount-on-subtotal-popover"></i>{{ numberFormat(deliveryCharges) }}
                    </span>
                    <span v-else>
                        <i class="la la-edit discount-on-subtotal-popover"></i>{{ numberFormat(deliveryCharges) }}
                    </span>
                </div>
            </div>

            <div class="row mx-0 px-3 py-2"
                 v-if="sales_or_receiving_type !== 'internal-transfer' && adjustedDiscount">
               <div class="col-6 p-0">
                   {{ trans('lang.discount_adjustment') }}
               </div>
               <div class="col-6 p-0 text-right">
                    {{ numberFormat(adjustedDiscount) }}
               </div>
           </div> -->

            <!-- Total amount section with tax exclude and include -->
            <div class="row mx-0 px-3 py-2 border-top border-bottom">
                <div class="col-6 p-0">
                    <span class="font-weight-bold">
                        {{ trans('lang.total') }}
                    </span>
                    <!-- <span
                        v-if="currentBranch !== null && salesOrReturnType!=='returns' && order_type === 'sales' && this.sales_or_receiving_type !== 'internal-transfer'">
                        <span class="">( {{ trans('lang.tax') }}</span>
                        <span v-if="parseInt(user.tax_excluded) === 0">{{ trans('lang.included') }})</span>
                        <span v-else>Total</span>
                    </span> -->
                    
                </div>

                <div class="col-3 p-0 text-center">
                    <div class="btn-group dropright" role="group">
                        <!-- This div for middle space -->
                    </div>
                </div>

                <div class="col-3 p-0 text-right">
                    <!-- <span
                        v-if="currentBranch !== null && salesOrReturnType!=='returns' && order_type === 'sales' && sales_or_receiving_type !== 'internal-transfer'">
                        <a class=""
                           data-toggle="modal"
                           data-target="#tax-edit-modal"
                           href="#"
                           :class="{'disabled':!isConnected}"
                           @click.prevent="taxEditModalOpen"
                        ><i class="la la-edit discount-all-item-popover"></i></a>
                    </span> -->
                    <span class="col-6 p-0 font-weight-bold text-right">
                    {{ numberFormat(grandTotal) }}
                </span>
                </div>
            </div>

            <!-- Start Template for Restaurant Module -->
            <div class="row mx-0 px-3 py-2 font-weight-bold border-bottom"
                 v-if="currentBranch !== null && currentBranch.branch_type === 'restaurant' && salesOrReturnType!=='returns' && salesOrReceivingType === 'customer'">
                <div class="col-4 p-0 custom-line-height">
                    {{ trans('lang.order_type') }}
                </div>
                <div class="col-8 p-0 text-right">
                    <button class="btn btn-restaurant-order-type mr-2"
                            :class="{'selected-btn-restaurant-order-type': restaurantOrderType === 'dineIn'}"
                            @click.prevent="setRestaurantOrderType('dineIn')">
                        <i class="la la-cutlery"></i> {{ trans('lang.dine_in') }}
                    </button>
                    <button class="btn btn-restaurant-order-type"
                            :class="{'selected-btn-restaurant-order-type': restaurantOrderType === 'takeAway'}"
                            @click.prevent="setRestaurantOrderType('takeAway')">
                        <i class="la la-shopping-cart"></i> {{ trans('lang.take_away') }}
                    </button>
                </div>
            </div>
            <!-- Place order button for restaurant -->
            <div class="p-3 border-bottom"
                 v-if="currentBranch !== null && currentBranch.branch_type === 'restaurant' && restaurantOrderType === 'dineIn' && (salesOrReceivingType !== 'internal' || salesOrReceivingType === 'internal-transfer') && salesOrReturnType !== 'returns' && order_type === 'sales' && isPlaceOrderActive">
                <button class="btn pay-btn app-color"
                        href="#"
                        @click.prevent="openTableModal"
                        :disabled="enableDisablePay() || disabledPay() || !isConnected && parseInt(offline) === 0 || isHoldOrderDone === true">
                        Update Order
                </button>
            </div>

            <!-- Pay button for restaurant -->
            <div
                v-if="currentBranch !== null && currentBranch.branch_type === 'restaurant' && salesOrReceivingType === 'customer' && !isPlaceOrderActive"
                class="p-3 border-bottom">
                <button class="btn pay-btn app-color"
                        data-toggle="modal"
                        data-target="#cart-payment-modal"
                        href="#"
                        @click.prevent="cartSave()"
                        :disabled="enableDisablePay() || disabledPay() || !isConnected && offline == 0"
                        v-shortkey="payment_short_key"
                        @shortkey="commonMethodForAccessingShortcut('payShortcut')">
                        Update Order
                </button>
            </div>
            <!-- End Template for Restaurant Module -->
            <div class="p-3 border-bottom"
                 v-if="salesOrReceivingType == 'internal' || salesOrReceivingType == 'internal-transfer'">
                <button class="btn pay-btn app-color"
                        data-toggle="modal"
                        data-target="#cart-payment-modal"
                        href="#"
                        @click.prevent="cartSave()"
                        :disabled="selectedSearchBranch == 0 || enableDisablePay() || disabledPay() || !isConnected && offline == 0"
                        v-shortkey="payment_short_key"
                        @shortkey="commonMethodForAccessingShortcut('payShortcut')">
                        Update Order
                </button>
            </div>

           <div
               v-if="(currentBranch !== null && currentBranch.branch_type !== 'restaurant' && salesOrReceivingType !== 'internal' && salesOrReceivingType !== 'internal-transfer') || (currentBranch !== null && currentBranch.branch_type === 'restaurant' && salesOrReceivingType != 'internal'  && (order_type === 'receiving' || salesOrReturnType =='returns'))"
               class="p-3 border-bottom">
               <button class="btn pay-btn app-color"
                       data-toggle="modal"
                       data-target="#cart-payment-modal"
                       href="#"
                       @click.prevent="cartSave()"
                       :disabled="enableDisablePay() || disabledPay() || (!isConnected && offline == 0) || (!isConnected && order_type == 'receiving')"
                       v-shortkey="payment_short_key"
                       @shortkey="commonMethodForAccessingShortcut('payShortcut')">
                       Update Order
               </button>
           </div>

            
            <div v-else class="row mx-0 receiveDeleteButton">
                <a href="#"
                   data-toggle="modal"
                   data-target="#clear-cart-modal"
                   class="col-12 p-0 text-center clear-cart"
                   :class="{'disabled': parseInt(cart.length) === 0}"
                   @click.prevent="">
                    <i class="la la-times-circle la-2x p-2 text-danger"></i>
                </a>
            </div>
        </div>

    </span>
</template>

<script>
import axiosGetPost from '../../../helper/axiosGetPostCommon';

export default {
    extends: axiosGetPost,
    props: [
        'supplier',
        'is_selected_branch',
        'selected_branch_id',
        'add_customer',
        'newAddedCustomer',
        'sales_or_receiving_type',
        'sales_return_status',
        'receive_return_status',
        'order_type',
        'order_id',
        'order_id_internal_transfer',
        'customer_group',
        'offline_customers',
        'offline_all_Branch',
        'current_branch',
        'user',
        'cart_arr',
        'active_variant_id',
        'active_product_id',
        'manage_price',
        'selectedCashRegisterID',
        'sold_to',
        'sold_by',
        'final_cart',
        'invoice_logo',
        'last_invoice_number',
        'invoicePrefix',
        'invoiceSuffix',
        'invoiceTemplate',

        'bankOrCardAmount',
        'bankOrCardOptions',
        'calculateBank',
        'auto_invoice',
        'payment_types',
        'selectedBranchID',
        'is_shipment_enable',

        'sub_total',
        'grand_total',
        'tax',

        'count_hold_order',
        'order_hold_items',
        'internal_hold_orders',
        'internal_transfer_hold_orders',
        'customer_hold_orders',
        'customer_not_added',
        'selected_customer',
        'selected_search_branch',
        'branch_search_value',

        'restaurant_order_type',
        'restaurant_table_id',
        'is_cash_register_branch',
        'is_cash_register_used',
        'is_hold_order_done',
        'is_place_order_active',
        'all_restaurant_tables',
        'profit',
        'is_connected',
        'new_over_all_discount',
        'over_all_discount',
        'newDiscount_amount',
        'discount_amount',
        'tax_amount',
        'add_customer_short_key',
        'payment_short_key',
        'hold_card_item',
        'cancel_card_item',
        'shipping_data',
        'return_cart_length',
        'invoice_size',
        'adjusted_discount',
        'edit_order_details'
    ],
    data() {
        return {
            parseInt,
            adjustedDiscount: 0,
            hideCustomerSearchPreLoader: true,
            salesOrReceivingType: '',
            salesOrReturnType: null,
            receiveOrReturnType: null,
            isPaymentModalActive: false,
            customerNotAdded: true,
            selectedCustomer: [],
            customerSearchValue: '',
            customers: [],
            addCustomer: null,
            isCustomerModalActive: false,
            isNewCustomerAdded: false,
            offlineCustomers: [],
            newCustomerId: '',
            branchSearchValue: '',
            isSelectedBranch: null,
            branches: [],
            selectedSearchBranch: [],
            offlineAllBranch: [],
            currentBranch: [],
            selectedBranchId: null,
            open: null,
            highlightIndex: 0,
            newOverAllDiscount: 0,
            showOverAllDisc: false,
            showDiscount: false,
            discountOnEntire: 'discountOnEntire',
            discountOnAllItem: 'discountOnAllItem',
            //cart variables
            cart: [],
            finalCart: [],
            newCart: [],
            total: 0,
            grandTotal: 0,
            subTotal: 0,
            productTotalWithoutDiscount: 0,

            orderID: null,
            orderIdInternalTransfer: null,
            invoiceId: null,
            lastInvoiceNumber: 0,
            //product
            activeProductId: null,
            activeVariantId: null,

            //local storage
            totalStorage: 4500,
            remainingStorage: null,
            minimumSizeOfLocalStorage: 500,

            orderHoldItems: [],
            internalHoldOrders: [],
            internalTransferHoldOrders: [],
            customerHoldOrders: [],
            countHoldOrder: 0,
            hideOrderHoldItemsPreLoader: false,

            payment: [],
            holdCarditem: [],
            cancelCarditem: [],
            donePaymentItem: [],

            restaurantOrderType: '',
            isCashRegisterBranch: '',
            restaurantTableId: '',
            isHoldOrderDone: '',
            isTaxExcluded: true,
            isPlaceOrderActive: null,
            allRestaurantTables: [],
            isConnected: null,
            discount: 0,
            newDiscount: 0,
            // tax: 0,
            cartLength: 0,
            discountEnable: false,
            returnDiscount: true,
            overAllDiscount: 0,
            isEmptyObj: (object) => {
                if (_.isEmpty(object)) {
                    return true;
                }
            },
            // Shortcuts Variable
            addCustomerShortKey: '',
            paymentShortKey: '',
            holdCardItem: '',
            cancelCardItem: '',
            isDisableCartPlusBtn: false,
            deliveryCharges: 0,
            productTotalWithoutDeliveryCharges: 0,
            theOrderDetails:false,
            taxPercentage:"0"
        }
    },
    watch: {
        //on the fly discount calculation
        over_all_discount: function (value) {
            if (value != null && value !== '') {
                this.showOverAllDisc = true;
                this.showDiscount = true;
            } else {
                this.showOverAllDisc = false;
                this.showDiscount = false;
            }
            this.overAllDiscount = value;

        },
        sales_or_receiving_type: function (value) {
            this.salesOrReceivingType = value;
        },
        is_selected_branch: function (value) {
            this.isSelectedBranch = value;
        },
        selected_branch_id: function (value) {
            this.selectedBranchID = value;
        },
        add_customer: function (value) {
            this.addCustomer = value;
        },
        cart_arr: function (value) {
            this.cart = value;
            this.cartLength = value.length;

            this.cartMinHeightSet();
        },
        sales_return_status: function (value) {
            this.salesOrReturnType = value;
        },
        receive_return_status: function (value) {
            this.receiveOrReturnType = value;
        },
        active_variant_id: function (value) {
            this.activeVariantId = value;
        },
        active_product_id: function (value) {
            this.activeProductId = value;
        },
        final_cart: function (value) {
            this.finalCart = value;
        },
        sub_total: function (value) {
            this.subTotal = value;
        },
        grand_total: function (value) {
            this.grandTotal = value;
        },
        newAddedCustomer: function (value) {
            this.getCustomerData(value);
        },
        count_hold_order: function (value) {
            this.countHoldOrder = value;
        },
        order_hold_items: function (value) {
            this.orderHoldItems = value;
        },
        internal_hold_orders: function (value) {
            this.internalHoldOrders = value;
        },
        internal_transfer_hold_orders: function (value) {
            this.internalTransferHoldOrders = value;
        },
        customer_hold_orders: function (value) {
            this.customerHoldOrders = value;
        },
        customer_not_added: function (value) {
            this.customerNotAdded = value;
        },
        selected_customer: function (value) {
            this.selectedCustomer = value;
        },
        selected_search_branch: function (value) {
            this.selectedSearchBranch = value;
        },
        branch_search_value: function (value) {

        },
        restaurant_order_type: function (value) {
            this.restaurantOrderType = value;
        },
        current_branch: function (value) {
            this.currentBranch = value;
        },
        is_cash_register_branch: function (value) {
            this.isCashRegisterBranch = value;
        },
        restaurant_table_id: function (value) {
            this.restaurantTableId = value;
        },
        last_invoice_number: function (value) {
            this.lastInvoiceNumber = value;
        },
        is_hold_order_done: function (value) {
            this.isHoldOrderDone = value;
        },
        is_place_order_active: function (value) {
            this.isPlaceOrderActive = value;
        },
        offline_customers: function (value) {
            this.offlineCustomers = value;
        },
        offline_all_Branch: function (value) {
            this.offlineAllBranch = value;
        },
        order_id: function (value) {
            this.orderID = value;
        },
        order_id_internal_transfer: function (value) {
            this.orderIdInternalTransfer = value;
        },
        all_restaurant_tables: function (value) {
            this.allRestaurantTables = value;
        },
        is_connected: function (value) {
            this.isConnected = value;
        },
        new_over_all_discount: function (value) {
            this.newOverAllDiscount = value;
        },
        discount_amount: function (value) {
            this.discount = value;
        },
        tax_amount: function (value) {
            this.tax = value;
        },
        newDiscount_amount: function (value) {
            this.newDiscount = value;
        },
        add_customer_short_key: function (value) {
            this.addCustomerShortKey = value;
        },
        payment_short_key: function (value) {
            this.paymentShortKey = value;
        },
        hold_card_item: function (value) {
            this.holdCardItem = value;
        },
        cancel_card_item: function (value) {
            this.cancelCardItem = value;
        },
        adjusted_discount: function (value) {
            this.adjustedDiscount = value;
        },
    },
    created() {
        this.isTaxExcluded = parseInt(this.user.tax_excluded) !== 0;
        this.setTaxIncludedOrExcluded(this.isTaxExcluded);
    },
    mounted() {
        let instance = this;
        this.isSelectedBranch = this.is_selected_branch;
        this.addCustomer = this.add_customer;
        this.salesOrReceivingType = this.sales_or_receiving_type;
        this.cart = this.cart_arr;
        this.salesOrReturnType = this.sales_return_status;
        this.receiveOrReturnType = this.receive_return_status;
        this.activeVariantId = this.active_variant_id;
        this.activeProductId = this.active_product_id;
        this.finalCart = this.final_cart;
        this.grandTotal = this.grand_total;
        this.subTotal = this.sub_total;
        this.selectedBranchID = this.selected_branch_id;
        this.countHoldOrder = this.count_hold_order;
        this.orderHoldItems = this.order_hold_items;
        this.internalHoldOrders = this.internal_hold_orders;
        this.internalTransferHoldOrders = this.internal_transfer_hold_orders;
        this.customerHoldOrders = this.customer_hold_orders;
        this.customerNotAdded = this.customer_not_added;
        this.selectedCustomer = this.selected_customer;
        this.selectedSearchBranch = this.selected_search_branch;
        this.restaurantOrderType = this.restaurant_order_type;
        this.currentBranch = this.current_branch;
        this.isCashRegisterBranch = this.is_cash_register_branch;
        this.restaurantTableId = this.restaurant_table_id;
        this.customerSearchValue = '';
        this.branchSearchValue = '';
        this.lastInvoiceNumber = this.last_invoice_number;
        this.isHoldOrderDone = this.is_hold_order_done;
        this.isPlaceOrderActive = this.is_place_order_active;
        this.offlineCustomers = this.offline_customers;
        this.offlineAllBranch = this.offline_all_Branch;
        this.orderID = this.order_id;
        this.orderIdInternalTransfer = this.order_id_internal_transfer;
        this.allRestaurantTables = this.all_restaurant_tables;
        this.isConnected = this.is_connected;
        this.newOverAllDiscount = this.new_over_all_discount;
        this.discount = this.discount_amount;
        this.tax = this.tax_amount;
        this.newDiscount = this.newDiscount_amount;
        this.overAllDiscount = this.over_all_discount;
        this.addCustomerShortKey = this.add_customer_short_key;
        this.paymentShortKey = this.payment_short_key;
        this.holdCardItem = this.hold_card_item;
        this.cancelCardItem = this.cancel_card_item;
        // Set cart items wrapper height dynamically
        this.$nextTick(function () {
            instance.cartMinHeightSet();
        });
        $(window).resize(function () {
            setTimeout(function () {
                instance.cartMinHeightSet();
            });
        });

        this.modalCloseAction(this.modalID);
        // cart modal for mobile
        $('#cart-modal-for-mobile-view').on('shown.bs.modal', function (e) {
            instance.cartMinHeightSet();
        });
        
        this.theOrderDetails = JSON.parse(this.edit_order_details)
        console.log("theOrderDetails > ", this.theOrderDetails);
        console.log("tax ==> ",this.theOrderDetails.tax_percentage);
        
        this.taxPercentage = this.theOrderDetails.tax_percentage
        
        // this.grandTotal = this.theOrderDetails.total;
        // this.tax = this.theOrderDetails.total_tax;
        this.deliveryCharges = this.theOrderDetails.delivery_charges;
        // this.discountOnAllItem = this.theOrderDetails.all_discount;
        // this.newOverAllDiscount = this.theOrderDetails.all_discount;
    },
    methods: {
        checkDiscountType() {
            if (this.order_type === 'sales') {
                return this.sales_or_receiving_type !== 'internal-transfer';

            }
            return false;

        },
        checkDiscount() {
            if (this.manage_price == 1) {
                return this.sales_or_receiving_type !== 'internal-transfer';

            }
        },
        cartMinHeightSet() {
            let section1 = $("#cart-section-1").height();
            let section2 = $("#cart-section-3").position();
            $("#cart-section-2").css('max-height', (section2.top - section1) + 'px');
        },
        /* customer*/
        newCustomerAddModalOpen() {
            this.$emit('newCustomerAddModalOpen');
        },
        taxEditModalOpen() {
            this.$emit('taxEditModal');
        },
        storeCustomer() {
            $('#customer-add-edit-modal').modal('show')
            this.isCustomerModalActive = true;
        },
        searchCustomerInput() {
            let instance = this;
            if (!this.open) {
                this.open = true
            }
            this.highlightIndex = 0;
            let sortedResults;

            if (instance.order_type === 'sales') {
                sortedResults = instance.offlineCustomers;
                instance.commonCustomerSupplierSearch(sortedResults);
            } else {
                sortedResults = JSON.parse(instance.supplier);
                instance.commonCustomerSupplierSearch(sortedResults);
            }

            instance.hideCustomerSearchPreLoader = true;
        },
        commonCustomerSupplierSearch(sortedResults) {
            let instance = this;
            if (instance.customerSearchValue) {
                instance.customers = sortedResults.filter(function (element) {
                    let firstName = element.first_name.toLowerCase().includes(instance.customerSearchValue.toLowerCase()),
                        lastName = element.last_name.toLowerCase().includes(instance.customerSearchValue.toLowerCase()),
                        fullName = element.first_name + ' ' + element.last_name,
                        fullNameSearch = fullName.toLowerCase().includes(instance.customerSearchValue.toLowerCase());

                    if ((element.email != null && element.email != '') || (element.phone_number != null && element.phone_number != '')) {
                        if ((element.email != null && element.email != '') && (element.phone_number != null && element.phone_number != '')) {
                            return (firstName || lastName || fullNameSearch
                                || element.email.toLowerCase().includes(instance.customerSearchValue.toLowerCase())
                                || element.phone_number.includes(instance.customerSearchValue.toLowerCase())
                            );

                        } else if ((element.email != null && element.email != '')) {
                            return (firstName || lastName || fullNameSearch
                                || element.email.toLowerCase().includes(instance.customerSearchValue.toLowerCase())
                            );
                        } else {
                            return (firstName || lastName || fullNameSearch
                                || element.phone_number.includes(instance.customerSearchValue.toLowerCase())
                            );
                        }
                    } else {
                        return (firstName || lastName || fullNameSearch);
                    }
                });
            } else {
                instance.customers = sortedResults;
            }
        },
        selectCustomer(customer) {
            this.selectedCustomer = [];
            this.selectedCustomer.push(customer);
            this.$emit('selectCustomerFromCart', this.selectedCustomer);

            if (this.order_type === 'sales') {

                let customerGroups = JSON.parse(this.customer_group);

                if (customer.customer_group_discount != undefined) {
                    this.allProductDiscount(customer.customer_group_discount);
                } else {
                    let customerCurrentGroup = customerGroups.find(function (element) {
                        return element.id == customer.customer_group;
                    })
                    this.allProductDiscount(customerCurrentGroup.discount)
                }
            }

            this.setCartItemsToCookieOrDB(1);
            this.customerSearchValue = '';
        },
        getCustomerData(data) {
            let instance = this;
            instance.customers = this.offlineCustomers;
            if (instance.isNewCustomerAdded) {
                instance.selectCustomer(0);
            }
            instance.isNewCustomerAdded = false;
            instance.hideCustomerSearchPreLoader = true;
            if (data) {
                instance.selectCustomer(data);
                instance.newCustomerId = '';

            } else {
                let customer = instance.customers.filter(function (element) {
                    return parseInt(element.id) === parseInt(instance.newCustomerId);
                });
                instance.selectCustomer(customer[0]);
            }
        },
        removeSelectedCustomer(index) {
            this.selectedCustomer.splice(index, 1);
            this.customerSearchValue = '';
            this.discount = null;
            this.allProductDiscount();
            this.setCartItemsToCookieOrDB(1);
            this.$emit('removeSelectedCustomerFromCart', this.selectedCustomer);
        },
        // branch
        searchBranchInput(event) {
            let instance = this;
            instance.hideCustomerSearchPreLoader = false;
            if (!this.open) {
                this.open = true
            }
            this.highlightIndex = 0;
            let sortedResults;
            sortedResults = instance.offlineAllBranch;
            if (instance.branchSearchValue) {

                instance.branches = sortedResults.filter(function (element) {
                    return (element.name.toLowerCase().includes(instance.branchSearchValue.toLowerCase()) && element.id !== instance.currentBranch.id);
                });
            } else {
                instance.branches = sortedResults;
            }
            instance.hideCustomerSearchPreLoader = true;

        },
        selectSearchBranch(branch) {
            this.$emit('selectSearchBranchFromCart', branch);
            this.branchSearchValue = '';
        },
        removeSelectedBranch() {
            this.$emit('removeSelectedBranchFromCart');
            this.branchSearchValue = '';
        },

        allProductDiscount(value, index, unformatted) {
            this.$emit('allProductDiscountFromCart', Number(value), index, unformatted);
        },
        editOrderDeliveryCharges(value, index, unformatted) {
            console.log("edited value",value);
            this.deliveryCharges = value;
            this.$emit("editOrderDeliveryChargesFromCart",Number(value), index, unformatted);
        },
        onChangeTaxPercent(event) {
            console.log("tax percentage ",event.target.value);
            this.taxPercentage = event.target.value;
            this.$emit("onChangeTaxPercent", this.taxPercentage);
        },

        addOverAllDiscount(value, index, unformatted) {
            this.$emit('addOverAllDiscountFromCart', value, index, unformatted);
        },
        cartItemButtonAction(cartProductID, cartVariantID, orderType, action) {
            let instance = this;
            instance.$emit('returnCartChange', true);
            this.cart.forEach(function (cartItem, index, cartArray) {
                if (cartItem.productID == cartProductID && cartItem.variantID == cartVariantID) {

                    if (action === '+') {
                        cartArray[index].quantity++;

                        if (cartArray[index].quantity >= cartArray[index].availbleQuantity && instance.order_type === 'sales' && instance.outOfStockProduct == 1) {
                            instance.isDisableCartPlusBtn = true;
                        }
                        if (cartArray[index].quantity > cartArray[index].availbleQuantity && instance.order_type === 'sales') {
                            let variantTitle = cartArray[index].variantTitle === 'default_variant' ? '' : `(${cartArray[index].variantTitle})`;
                            let alertMessage = cartArray[index].productTitle + ' ' + variantTitle + ' ' + instance.trans('lang.is_out_of_stock');
                            instance.showWarningAlert(alertMessage);
                        }
                        if (parseInt(cartItem.quantity) === 0) {
                            cartArray.splice(index, 1);
                        }
                        if ((instance.order_type === 'sales' && instance.salesOrReturnType === 'returns') || (instance.order_type === 'receiving' && instance.receiveOrReturnType === 'returns')) {
                            cartItem.calculatedPrice = cartItem.quantity * cartItem.price;
                        }
                    } else if (action === '-') {
                        --cartArray[index].quantity;

                        if (cartArray[index].quantity < cartArray[index].availbleQuantity) {
                            instance.isDisableCartPlusBtn = false;
                        }
                        if (parseInt(cartItem.quantity) === 0) {
                            cartArray.splice(index, 1);
                        }
                    } else {
                        if (orderType === 'discount') {
                            instance.overAllDiscount = null;
                            instance.newOverAllDiscount = null;
                        }
                        cartArray.splice(index, 1);
                    }
                }

                if (parseInt(instance.cart.length) === 0) {
                    instance.discount = null;
                    instance.newdiscount = null;
                    instance.newOverAllDiscount = 0;
                    instance.adjustedDiscount = 0;
                }
            });
            this.setCartItemsToCookieOrDB(1);
        },
        cartItemCollapse(index, variantID) {
            let instance = this;
            this.cart.forEach(function (cartItem, i, array) {
                if (parseInt(i) === parseInt(index) && cartItem.variantID === variantID && cartItem.orderType !== 'discount' && !(instance.order_type === 'sales' && instance.salesOrReturnType === 'returns')) {
                    array[i].showItemCollapse = !array[i].showItemCollapse;
                } else {
                    array[i].showItemCollapse = false;
                }
            });
        },
        setQuantityInCart(value, index) {
            let instance = this;
            value = Number(value);
            if (parseInt(this.outOfStockProduct) === 1 && value > this.cart[index].availbleQuantity && this.order_type === 'sales') {
                this.cart[index].quantity = 0;
                this.isDisableCartPlusBtn = true;
                let variantTitle = this.cart[index].variantTitle === 'default_variant' ? '' : `(${this.cart[index].variantTitle})`;
                let alertMessage = this.cart[index].productTitle + ' ' + variantTitle + '' + this.trans('lang.is_out_of_stock') + this.trans('lang.available_quantity') + this.cart[index].availbleQuantity;
                this.showWarningAlert(alertMessage);
                setTimeout(function () {
                    instance.cart[index].quantity = instance.cart[index].availbleQuantity;
                });
            } else {
                this.cart[index].quantity = value;
                this.isDisableCartPlusBtn = false;
            }
            if (this.cart[index].quantity > this.cart[index].availbleQuantity && this.order_type === 'sales') {
                let variantTitle = this.cart[index].variantTitle === 'default_variant' ? '' : `(${this.cart[index].variantTitle})`;
                let alertMessage = this.cart[index].productTitle + ' ' + variantTitle + '' + this.trans('lang.is_out_of_stock') + this.trans('lang.available_quantity') + this.cart[index].availbleQuantity;
                this.showWarningAlert(alertMessage);
            }
            this.setCartItemsToCookieOrDB(1);
        },
        setProductNewPrice(price, index, value) {
            this.cart[index].price = price;
            this.cart[index].unformPrice = value;
            this.setCartItemsToCookieOrDB(1);
        },
        enableDisablePay() {

            let cartData = this.cart.filter(function (element) {
                // console.log("element.orderType =>",element.orderType);
                if(element.orderType == "sales"){
                    return true;
                }
            });
            return parseInt(cartData.length) === 0;
        },
        disabledPay() {
            let instance = this;
            let data = '',
                currentStorage = null;
            instance.totalStorage = 4500;

            for (let key in window.localStorage) {
                if (window.localStorage.hasOwnProperty(key)) {
                    data += window.localStorage[key];
                }
            }
            currentStorage = ((data.length * 16) / (8 * 1024)).toFixed(2);

            if (this.checkBrowser() === "Chrome") {
                // navigator.webkitPersistentStorage.requestQuota(webkitStorageInfo.PERSISTENT, function (usage, total) {
                //     if (total != 0) instance.totalStorage = total;
                //     instance.remainingStorage = instance.totalStorage - currentStorage;
                // });

                navigator.webkitPersistentStorage.queryUsageAndQuota ( 
                    function (usage, total) {
                    if (total != 0) instance.totalStorage = total;
                    instance.remainingStorage = instance.totalStorage - currentStorage;
                }
                );
                return instance.remainingStorage < instance.minimumSizeOfLocalStorage;
            } else {
                instance.remainingStorage = instance.totalStorage - currentStorage;
                return instance.remainingStorage < instance.minimumSizeOfLocalStorage;
            }
        },

        orderHold() {
            this.cartSave('hold');
        },
        cartSave(status = 'done') {
            this.updateCartWithCustomization();
            this.makeFinalCart(status);
            if (status === 'done') {
                this.isPaymentModalActive = true;
                this.$emit('activeCartPaymentModal', this.finalCart);
            }
            if (status === 'hold') {
                this.$emit('orderHoldFromCart');
            }
        },
        makeFinalCart(status) {
            let selectCustomerForCart = [];

            if (this.selectedCustomer[0]) {
                selectCustomerForCart = this.selectedCustomer[0];
            }
            this.finalCart = {
                orderID: this.orderID,
                orderIdInternalTransfer: this.orderIdInternalTransfer,
                orderType: this.order_type,
                salesOrReceivingType: this.salesOrReceivingType,
                createdBy: this.user.id,
                status: status,
                cart: this.cart,
                customer: selectCustomerForCart,
                subTotal: this.subTotal,
                discount: this.discount,
                overAllDiscount: this.overAllDiscount,
                tax: this.tax,
                profit: this.profit,
                grandTotal: this.grandTotal,
                cartNote: '',
                branchId: this.selectedBranchID,
                tableId: this.restaurantTableId,
                transferBranch: this.selectedSearchBranch.id,
                transferBranchName: this.selectedSearchBranch.name,
                date: moment().format('YYYY-MM-DD h:mm A'),
                time: moment().format('YYYY-MM-DD h:mm A'),
                taxPercentage: this.taxPercentage
            };

        },
        async updateCartWithCustomization() {
            let newItemForFillers = {};
            let newItemForHandles = {};
            let newItemForKnobs = {};
            let newItemForCounterTop = {};

            console.log('updateCartWithCustomization > ====');
            console.log(this.cart);
            console.log('updateCartWithCustomization < ====');

            for (const item of this.cart) {
                let productVariations = item.product_variations;
                /**
                 * This block for counter top
                 */
                if ( productVariations.counter_top != '' && productVariations.counter_top > 0 && productVariations.counter_top_yes_no == 'yes') {
                    try {
                        // Use axiosGETorPOSTAsync method
                        const productDetails = await this.axiosGETorPOSTAsync(this, {
                            url: `/get-product-by-id/${productVariations.counter_top}`,
                        });

                        newItemForCounterTop = this.updateCartItem(productVariations,productDetails,item,'counter_top');
                    } catch (error) {
                        console.error("Error fetching product details:", error);
                    }
                }

                /**
                 * This block for handles
                 */
                if(productVariations.handle_drawer_or_door != '' && productVariations.handles > 0 && productVariations.handles_quantity > 0){
                    try {
                        // Use axiosGETorPOSTAsync method
                        const productDetails = await this.axiosGETorPOSTAsync(this, {
                            url: `/get-product-by-id/${productVariations.handles}`,
                        });

                        newItemForHandles = this.updateCartItem(productVariations,productDetails,item,'handles');
                    } catch (error) {
                        console.error("Error fetching product details:", error);
                    }
                }

                /**
                 * This block for fillers
                 */
                 if(productVariations.filler != '' && productVariations.filler > 0 && productVariations.filler_quantity > 0){
                    try {
                        // Use axiosGETorPOSTAsync method
                        const productDetails = await this.axiosGETorPOSTAsync(this, {
                            url: `/get-product-by-id/${productVariations.filler}`,
                        });

                        newItemForFillers = this.updateCartItem(productVariations,productDetails,item,'fillers');
                    } catch (error) {
                        console.error("Error fetching product details:", error);
                    }
                }

                /**
                 * This block for knobs
                 */
                 if(productVariations.knobs_drawer_or_door != '' && productVariations.knobs > 0 && productVariations.knobs_quantity > 0){
                    try {
                        // Use axiosGETorPOSTAsync method
                        const productDetails = await this.axiosGETorPOSTAsync(this, {
                            url: `/get-product-by-id/${productVariations.knobs}`,
                        });

                        newItemForKnobs = this.updateCartItem(productVariations,productDetails,item,'knobs');
                    } catch (error) {
                        console.error("Error fetching product details:", error);
                    }
                }

                if (
                    Object.keys(newItemForKnobs).length &&
                    !this.cart.some(cartItem => cartItem.productID === newItemForKnobs.productID)
                ) {
                    this.cart.push(newItemForKnobs);
                }

                if (
                    Object.keys(newItemForFillers).length &&
                    !this.cart.some(cartItem => cartItem.productID === newItemForFillers.productID)
                ) {
                    this.cart.push(newItemForFillers);
                }

                if (
                    Object.keys(newItemForHandles).length &&
                    !this.cart.some(cartItem => cartItem.productID === newItemForHandles.productID)
                ) {
                    this.cart.push(newItemForHandles);
                }

                if (
                    Object.keys(newItemForCounterTop).length &&
                    !this.cart.some(cartItem => cartItem.productID === newItemForCounterTop.productID)
                ) {
                    this.cart.push(newItemForCounterTop);
                }
            }

            
        },

        updateCartItem(productVariations,productDetails, item, type){
            let cartQuantity = '';
            switch (type) {
                case 'handles':
                    cartQuantity = productVariations.handles_quantity;
                break;
                case 'knobs':
                    cartQuantity = productVariations.knobs_quantity;
                break;
                case 'fillers':
                    cartQuantity = productVariations.filler_quantity;
                break;
                case 'counter_top':
                    cartQuantity = 1;
                break;
                default:
                    cartQuantity = '';
            }
            return {
                availbleQuantity: productDetails.product_quantity,
                calculatedPrice: 0,
                cartItemNote: item.cartItemNote,
                categoryID: item.categoryID,
                discount: 0,
                isCustomization: false,
                orderType: item.orderType,
                orderTypeForDeliveryCharges: item.orderTypeForDeliveryCharges,
                price: 0,
                productID: productDetails.id,
                productTaxPercentage: item.productTaxPercentage,
                productTitle: productDetails.title,
                product_variations: {
                    color: "",
                    counter_top: "",
                    counter_top_back_splash: "",
                    counter_top_side_splash: "",
                    counter_top_yes_no: "",
                    drawer_side: "",
                    filler: "",
                    filler_quantity: 0,
                    filler_size: "",
                    handle_drawer_or_door: "",
                    handles: "",
                    handles_quantity: 0,
                    hole: "",
                    knobs: "",
                    knobs_drawer_or_door: "",
                    knobs_quantity: 0,
                    other_hanldes: "",
                    other_knobs: "",
                    showFillerSize: false,
                    wall_side: "",
                },
                purchase_price: 0,
                quantity: cartQuantity,
                showItemCollapse: false,
                taxID: item.taxID,
                unformPrice: 0,
                variantID: productDetails.id,
                variantTitle: item.variantTitle,
            }
        },
        
        setCartItemsToCookieOrDB(flag = 0) {
            this.$emit('setCartItemsToCookieOrDBFromCart', flag);
        },
        up() {
            if (this.open) {
                if (this.highlightIndex > 0) {
                    this.highlightIndex--
                }
            } else {
                this.setOpen(true)
            }
        },
        down() {
            if (this.open) {
                if (this.highlightIndex < this.customers.length - 1 || this.highlightIndex < this.branches.length - 1) {
                    this.highlightIndex++
                }
            } else {
                this.setOpen(true)
            }
        },
        commonMethodForAccessingShortcut(data) {

            if (data === 'addCustomerShortcut' && parseInt(this.shortcutKeyInfo.addCustomerShortcut.status) === 1 && parseInt(this.shortcutStatus) === 1) {
                $('#customer-add-edit-modal').modal('show');
                this.newCustomerAddModalOpen();
            }
            if (data === 'payShortcut' && this.shortcutKeyInfo.payShortcut.status == 1 && this.shortcutStatus == 1 && this.cart.length != 0) {
                if (this.salesOrReceivingType === 'internal') {
                    if (!this.isEmptyObj(this.selectedSearchBranch)) {
                        $('#cart-payment-modal').modal('show');
                        this.cartSave();
                    }
                } else if (this.salesOrReceivingType === 'internal-transfer') {
                    if (!this.isEmptyObj(this.selectedSearchBranch)) {
                        $('#cart-payment-modal').modal('show');
                        this.cartSave();
                    }
                } else {
                    $('#cart-payment-modal').modal('show');
                    this.cartSave();
                }
            }
            if (data === 'holdCard' && this.shortcutKeyInfo.holdCardShortcut.status == 1 && this.shortcutStatus == 1 && this.cart.length != 0) {
                if (this.salesOrReceivingType === 'internal') {
                    if (!this.isEmptyObj(this.selectedSearchBranch)) {
                        this.orderHold();
                    }
                } else if (this.salesOrReceivingType === 'internal-transfer') {
                    if (!this.isEmptyObj(this.selectedSearchBranch)) {
                        this.orderHold();
                    }
                } else {
                    this.orderHold();
                }
            }
            if (data == 'cancelCarditem' && this.shortcutKeyInfo.cancelCardShortcut.status == 1 && this.shortcutStatus == 1 && this.cart.length != 0) {
                $('#clear-cart-modal').modal('show');
            }
        },

        //restaurant module
        openTableModal() {
            this.makeFinalCart('hold');
            this.$emit('openTableModalFromCart', this.finalCart);
        },
        setRestaurantOrderType(type) {
            this.$emit('setRestaurantOrderTypeFromCart', type);
        },
        openHoldOrderModal() {
            this.$emit('openHoldOrderModalFromCart');
        },
        setTaxIncludedOrExcluded(value) {
            this.isTaxExcluded = value;
            this.$emit('setTaxIncludedOrExcludedFromCart', this.isTaxExcluded);
        },

        updateCustomization(cartItem, index){
            console.log('updateCustomization > =======');
            console.log(cartItem);
            console.log('updateCustomization > =======');
            this.getHandlesForVanity(cartItem.product_variations.handles, cartItem, index, cartItem.product_variations.handles);
            this.getKnobsForVanity(cartItem.product_variations.knobs, cartItem, index, cartItem.product_variations.knobs);
            this.getCounterTopForVanity(cartItem.product_variations.counter_top_yes_no, cartItem, index, cartItem.product_variations.counter_top)
        },

        fillerSize(value, cartItem, index, selected_filler_size) {
            if(value == 'yes'){
                // this.getFillersForVanity(value, cartItem, index);
                cartItem.product_variations.showFillerSize = !!value;
                // if (value === "1" || value === "2") {
                cartItem.product_variations.filler_size = 0.5;
                // } 
            }else{
                
                cartItem.product_variations.filler_size = ""; 
            }


            
        },
        validateNumber(cartItem) {
            const regex = /^\d*\.?\d*$/;
            if (!regex.test(cartItem.product_variations.filler_size)) {
                cartItem.product_variations.filler_size = cartItem.product_variations.filler_size.slice(0, -1);
            }
        },

        async getHandlesForVanity(value, cartItem, index, selected_handles) {
            try {
                const responseData = await this.axiosGETorPOSTAsync(this, {
                    url: '/get-handles',
                    params: { type: value }
                });

                console.log("getHandlesForVanity > responseData:", responseData);

                if (Array.isArray(responseData)) {
                    console.log("success");
                    // Locate the dynamically created select element
                    const forElement = document.querySelector(
                        `[for='cart-vanity-handles${index}']`
                    );
                    
                    const selectElement = forElement ? forElement.nextElementSibling : null;

                    if (!selectElement) {
                        console.error("Select element not found for cartItem:", cartItem);
                        return;
                    }

                    // Clear existing options except the first placeholder
                    selectElement.innerHTML = '<option value="">Select Handles</option>';

                    // Add new options and handle pre-selection
                    responseData.forEach((handle) => {
                        console.log("Processing handle:", handle);
                        const option = document.createElement("option");
                        option.value = handle.product_id;
                        option.textContent = handle.title;

                        // Pre-select the option if it matches selected_handles
                        if (handle.product_id == selected_handles) {
                            option.selected = true;
                            console.log(`Pre-selecting option: ${handle.product_id}`);
                        }

                        selectElement.appendChild(option);
                    });

                    // Debug the final state of the select element
                    console.log("Final selectElement options:", selectElement.innerHTML);

                } else {
                    console.error("Invalid responseData. Response:", responseData);
                }
            } catch (error) {
                console.error("Error fetching handles:", error.message);
            }
        },

        async getKnobsForVanity(value, cartItem, index, selected_handles) {
            try {
                // Fetch knobs data asynchronously
                const responseData = await this.axiosGETorPOSTAsync(this, {
                    url: '/get-knobs',
                    params: { type: value },
                });

                console.log("getKnobsForVanity > responseData:", responseData);

                // Ensure the response is valid and is an array
                if (Array.isArray(responseData)) {
                    console.log("Success");

                    const forElement = document.querySelector(
                        `[for='cart-vanity-knobs${index}']`
                    );
                    
                    const selectElement = forElement ? forElement.nextElementSibling : null;

                    if (!selectElement) {
                        console.error("Select element not found for cartItem:", cartItem);
                        return;
                    }

                    // Clear existing options except the first placeholder
                    selectElement.innerHTML = '<option value="">Select Knobs</option>';

                    // Populate the select element with new options
                    responseData.forEach((knob) => {
                        console.log("Processing knob:", knob);
                        
                        // Create a new option element
                        const option = document.createElement("option");
                        option.value = knob.product_id;
                        option.textContent = knob.title;

                        // Append the option to the select element
                        // Pre-select the option if it matches selected_handles
                        if (knob.product_id == selected_handles) {
                            option.selected = true;
                            console.log(`Pre-selecting option: ${knob.product_id}`);
                        }
                        selectElement.appendChild(option);
                    });

                    // Debugging the final state of the select element
                    console.log("Final selectElement options:", selectElement.innerHTML);
                } else {
                    // Log an error for invalid responseData
                    console.error(
                        "Invalid responseData or success flag is false. Response:",
                        responseData
                    );
                }
            } catch (error) {
                // Catch and log errors from the API call or other issues
                console.error("Error fetching knobs:", error.message);
            }
        },

        getFillersForVanity(value, cartItem, index){
            let instance = this;
            instance.axiosGETorPOST(
                { url: '/get-fillers', params: { type: value } },
                (success, responseData) => {
                    console.log("getFillersForVanity > success:", success);
                    console.log("getFillersForVanity > responseData:", responseData);

                    if (success && Array.isArray(responseData)) {
                        console.log("success");
                        // Locate the dynamically created select element
                        const selectElement = document.querySelector(
                            `[for='cart-vanity-filler${index}']`
                        ).nextElementSibling;

                        if (!selectElement) {
                            console.error("Select element not found for cartItem:", cartItem);
                            return;
                        }

                        // // Clear existing options except the first placeholder
                        selectElement.innerHTML = '<option value="">Select Fillers</option>';

                        // // Add new options from the responseData array
                        responseData.forEach((filler) => {
                            console.log("filler > "+ filler);
                            console.log("filler > "+ selectElement);
                            const option = document.createElement("option");
                            option.value = filler.product_id;
                            option.textContent = filler.title;
                            selectElement.appendChild(option);
                        });
                    } else {
                        console.error(
                            "Invalid responseData or success flag is false. Response:",
                            responseData
                        );
                    }
                }
            );
        },

        async getCounterTopForVanity(value, cartItem, index, selected_counter_top) {
            try {
                // Proceed only if value is 'yes'
                if (value !== 'yes') return;

                // Fetch countertop data asynchronously
                const responseData = await this.axiosGETorPOSTAsync(this, {
                    url: '/get-counter-top',
                    params: { type: value },
                });

                console.log("getCounterTopForVanity > responseData:", responseData);

                // Ensure the response is valid and is an array
                if (Array.isArray(responseData)) {
                    console.log("Success");

                    const forElement = document.querySelector(
                        `[for='cart-vanity-counter-top${index}']`
                    );
                    
                    const selectElement = forElement ? forElement.nextElementSibling : null;

                    if (!selectElement) {
                        console.error("Select element not found for cartItem:", cartItem);
                        return;
                    }

                    // Clear existing options except the first placeholder
                    selectElement.innerHTML = '<option value="">Select Counter Top</option>';

                    // Populate the select element with new options
                    responseData.forEach((counter_top) => {
                        console.log("Processing counter-top:", counter_top);

                        // Create a new option element
                        const option = document.createElement("option");
                        option.value = counter_top.product_id;
                        option.textContent = counter_top.title;

                        if (counter_top.product_id == selected_counter_top) {
                            option.selected = true;
                            console.log(`Pre-selecting option: ${counter_top.product_id}`);
                        }

                        // Append the option to the select element
                        selectElement.appendChild(option);
                    });

                    // Debugging the final state of the select element
                    console.log("Final selectElement options:", selectElement.innerHTML);
                } else {
                    // Log an error for invalid responseData
                    console.error(
                        "Invalid responseData or success flag is false. Response:",
                        responseData
                    );
                }
            } catch (error) {
                // Catch and log errors from the API call or other issues
                console.error("Error fetching countertop fillers:", error.message);
            }
        },

        axiosGETorPOSTAsync(instance, config) {
            return new Promise((resolve, reject) => {
                instance.axiosGETorPOST(config, (success, responseData) => {
                    if (success) {
                        resolve(responseData);
                    } else {
                        reject(new Error("Request failed or invalid response"));
                    }
                });
            });
        },
    }
}
</script>