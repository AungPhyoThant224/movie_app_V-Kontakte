<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        \App\Models\Setting::create(["name"=>"Movie App","logo"=>"","client_id"=>"vk-client-id","client_secret"=>"vk-client-secret","imgbb_token"=>"imgbb-api-token"]);
	\App\Models\Admin::create(["name"=>"Root Admin","email"=>"root@mail.com","password"=>Hash::make("root@1234"),"level"=>"0"]);
    }
}
