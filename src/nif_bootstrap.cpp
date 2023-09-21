#include <erl_nif.h>
#include <assert.h>

/*
**  IMPORTANT LIMIT
*/
#define MAX_NIFS 1


using nif_fn_t = ERL_NIF_TERM (*)(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[]);

extern "C" {
    extern void Erlang_Nifsinit();
    extern void Erlang_Nifsfinal();
    extern void populate_functions(ErlNifFunc * funcs, int cnt);
} // extern "C"


static ERL_NIF_TERM hello(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    return enif_make_string(env, "Hello, world", ERL_NIF_LATIN1);
}

static ERL_NIF_TERM increment(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    return enif_make_int(env, 2);
}


ErlNifFunc input_funcs[MAX_NIFS];

// {
//     { "increment", 1, increment, 0 }
// };


class niflist {
private:
    ErlNifFunc nif_funcs_internal[MAX_NIFS];
public:
    niflist() {
        Erlang_Nifsinit();

        nif_funcs_internal[0] = input_funcs[0];

        populate_functions(nif_funcs_internal, MAX_NIFS);

        assert(sizeof(niflist) == sizeof(nif_funcs_internal));
    }

    ~niflist() {
        Erlang_Nifsfinal();
    }

    ErlNifFunc operator *() {
        return nif_funcs_internal[0];
    }

    operator ErlNifFunc * () {
        return &nif_funcs_internal[0];
    }
};

niflist fs; // = new niflist();


extern "C" {

    ERL_NIF_INIT(niftest, fs, NULL, NULL, NULL, NULL)

} // extern "C"
