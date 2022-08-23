<?php
namespace App\Helpers;

use Illuminate\Support\Facades\Http;
use App\Models\Setting;

class RequestHelper{

 public static function checkVk($id){
	$url="https://api.vk.com/method/video.get";
	$body=["v"=>"5.92","access_token"=>auth()->user()->access_token,"videos"=>strval($id)];
	$r = Http::asForm()->post($url,$body);
	return $r->json();
 }
 public static function getVideoKey($url){
  if(str_contains($url,"vk.com/video")){
 if(str_contains($url,"?")){
$url=explode("?",$url)[0];
}

$r = explode("video",$url);
return count($r)==2 ? $r[1] : null;

}
return null;
 }

public static function uploadI($f){
$d=Setting::where("active","1")->first();
$url="https://api.imgbb.com/1/upload?key=".$d->imgbb_token;
$r=Http::asForm()->post($url,["image"=>$f]);
$res = $r->json();
if($res["success"]!= true) return null;
return $res["data"]["url"];
}

}
