#include <erl_nif.h>
#include <assert.h>

#define NUMBER_OF_NIFS 4

extern "C" {
    extern void Erlang_Nifsinit();
    extern void Erlang_Nifsfinal();
    extern void populate_nif_array(ErlNifFunc * funcs, int cnt);
}

class NifsListProxy {
private:
    ErlNifFunc nif_funcs[NUMBER_OF_NIFS]; // to be populated by Ada code
public:
    NifsListProxy() {
        assert(sizeof(NifsListProxy) == sizeof(nif_funcs));
        Erlang_Nifsinit();
        populate_nif_array(nif_funcs, NUMBER_OF_NIFS);
    }

    ~NifsListProxy() {
        Erlang_Nifsfinal();
    }

    ErlNifFunc operator *() {
        return nif_funcs[0];
    }

    operator ErlNifFunc * () {
        return &nif_funcs[0];
    }
};

static NifsListProxy nifsListProxy;

extern "C" {
    ERL_NIF_INIT(examples, nifsListProxy, NULL, NULL, NULL, NULL)
}
