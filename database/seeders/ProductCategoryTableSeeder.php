<?php
namespace Database\Seeders;

use App\Models\ProductCategory;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ProductCategoryTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        ProductCategory::query()->truncate();

        DB::table('product_categories')->insert([
            [
                'name' => 'Vanities',
                'created_by' => 1
            ],
            [
                'name' => 'STONE',
                'created_by' => 1
            ],
            [
                'name' => 'SINKS',
                'created_by' => 1
            ],
            [
                'name' => 'SHOWER',
                'created_by' => 1
            ],
            [
                'name' => 'Shelf Panel',
                'created_by' => 1
            ],
            [
                'name' => 'Shaker',
                'created_by' => 1
            ],
            [
                'name' => 'Riobel',
                'created_by' => 1
            ],
            [
                'name' => 'pick up',
                'created_by' => 1
            ],
            [
                'name' => 'Mirror',
                'created_by' => 1
            ],
            [
                'name' => 'LED MIRRORS',
                'created_by' => 1
            ],
            [
                'name' => 'KNOBS',
                'created_by' => 1
            ],
            [
                'name' => 'Faucets',
                'created_by' => 1
            ],
            [
                'name' => 'BASIN',
                'created_by' => 1
            ],
            [
                'name' => 'Accessories',
                'created_by' => 1
            ]
        ]);
    }
}
