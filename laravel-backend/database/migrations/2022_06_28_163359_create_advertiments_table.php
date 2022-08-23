<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAdvertimentsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('advertiments', function (Blueprint $table) {
            $table->id();
            $table->string("title");
            $table->string("info")->nullable();
	    $table->string("contact")->nullable();
	    $table->string("ctype")->nullable();
            $table->string("end_date");
            $table->string("status")->default("1");
            $table->string("type")->default("1");
            $table->string("admin_id");
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
        Schema::dropIfExists('advertiments');
    }
}
