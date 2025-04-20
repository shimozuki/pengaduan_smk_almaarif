<?php

namespace App\Http\Controllers\Dashboards;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\{Aspirasi, Complaint, Category};
use Illuminate\Support\Str;
use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\Storage;
use Cviebrock\EloquentSluggable\Services\SlugService;
use Illuminate\Database\Eloquent\ModelNotFoundException;

class DashboardAspirasiController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $complaints = Complaint::with(["student", "responses", "category"])->where('student_nik', auth()->user()->nik)->where('category_id', 13)->orderBy('created_at', "desc")->get();

        return view("dashboard.aspirasi.index", [
            "title" => "Keluhan",
            "complaints" => $complaints,
        ]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(Request $request)
    {
        $previousUrl = $request->headers->get('referer');

        return view("dashboard.aspirasi.create", [
            "title" => "Buat Pengaduan",
            "categories" => Category::all()->sortBy("name"),
            "previousUrl" => $previousUrl,
        ]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $credentials = $request->validate([
            "title" => ["required", "max:255"],
            "slug" => ["required", "unique:complaints"],
            "date" => ["required", "date", "date_format:Y-m-d"],
            "place" => ["required"],
            "privacy" => ["required"],
            "image" => ["image", "file", "max:5120"],
            "body" => ["required"],
        ]);

        // Convert category's slug into id
        $credentials["category_id"] = 13;

        if ($request->file("image")) {
            $credentials["image"] = $request->file("image")->store('complaint-images');
        }

        $credentials["student_nik"] = auth()->user()->nik ?? null;
        $credentials["excerpt"] = Str::limit(strip_tags($request->body), 50, ' ...');

        try {
            $complaint = Complaint::create($credentials);
            return redirect('/dashboard/aspirasis/' . $complaint->slug)->with('success', 'Aspirasi kamu berhasil dibuat!');
        } catch (\Exception $e) {
            return $e;
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Aspirasi  $complaint
     * @return \Illuminate\Http\Response
     */
    public function show(Request $request, Aspirasi $aspirasi)
    {
        $previousUrl = $request->headers->get('referer');

        // Validate if the complaint is owned by the user
        if ($aspirasi->student_nik !== auth()->user()->nik) {
            return redirect('/dashboard/aspirasis')->withErrors('Keluhan tidak ditemukan.');
        }

        // Short the responses based on new response (date)
        $sortedResponses = $aspirasi->responses->sortByDesc("created_at");

        return view("dashboard.aspirasi.show", [
            "title" => ucwords($aspirasi->title),
            "complaint" => $aspirasi,
            "responses" => $sortedResponses,
            "previousUrl" => $previousUrl,
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Aspirasi  $complaint
     * @return \Illuminate\Http\Response
     */
    public function edit(Request $request, Aspirasi $aspirasi)
    {
        $previousUrl = $request->headers->get('referer');

        // Validate if the complaint is owned by the user
        if ($aspirasi->student_nik !== auth()->user()->nik) {
            return redirect('/dashboard/aspirasis')->withErrors('Keluhan tidak ditemukan.');
        }

        return view("dashboard.aspirasi.edit", [
            "title" => "Sunting Keluhan",
            "complaint" => $aspirasi, // kalau mau tetap pakai 'complaint' di view
            "categories" => Category::all(),
            "previousUrl" => $previousUrl,
        ]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Complaint  $complaint
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Complaint $complaint)
    {
        $rules = [
            "title" => ["required", "max:255"],
            "category_id" => ["required"],
            "image" => ["image", "file", "max:5120"],
            "date" => ["required", "date", "date_format:Y-m-d"],
            "body" => ["required"],
            "place" => ["required"],
            "privacy" => ["required"],
        ];

        if ($request->slug != $complaint->slug) {
            $rules["slug"] = ["required", "unique:complaints"];
        }

        $credentials = $request->validate($rules);

        // Convert slug into id
        $credentials["category_id"] = Category::where('slug', $credentials["category_id"])->first()->id;

        if ($request->file("image")) {
            if ($request->oldImage) {
                Storage::delete($request->oldImage);
            }

            $credentials["image"] = $request->file("image")->store('complaint-images');
        }

        $credentials["student_nik"] = auth()->user()->nik ?? null;
        $credentials["excerpt"] = Str::limit(strip_tags($request->body), 50, ' ...');

        try {
            // $complaint = Complaint::where("id", $complaint->id)->update($credentials);
            // Get the new and old of $complaint
            $complaintOld = $complaint->fresh();
            $complaint->update($credentials);
            $complaintNew = $complaint->fresh();

            // Get the old and new versions of the model as arrays
            $oldAttributes = $complaintOld->getAttributes();
            $newAttributes = $complaintNew->getAttributes();

            // Compare the arrays to see if any attributes have changed
            if ($oldAttributes === $newAttributes) {
                // The instance of the $complaint record has not been updated
                return redirect('/dashboard/aspirasis/' . $complaint->slug)->with('info', 'Kamu tidak melakukan editing pada keluhan.');
            }

            // The instance of the $complaint record has been updated
            return redirect('/dashboard/aspirasis/' . $complaint->slug)->with('success', 'Keluhan kamu berhasil di-edit!');
        } catch (\Exception $e) {
            // If something was wrong ...
            return redirect('/dashboard/aspirasis')->withErrors('Keluhan kamu gagal di-edit.');
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Complaint  $complaint
     * @return \Illuminate\Http\Response
     */
    public function destroy(Aspirasi $aspirasi)
    {
        if ($aspirasi->image) {
            Storage::delete($aspirasi->image);
        }

        try {
            if (!Aspirasi::destroy($aspirasi->id)) {
                throw new \Exception('Gagal menghapus aspirasi.');
            }
        } catch (\Throwable $e) {
            return response()->json([
                "message" => "Terjadi kesalahan: " . $e->getMessage()
            ], 500);
        }

        return response()->json([
            "message" => "Aspirasi berhasil dihapus.",
        ], 200);
    }


    public function checkSlug(Request $request)
    {
        $slug = SlugService::createSlug(Complaint::class, "slug", $request->title);

        return response()->json(["slug" => $slug]);
    }
}
