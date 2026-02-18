#include <idc.idc>

static main()
{
    auto a, ea, v;

    for (a = 0x100; a < 0x120; a++)
    {
        ea = 0x1000 + a;          // адрес
        v  = get_wide_byte(ea);   // читаем 1 байт
        patch_byte(ea, v ^ 0xAA); // патчим 1 байт
    }

    msg("DONE!\n");
}
