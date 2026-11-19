# Balaiak OT — cliente

Cliente do servidor **Balaiak OT** (Tibia 8.60), baseado no
[OTClient Redemption](https://github.com/mehah/otclient). É o mesmo código do
cliente que roda no navegador em <https://balaiak.servegame.com/jogar/>.

## Baixar e jogar

Na página de [releases](https://github.com/phlaluna/balaiak-client/releases/latest):

| Sistema | Arquivo |
|---|---|
| Windows 10/11 (64 bits) | `Balaiak-OT-Windows.zip` |
| Linux (Ubuntu 24.04 ou mais novo) | `Balaiak-OT-Linux.tar.gz` |
| macOS (Apple Silicon) | `Balaiak-OT-macOS.zip` |

Crie a conta em <https://balaiak.servegame.com> e entre com ela no cliente. O
`LEIA-ME.txt` dentro de cada pacote explica como abrir em cada sistema (os
apps não são assinados).

## O que muda em relação ao OTClient Redemption

- Servidor `balaiak.servegame.com:7171` (8.60) já configurado; a tela de login só pede conta e senha.
- Português por padrão, fundo e tela de abertura do Balaiak, sem música de abertura.
- **Trade Bazar**: clique direito num item da mochila → anuncia no Bazar do site (venda por Pix).
- Bot: exportar/importar configs pela janela *Edit* (no navegador baixa/abre `.zip`; no computador abre a pasta das configs) e correção do travamento ao ligar o bot.
- Barra de ações salva por personagem, painel de botões corrigido e joystick do celular sem derrubar o personagem.
- Navegador: página com escala de celular, tela cheia e ponte WebSocket (`browser/`).

## Contribuir

Ideias, bugs e melhorias são bem-vindos — veja o [CONTRIBUTING.md](CONTRIBUTING.md).

## Créditos e licença

Código do [OTClient Redemption](https://github.com/mehah/otclient) e dos seus
contribuidores, sob a [licença MIT](LICENSE); o README original está em
[docs/README-otclient.md](docs/README-otclient.md). Os arquivos `Tibia.dat` e
`Tibia.spr` não fazem parte deste repositório: vão só nos pacotes das releases.
Tibia é marca registrada da CipSoft GmbH. Este projeto não tem afiliação com a
CipSoft GmbH.
