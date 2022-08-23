<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateSettingsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('settings', function (Blueprint $table) {
            $table->id();
            $table->string("name")->default("Dark Moon");
            $table->string("logo")->default("https:://logo.png");
            $table->text("about")->nullable();
            $table->string("contact")->nullable();
            $table->text("policy")->nullable();
            $table->string("client_id")->nullable();
$table->string("dlink")->nullable();
            $table->string("client_secret")->nullable();
            $table->string("imgbb_token")->nullable();
            $table->integer("active")->default(1);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('settings');
    }
}
