# Supplied to fallback to the test key for YSCTW
Stripe.api_key = ENV.fetch('STRIPE_SECRET_KEY', 'sk_test_4FXM6s6OOILNa8KPdxyXDRtq')

STRIPE_CONFIG = {
    public_key: ENV.fetch('STRIPE_PUBLIC_KEY', 'pk_test_cX8rDspcsLdUPz5yKSDZ5QRm')
}
