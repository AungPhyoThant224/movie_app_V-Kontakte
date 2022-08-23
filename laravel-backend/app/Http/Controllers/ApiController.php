<?php

namespace App\Http\Controllers;

use Illuminate\Http\Exceptions\HttpResponseException;
use Illuminate\Http\Request;
use App\Models\Admin;
use App\Models\Post;
use App\Models\User;
use App\Models\Category;
use App\Models\Notification;
use App\Models\Advertiment;
use App\Helpers\RequestHelper;
use App\Models\Setting;
use DateTime;

class ApiController extends Controller
{
    private function postP2J($data){
          $tmp=array();
          $res = $data->toArray();
          foreach ($data->items() as $d) {
$d->category = $d->category()->get();
$d->other = Post::where("category_id",$d->category_id)->where("id","<>",$d->id)->orderBy('total_view',"DESC")->limit(3)->get();
             array_push($tmp,$d);
          }
          $res["data"] = $tmp;
	  $res["slider_images"]=$this->getAds("1");
	  $res["card_images"]=$this->getAds("2");
        return $res;
    }

private function getCat($d){
$r=[];
foreach($d as $i){
$i->category = $i->category()->get();
$i->other = Post::where("category_id",$i->category_id)->where("id","<>",$i->id)->orderBy('total_view',"DESC")->limit(3)->get();
array_push($r,$i);
}
return $r;
}

    public function index(Request $r){
	$d=Setting::where("active","1")->first();
	if($r->has("version") && $d->version != $r->version){
		$i=Notification::where("status","1")->where("type","1")->first();
	}else{
		$i=Notification::where("status","1")->where("type","<>","1")->first();
	}
         return $this->res([
            'popular' => $this->getCat(Post::orderBy('total_view','DESC')->limit(5)->get()),
            'new' => $this->getCat(Post::orderBy('updated_at','DESC')->limit(5)->get()),
            'categories' => Category::orderBy('name')->get(),
	    'slider_images'=> $this->getAds("1"),
	    'notification'=> $i,
         ]);
    }

    public function policy(){
	$d=Setting::where("active","1")->first();
	return $this->res(["policy"=>$d->policy]);
    }

    public function about(){
	$d=Setting::where("active","1")->first();
	return $this->res(["name"=>$d->name,"logo"=>$d->logo,"about"=>$d->about,"contact"=>$d->contact,"dlink"=>$d->dlink]);
    }

    public function saveDevice(Request $r){
    if(!$r->has("device_id")) return ["message" =>"device_id param required!!!"];
    $user = User::firstOrNew(['device_id' =>  $r->device_id]);
    $user->save();
    return $this->res(["message" =>"Successful"]);
}

    public function popular(){
         return $this->res($this->postP2J(Post::orderBy('total_view','DESC')->paginate(10)));
    }

    public function newest(){
         return $this->res($this->postP2J(Post::orderBy('updated_at','DESC')->paginate(10)));
    }

    public function search($text){
         return $this->res($this->postP2J(Post::where('title','LIKE',"%".$text."%")->paginate(10)));
    }
    
    public function category($id){
         $category = Category::where("id",$id)->first();
         if(!$category) return $this->res([]);
         $category->posts = $this->postP2J($category->posts()->orderBy("updated_at","DESC")->paginate(10));
         return $this->res($category);
    } 

    public function post($id){
         $p = Post::where("id",$id)->first();
         if($p){
           $p->total_view = strval(intval($p->total_view)+1);
           $p->save();
           $p->category = $p->category()->get();
           $p->other = Post::where("category_id",$p->category_id)->where("id","<>",$p->id)->orderBy('total_view',"DESC")->limit(3)->get();
           return $this->res($p);
         }
         return $this->res(null);
    }

    private function getAds($t){
$a=Advertiment::where("type",$t)->where("status","1")->orderBy("updated_at","DESC")->get();
$r=[];
foreach($a as $d){
if(new DateTime()>new DateTime($d->end_date)){
$d->status="0";
$d->save();
}else{
array_push($r,$d);
}
}
return $r;
}

private function res($d){
throw new HttpResponseException(response()->json($d, 200));
}

}
