static MP_INLINE int mpxs_apr_password_validate(pTHX_ const char *passwd,
                                                const char *hash)
{
    return apr_password_validate(passwd, hash) == APR_SUCCESS;
}

static MP_INLINE void mpxs_apr_strerror(pTHX_ SV *sv, SV *arg)
{
    apr_status_t statcode = mp_xs_sv2_status(arg);
    char *ptr;
    mpxs_sv_grow(sv, 128-1);
    ptr = apr_strerror(statcode, SvPVX(sv), SvLEN(sv));
    mpxs_sv_cur_set(sv, strlen(ptr)); /*XXX*/
}

static XS(MPXS_apr_strerror)
{
    dXSARGS;

    mpxs_usage_items_1("status_code");

    mpxs_set_targ(mpxs_apr_strerror, ST(0));
}