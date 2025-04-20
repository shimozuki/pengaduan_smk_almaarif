<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class StudentOrWaliMuridMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure(\Illuminate\Http\Request): (\Illuminate\Http\Response|\Illuminate\Http\RedirectResponse)  $next
     * @return \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse
     */
    public function handle(Request $request, Closure $next)
    {
        if (auth()->guest() or auth()->user()->level != "wali_murid" || auth()->guest() or auth()->user()->level != "student") {
            return $next($request);
        }

        return $next($request);
    }
}
