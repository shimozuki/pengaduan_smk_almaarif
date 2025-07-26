<div class="row my-5 bg footer">
    <footer class="col-12">
        <div class="container">
            <div class="row mx-auto w-100 pt-5 pb-4 d-sm-flex d-block text-muted justify-content-center">
                <div class="col-12 col-sm-3 text-center text-sm-start text-white">
                    <p class="fs-5">Dikelola oleh</p>
                    {{-- If FOOTER_IMAGE didn't contains "/" --}}
                    @if (strpos(config('web_config')['FOOTER_IMAGE'], '/') === false)
                    <img src="{{ asset('images/' . config('web_config')['FOOTER_IMAGE']) }}" class="logo-smk" alt="Footer Website" width="100%">
                    <h4 style="color: aliceblue;">SMKS AL-Ma'arif</h4>
                    @else
                    <img class="img-fluid rounded mb-3 col-sm-5" src="{{ asset('storage/' . config('web_config')['FOOTER_IMAGE']) }}" alt="Footer Website">
                    <h4 style="color: aliceblue;">SMKS AL-Ma'arif</h4>
                    @endif
                </div>
                <div class="col pt-5 text-center text-white">
                    <p class="fw-bold fs-3 pt-0 pb-4 pt-sm-4 pb-sm-0">JANGAN TAKUT LAPOR YAH !</p>
                </div>
            </div>
            <div class="row mx-auto w-100">
                <div class="col-12 text-center text-white">
                    <p>Copyright © 2025 {{ config('web_config')['WEB_TITLE'] }}. All rights reserved</p>
                </div>
            </div>
        </div>
    </footer>
</div>