#include <erl_nif.h>
#include <assert.h>

/*
**  IMPORTANT LIMIT
*/
#define MAX_NIFS 1


using nif_fn_t = ERL_NIF_TERM (*)(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]);

extern "C" {
    extern void Erlang_Nifsinit();
    // extern void Erlang_Nifsfinal();
    // extern void populate_functions(ErlNifFunc * funcs, int cnt);
} // extern "C"


// static ERL_NIF_TERM hello(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
// {
//     return enif_make_string(env, "Hello world!", ERL_NIF_LATIN1);
// }

static ERL_NIF_TERM not_implemented(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    return enif_make_string(env, "<not implemented>", ERL_NIF_LATIN1);
    // return 0;
}


ErlNifFunc input_funcs[MAX_NIFS] =
{
    { "impl", 0, not_implemented, 0 }
};


class niflist {
private:
    ErlNifFunc nif_funcs_internal[MAX_NIFS];
public:
    niflist() {
        Erlang_Nifsinit();


        // ErlNifFunc * funcs = get_funcs();

        // for (int i = 0; i < MAX_NIFS; i++) {
        //     nif_funcs_internal[i] = funcs[i];
        // }

        // nif_funcs_internal[0] = nif_funcs[0];
        nif_funcs_internal[0] = input_funcs[0];

        // populate_functions(nif_funcs_internal, MAX_NIFS);


        // nif_funcs[0].name = get_fname();
        // nif_funcs_internal[0].fptr = get_stub();
        // ErlNifFunc func = get_funcs()[0];
        // nif_funcs_internal[0] = funcs[0];
        // nif_funcs_internal[0] = get_funcs()[0];
        // nif_funcs_internal[0].name = funcs[0].name;
        // nif_funcs_internal[0].arity = funcs[0].arity;
        // nif_funcs_internal[0].fptr = funcs[0].fptr;
        // nif_funcs_internal[0].flags = funcs[0].flags;
        // nif_funcs_internal[0] = func;
        assert(sizeof(niflist) == sizeof(nif_funcs_internal));
    }

    ~niflist() {
        // Erlang_Nifsfinal();
    }

    ErlNifFunc operator *() {
        return nif_funcs_internal[0];
    }

    operator ErlNifFunc * () {
        return &nif_funcs_internal[0];
    }
};

niflist fs; // = new niflist();


// static int load(ErlNifEnv* env, void** priv_data, ERL_NIF_TERM load_info)
// {
//     // Erlang_Nifsinit();
//     // fs.init();
//     // nif_funcs[0] = input_funcs[0];
//     return 0;
// }

// static int upgrade(ErlNifEnv* env, void** priv_data, void** old_priv_data, ERL_NIF_TERM load_info)
// {
//     Erlang_Nifsinit();
//     return 0;
// }

extern "C" {

    ERL_NIF_INIT(niftest, fs, NULL, NULL, NULL, NULL)

} // extern "C"
