<?php
namespace Database\Seeders;


use App\Models\ProductBrand;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ProductBrandTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        ProductBrand::query()->truncate();

        DB::table('product_brands')->insert([
            [

                'name' => 'King',
                'created_by' => 1,
            ],
            [
                'name' => 'Lillie',
                'created_by' => 1,
            ],
            [
                'name' => 'Rose',
                'created_by' => 2,
            ],
            [
                'name' => 'Royal',
                'created_by' => 1,
            ]
        ]);
    }
}
