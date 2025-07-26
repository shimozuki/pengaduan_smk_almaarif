@extends('dashboard.layouts.main')

@section('links')
{{-- Simple DataTable --}}
<link rel="stylesheet" href="{{ asset('assets/extensions/simple-datatables/style.css') }}" />
<link rel="stylesheet" href="{{ asset('assets/compiled/css/table-datatable.css') }}" />
{{-- Sweetalert --}}
<link rel="stylesheet" href="{{ asset('assets/extensions/sweetalert2/sweetalert2.min.css') }}" />
@endsection

@section('content')
<div class="page-heading mb-0">
    <div class="page-title">
        <div class="row">
            <div class="col-12 col-md-6 order-md-1 order-last">
                <h2>Semua Tanggapan Kamu</h2>
                <p class="text-subtitle text-muted">
                    Keseluruhan data dari tanggapan yang kamu buat.
                </p>
                <hr>
            </div>
            <div class="col-12 col-md-6 order-md-2 order-first">
                <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="/dashboard">Dashboard</a>
                        </li>
                        <li class="breadcrumb-item active" aria-current="page">
                            Tanggapan
                        </li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>

    <section class="section">
        <div class="card">
            <div class="card-header">
                <h3>Tanggapan</h3>
            </div>
            <div class="card-body">
                <table class="table table-striped" id="table1">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Judul Keluhan</th>
                            <th>Status</th>
                            <th>Tanggal</th>
                            <th>Aksi</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse ($responses as $response)
                        <tr>
                            <td>
                                {{ $loop->iteration }}
                            </td>
                            <td>
                                {{ $response->complaint->title }}
                            </td>
                            <td>
                                @if ($response->complaint->status == 0)
                                <span class="badge bg-danger">
                                    Belum diproses
                                </span>
                                @elseif ($response->complaint->status == 1)
                                <span class="badge bg-secondary">
                                    Sedang diproses
                                </span>
                                @elseif ($response->complaint->status == 2)
                                <span class="badge bg-success">
                                    Selesai
                                </span>
                                @endif
                            </td>
                            <td>
                                {{ $response->created_at->format('Y-m-d') }}
                            </td>
                            <td>
                                <div class="d-flex">
                                    @if ($response->complaint->status == 2)
                                    <a data-bs-toggle="tooltip"
                                        data-bs-original-title="Rincian dari keluhan siswa yang sudah selesai."
                                        href="/dashboard/aspirasis_r/create/{{ $response->complaint->slug }}"
                                        class="btn btn-info px-2 pt-2">
                                        <span class="fa-fw fa-lg select-all fas"></span>
                                    </a>
                                    @elseif($response->complaint->status < 2)
                                        <div class="me-2">
                                        <a data-bs-toggle="tooltip"
                                            data-bs-original-title="Sunting tanggapan yang kamu miliki."
                                            href="/dashboard/aspirasis_r/{{ $response->id }}/edit"
                                            class="btn btn-warning px-2 pt-2">
                                            <span class="fa-fw fa-lg select-all fas"></span>
                                        </a>
                                </div>

                                <div class="me-2">
                                    <a data-bs-toggle="tooltip"
                                        data-bs-original-title="Lihat rincian dari tanggapan kamu."
                                        href="/dashboard/aspirasis_r/{{ $response->id }}"
                                        class="btn btn-info px-2 pt-2">
                                        <span class="fa-fw fa-lg select-all fas"></span>
                                    </a>
                                </div>

                                <a href="#" class="btn btn-danger delete-record" data-slug="{{ $response->id }}">
                                    <span data-slug="{{ $response->id }}" class="delete-record fas fa-times"></span>
                                </a>
                                @endif
            </div>
            </td>
            </tr>
            @empty
            <tr>
                <td colspan="5">
                    <p class="text-center mt-3">Tidak ada tanggapan :(</p>
                </td>
            </tr>
            @endforelse
            </tbody>
            </table>
        </div>
</div>
</section>
</div>
@endsection

@section('scripts')
{{-- SweetAlert --}}
<script src="{{ asset('assets/extensions/sweetalert2/sweetalert2.min.js') }}"></script>
@vite(['resources/js/sweetalert/swalMulti.js'])
{{-- Simple DataTable --}}
<script src="{{ asset('assets/extensions/simple-datatables/umd/simple-datatables.js') }}"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    $(document).on('click', '.delete-record', function(e) {
        e.preventDefault();
        var id = $(this).data('slug');
        Swal.fire({
            title: 'Apakah Anda yakin?',
            text: "Tanggapan akan dihapus permanen.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
            confirmButtonText: 'Ya, hapus!'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: '/dashboard/responses/' + id,
                    type: 'DELETE',
                    data: {
                        _token: '{{ csrf_token() }}'
                    },
                    success: function(response) {
                        Swal.fire('Berhasil!', response.message, 'success').then(() => {
                            window.location.href = "/dashboard/responses"; // redirect ke daftar responses
                        });
                    },
                    error: function(xhr) {
                        Swal.fire('Gagal!', xhr.responseJSON?.message ?? 'Gagal menghapus.', 'error');
                    }
                });
            }
        });
    });
</script>


@vite(['resources/js/simple-datatable/responses.js'])
@endsection