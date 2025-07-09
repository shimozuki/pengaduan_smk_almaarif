<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;


class StatistikPengaduanController extends Controller
{
    public function statistikPengaduan()
    {
        $daily = DB::table('complaints')
            ->selectRaw('DATE(date) as tanggal, COUNT(*) as jumlah')
            ->where('date', '>=', now()->subDays(6))
            ->groupBy('tanggal')
            ->orderBy('tanggal')
            ->get();

        $weekly = DB::table('complaints')
            ->selectRaw("YEARWEEK(date, 1) as minggu_ke, COUNT(*) as jumlah")
            ->where('date', '>=', now()->subWeeks(4))
            ->groupBy('minggu_ke')
            ->orderBy('minggu_ke')
            ->get();

        $monthly = DB::table('complaints')
            ->selectRaw('DATE_FORMAT(date, "%Y-%m") as bulan, COUNT(*) as jumlah')
            ->where('date', '>=', now()->subMonths(5))
            ->groupBy('bulan')
            ->orderBy('bulan')
            ->get();

        return response()->json([
            'daily' => $daily,
            'weekly' => $weekly,
            'monthly' => $monthly,
        ]);
    }
}
