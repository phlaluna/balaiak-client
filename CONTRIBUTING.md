# Como contribuir

Obrigado por querer melhorar o cliente do Balaiak OT!

## Fluxo

1. Abra uma *issue* descrevendo o bug ou a ideia (com prints, se ajudar).
2. Faça um fork, crie uma branch a partir da `main` e mande um *pull request*.
3. O CI compila o cliente (Linux, Windows e macOS) e confere a sintaxe do Lua.
   O PR só entra depois de passar no CI e ser revisado pela equipe.

Mantenha cada PR focado em um assunto e explique como testar.

## Rodar na sua máquina

1. Compile seguindo [docs/building](docs/building) (é o mesmo processo do
   OTClient Redemption).
2. Pegue o `Tibia.dat` e o `Tibia.spr` 8.60 da release
   [assets-860](https://github.com/phlaluna/balaiak-client/releases/tag/assets-860)
   e coloque em `data/things/860/` (a pasta é ignorada pelo git — não faça
   commit desses arquivos).
3. Rode o executável na raiz do repositório: ele entra direto no Balaiak OT.

Mudanças só em Lua/OTUI (`modules/`, `mods/`, `data/`) não precisam recompilar:
basta reabrir o cliente.

## Cuidados

- Textos com acento nos `.lua`/`.otui` da interface usam **Latin-1** (a
  codificação das fontes do cliente) — veja
  [docs/string-encoding-policy.md](docs/string-encoding-policy.md).
- O mesmo código roda no navegador: teste com `g_platform.isBrowser()` quando
  algo só fizer sentido em um dos lados.
- Nada de senhas, tokens ou dados de jogadores no código.

## Lançar uma versão (equipe)

`git tag v1.2.3 && git push origin v1.2.3` — o workflow *Release Balaiak OT*
compila os três sistemas e publica a release.
