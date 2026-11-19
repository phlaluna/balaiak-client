Cópia do port `openal-soft` do vcpkg (baseline do `vcpkg.json`) com um patch a
mais, `005-fix-msvc-14.52-ranges.patch`: o MSVC 14.52 (runner
`windows-2025-vs2026` desde nov/2026) não compila
`std::views::transform(&EffectSlotCluster::operator*)` em `alc/alc.cpp`
(erro C3889). Troca pelo lambda equivalente. Remova este overlay quando o port
do vcpkg trouxer a correção.
