<?php

namespace Database\Seeders;

use App\Models\SiteSetting;
use Illuminate\Database\Seeder;

class SiteSettingSeeder extends Seeder
{
    public function run()
    {
        SiteSetting::firstOrCreate(
            ['id' => 1], // Ensure the singleton record exists with ID 1
            [
                'site_name' => 'Booksy',
                'email' => 'info@booksy.com',
                'bussiness_email' => 'info@booksy.com',
                'currency_rate' => 0.72,
                'tax' => 0.15,
            ]
        );
    }
}
