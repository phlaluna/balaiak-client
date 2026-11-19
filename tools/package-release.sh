#!/usr/bin/env bash
# Monta o pacote pronto para jogar do Balaiak OT (usado por
# .github/workflows/release.yml, mas também roda na sua máquina).
#
#   tools/package-release.sh linux   build/linux-release/bin/otclient
#   tools/package-release.sh windows build/windows-release/bin
#   tools/package-release.sh macos   build-macos/bin/OTClient.app
#
# Junta o executável com init.lua, data/, modules/ e mods/ e coloca o
# Tibia.dat/Tibia.spr 8.60 em data/things/860. Os dois arquivos vêm de
# data/things/860 se já existirem, senão da release "assets-860" deste
# repositório (precisa do gh, com GH_TOKEN no CI).
# Saída: dist/Balaiak-OT-{Linux.tar.gz,Windows.zip,macOS.zip}
set -euo pipefail

os="${1:?uso: $0 linux|windows|macos <executável ou pasta>}"
bin="${2:?informe o executável (linux), a pasta bin (windows) ou o OTClient.app (macos)}"
root="$(cd "$(dirname "$0")/.." && pwd)"
cd "$root"

things="data/things/860"
if [[ ! -f "$things/Tibia.dat" || ! -f "$things/Tibia.spr" ]]; then
  mkdir -p "$things"
  gh release download assets-860 --repo "${GITHUB_REPOSITORY:-phlaluna/balaiak-client}" \
    --pattern 'Tibia.dat' --pattern 'Tibia.spr' --dir "$things" --clobber
fi

stage="$(mktemp -d)"
trap 'rm -rf "$stage"' EXIT
name="Balaiak-OT"
app="$stage/$name"
mkdir -p "$app" dist

# Arquivos do jogo (iguais nos três sistemas).
copy_game_files() {
  local dest="$1"
  mkdir -p "$dest"
  cp init.lua otclientrc.lua config.ini cacert.pem "$dest/"
  cp -R data modules mods "$dest/"
  cp LICENSE "$dest/LICENSE-OTClient.txt"
  cp docs/balaiak/LEIA-ME.txt "$dest/LEIA-ME.txt"
}

case "$os" in
  linux)
    copy_game_files "$app"
    cp "$bin" "$app/Balaiak-OT"
    chmod +x "$app/Balaiak-OT"
    strip --strip-debug "$app/Balaiak-OT"  # tira os símbolos de depuração (RelWithDebInfo)
    tar -C "$stage" -czf "dist/$name-Linux.tar.gz" "$name"
    ;;
  windows)
    copy_game_files "$app"
    cp "$bin/otclient.exe" "$app/Balaiak-OT.exe"
    # DLLs que o build deixar ao lado do executável (o build estático não deixa nenhuma).
    find "$bin" -maxdepth 1 -iname '*.dll' -exec cp {} "$app/" \;
    (cd "$stage" && 7z a -tzip -mx=7 "$root/dist/$name-Windows.zip" "$name" >/dev/null)
    ;;
  macos)
    bundle="$stage/Balaiak OT.app"
    cp -R "$bin" "$bundle"
    # No Mac o cliente procura init.lua em Contents/Resources.
    copy_game_files "$bundle/Contents/Resources"
    plist="$bundle/Contents/Info.plist"
    /usr/libexec/PlistBuddy -c "Set :CFBundleName Balaiak OT" "$plist"
    /usr/libexec/PlistBuddy -c "Set :CFBundleDisplayName Balaiak OT" "$plist" 2>/dev/null \
      || /usr/libexec/PlistBuddy -c "Add :CFBundleDisplayName string Balaiak OT" "$plist"
    /usr/libexec/PlistBuddy -c "Set :CFBundleIdentifier com.servegame.balaiak" "$plist"
    xattr -cr "$bundle"
    codesign --force --deep --sign - "$bundle"
    (cd "$stage" && ditto -c -k --keepParent "Balaiak OT.app" "$root/dist/$name-macOS.zip")
    ;;
  *)
    echo "sistema desconhecido: $os" >&2
    exit 1
    ;;
esac

ls -la dist/
