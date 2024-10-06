<template>
    <div>
        <div class="modal-layout-header">
            <div class="container-fluid p-0">
                <div class="row">
                    <div class="col-10">
                        <h5 v-if="id" class="m-0">{{ trans('lang.edit_product') }}</h5>
                        <h5 v-else class="m-0">Add New Todo</h5>
                    </div>
                    <div class="col-2 text-right">
                        <button
                            type="button"
                            class="close"
                            data-dismiss="modal"
                            aria-label="Close"
                            @click.prevent
                        >
                            <i class="la la-close icon-modal-cross"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <pre-loader v-if="!hidePreLoader"></pre-loader>
        <div class="modal-body scroll-modal app-bg-color p-3" v-show="hidePreLoader">
            <div class="form-row mx-0 mb-3 bg-white rounded p-3">
                <div class="form-group col-md-12">
                    <label for="title">{{ trans('lang.title') }}</label>
                    <input
                        id="title"
                        v-validate="'required'"
                        type="text"
                        class="form-control"
                        name="title"
                        v-model="title"
                        :class="{ 'is-invalid':submitted && errors.has('title') }"
                    />
                    <div class="heightError" v-if="submitted && errors.has('title')">
                        <small
                            class="text-danger"
                            v-show="errors.has('title')"
                        >{{ errors.first('title') }}</small>
                    </div>
                    
                </div>

                <div class="form-group col-md-12">
                    <label for="assigned-to">{{ trans('lang.assigned_to') }}</label>
                    <select
                        v-model="assignedTo"
                        v-validate="'required'"
                        data-vv-as="assigned to"
                        id="assigned-to"
                        name="assigned_to"
                        class="custom-select"
                    >
                        <option value disabled selected>{{ trans('lang.choose_one') }}</option>
                        <option :value="user.id" v-for="user in users">{{ user.branch_manager }}</option>
                    </select>
                    <div class="heightError">
                        <small
                            class="text-danger"
                            v-show="errors.has('assigned_to')"
                        >{{ errors.first('assigend_to') }}</small>
                    </div>
                </div>

                <div class="form-group col-md-12">
                    <label for="due-date">{{ trans('lang.due_date') }}</label>
                    <input
                        id="due-date"
                        type="date"
                        class="form-control"
                        name="title"
                        v-model="dueDate"
                        :min="minDate"
                    />
                   
                </div>

                <div class="form-group col-md-12">
                    <label for="description">{{ trans('lang.description') }}</label>
                    <textarea
                        id="description"
                        type="date"
                        class="form-control"
                        name="title"
                        v-model="description"
                    ></textarea>
                    
                </div>

            </div>
            
            
            <div class="form-row mt-3">
                <div class="col-md-12">
                    <button
                            class="btn btn-primary app-color mobile-btn"
                            type="submit"
                            @click.prevent="save()"
                    >{{ trans('lang.save') }}</button>
                    <button
                        class="btn btn-secondary cancel-btn mobile-btn"
                        data-dismiss="modal"
                        aria-label="Close"
                        @click.prevent
                    >{{ trans('lang.cancel') }}</button>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import axiosGetPost from "../../helper/axiosGetPostCommon";

export default {
    props: ["id", "bus"],
    extends: axiosGetPost,
    data() {
        return {
            submitted: false,
            tempAttributeList: [],
            totalChipValue: [],
            product: [],
            users:[],
            isActive: false,
            modalOptions: {},
            modalID: "#product-add-edit-modal",
            assignedTo:null,
            dueDate:null,
            title: null,
            description: null,
            minDate:''
            
        };
    },
    watch: {
        
    },

    created() {
        this.getSupportingData();

        this.calculateMinDate();
    },

    mounted() {
        //here this code carry data in one time
        let instance = this;
        
        $("#product-add-edit-modal").on("hidden.bs.modal", function(e) {
            instance.$emit("disable");
        });

        this.modalCloseAction(this.modalOptions.modalID);
    },
    methods: {
        getSupportingData(){
            let instance = this;
            this.setPreLoader(false);
            this.axiosGet(
                "/todos/support-data",
                function(response) {
                    instance.users = response.data.users;
                    instance.setPreLoader(true);
                },
                function(response) {
                    instance.setPreLoader(true);
                }
            );
        },
        calculateMinDate(){
            this.minDate = new Date().toISOString().slice(0,10);
        }
    }
};

</script>