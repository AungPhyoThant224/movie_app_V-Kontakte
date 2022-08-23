<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePostsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('posts', function (Blueprint $table) {
            $table->id();
            $table->string("title");
            $table->string("key");
            $table->string("url");
            $table->string("image");
            $table->string("duration")->default("0");
            $table->integer("total_view")->default(0);
            $table->text("description")->nullable();
            $table->unsignedBigInteger("admin_id")->nullable();
            $table->unsignedBigInteger("category_id");
            $table->foreign("category_id")->references('id')->on("categories")->onDelete('cascade');
            $table->foreign("admin_id")->references('id')->on("admins")->nullOnDelete();
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
        Schema::dropIfExists('posts');
    }
}
