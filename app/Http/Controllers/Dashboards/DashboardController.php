<?php

namespace App\Http\Controllers\Dashboards;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Services\Dashboard\{DashboardService, ChartService};
use App\Exports\ComplaintExport;
use Maatwebsite\Excel\Facades\Excel;


class DashboardController extends Controller
{
    protected $dashboardService, $chartService;

    // Constructor to add services
    public function __construct(DashboardService $dashboardService, ChartService $chartService)
    {
        $this->dashboardService = $dashboardService;
        $this->chartService = $chartService;
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $response = $this->dashboardService->index(auth()->user());

        return view("dashboard.index", $response);
    }

    public function chartData()
    {
        // Return the chart data (JSON response)
        return $this->chartService->responses(auth()->user());
    }

    public function exportComplaints(Request $request)
    {
        $start = $request->start_date;
        $end = $request->end_date;
        $status = $request->status;
        $category_id = $request->category_id;

        return Excel::download(new ComplaintExport($start, $end, $status, $category_id), 'complaints.xlsx');
    }
}
