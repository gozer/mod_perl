#include "mod_perl.h"

void modperl_startup(server_rec *s, ap_pool_t *p)
{
    PerlInterpreter *perl;
    int status;
    char *argv[] = { "httpd", "/dev/null" };
    int argc = 2;

    if (!(perl = perl_alloc())) {
        perror("perl_alloc");
        exit(1);
    }

    perl_construct(perl);
    
    status = perl_parse(perl, NULL, argc, argv, NULL);

    if (status) {
        perror("perl_parse");
        exit(1);
    }

    perl_run(perl);

    modperl_interp_pool_init(s, p, perl);
}

void modperl_init(ap_pool_t *pconf, ap_pool_t *plog, 
                  ap_pool_t *ptemp, server_rec *s)
{
    modperl_trace_level_set("all"); /* XXX: all for now */
    modperl_startup(s, pconf);
}

void modperl_pre_config_handler(ap_pool_t *p, ap_pool_t *plog,
                                ap_pool_t *ptemp)
{
}

void modperl_register_hooks(void)
{
    /* XXX: should be pre_config hook or 1.xx logic */
    ap_hook_open_logs(modperl_init, NULL, NULL, HOOK_MIDDLE);

    /* XXX: should only bother selecting an interpreter
     * if one is needed for the request
     */
    ap_hook_post_read_request(modperl_interp_select, NULL, NULL, HOOK_FIRST);
}

static command_rec modperl_cmds[] = {  
    { NULL }, 
}; 

static handler_rec modperl_handlers[] = {
    { NULL },
};

module MODULE_VAR_EXPORT perl_module = {
    STANDARD20_MODULE_STUFF, 
    modperl_create_dir_config, /* dir config creater */
    modperl_merge_dir_config,  /* dir merger --- default is to override */
    modperl_create_srv_config, /* server config */
    modperl_merge_srv_config,  /* merge server config */
    modperl_cmds,              /* table of config file commands       */
    modperl_handlers,          /* handlers */
    modperl_register_hooks,    /* register hooks */
};
