<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddTaxPercentage extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('orders', function($table) {
            $table->float('tax_percentage');
        });
        Schema::table('order_logs', function($table) {
            $table->float('tax_percentage');
        });
        
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('orders', function($table) {
            $table->dropColumn('tax_percentage');
        });
        Schema::table('order_logs', function($table) {
            $table->dropColumn('tax_percentage');
        });
    }
}
