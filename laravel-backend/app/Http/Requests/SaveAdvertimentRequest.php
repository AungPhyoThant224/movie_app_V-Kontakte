<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use App\Rules\VTypeRule;

class SaveAdvertimentRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            "title"=>"required|string|max:255",
	"url"=>"image",
	"type"=>["required",new VTypeRule([1,2,3])],
	"ctype"=>["required",new VTypeRule([1,2,3,4,5])],
	"contact"=>"required|string|max:255",
	"end_date"=>"required|date|date_format:Y-m-d|after:today"
        ];
    }
}
