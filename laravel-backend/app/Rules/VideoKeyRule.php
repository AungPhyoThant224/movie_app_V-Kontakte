<?php

namespace App\Rules;

use Illuminate\Contracts\Validation\Rule;
use App\Helpers\RequestHelper;

class VideoKeyRule implements Rule
{
    /**
     * Create a new rule instance.
     *
     * @return void
     */
    public function __construct()
    {
        //
    }

    /**
     * Determine if the validation rule passes.
     *
     * @param  string  $attribute
     * @param  mixed  $value
     * @return bool
     */
    public function passes($attribute, $value)
    {
	$key = RequestHelper::getVideoKey($value);
	if(!$key) return false;
        $r = RequestHelper::checkVk($key);
	return isset($r["response"]) && count($r["response"]["items"]) != 0 ? true : false;
    }

    /**
     * Get the validation error message.
     *
     * @return string
     */
    public function message()
    {
        return 'Vk Video Url/Access Token error.';
    }
}
