<?php

namespace App\Exports;

use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Carbon\Carbon;
use Maatwebsite\Excel\Concerns\WithStyles;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;

class ComplaintExport implements FromCollection, WithHeadings, WithStyles
{
    protected $start, $end, $status, $category_id;

    public function __construct($start, $end, $status, $category_id)
    {
        $this->start = $start;
        $this->end = $end;
        $this->status = $status;
        $this->category_id = $category_id;
    }

    public function collection()
    {
        $query = \App\Models\Complaint::query();

        if ($this->start) {
            $query->whereDate('created_at', '>=', $this->start);
        }
        if ($this->end) {
            $query->whereDate('created_at', '<=', $this->end);
        }
        if ($this->status !== null && $this->status !== '') {
            $query->where('status', $this->status);
        }
        if ($this->category_id) {
            $query->where('category_id', $this->category_id);
        }

        // Gunakan map untuk custom format
        return $query->with(['student', 'category', 'response.officer.user'])
            ->get()
            ->map(function ($item) {
                // Format tanggal
                $dateFormatted = Carbon::parse($item->date)->format('d/m/Y');
                $createdFormatted = Carbon::parse($item->created_at)->format('d/m/Y');
                $placeLabel = $item->place === 'in' ? 'Dalam Sekolah' : 'Luar Sekolah';
                $responseBody = optional($item->response)->body ?? '-';
                $officerName =  optional(optional($item->response)->officer->user)->name ?? '-';


                return [
                    'Tanggal Kejadian'       => $dateFormatted,
                    'Judul'         => $item->title,
                    'Isi Keluhan'   => strip_tags($item->body), // tanpa html
                    'Kategori'      => optional($item->category)->name,
                    'Pelapor'       => $item->privacy,
                    'Tempat'        => $placeLabel,
                    'Tingkat Urgensi'     => $item->urgency ?? '-',
                    'Tanggal Dibuat' => $createdFormatted,
                    'Status'        => $this->statusLabel($item->status),
                    'Tanggapan'          => strip_tags($responseBody),
                    'Nama Petugas'       => $officerName,
                ];
            });
    }

    public function headings(): array
    {
        return [
            'Tanggal Kejadian',
            'Judul',
            'Isi Keluhan',
            'Kategori',
            'Pelapor',
            'Tempat',
            'Tingkat Urgensi',
            'Tanggal Dibuat',
            'Status',
            'Tanggapan',
            'Nama Petugas',
        ];
    }

    public function styles(Worksheet $sheet)
    {
        $headingRange = 'A1:I1';

        return [
            1 => [
                'font' => ['bold' => true],
                'alignment' => ['horizontal' => \PhpOffice\PhpSpreadsheet\Style\Alignment::HORIZONTAL_CENTER],
            ],
        ];
    }

    private function statusLabel($status)
    {
        switch ($status) {
            case 0:
                return 'Belum diproses';
            case 1:
                return 'Sedang diproses';
            case 2:
                return 'Selesai';
            default:
                return '-';
        }
    }
}
