All the variables .yml files below this directory are read before the
actual provisioning starts.

We first read all the variables under `general/*.yml` (in alphabetical
order), then board-specific settings under `board/$BOARD.yml`, then
optional additional settings under `postproc/*.yml` (in alphabetical
order).

Usually, `general/` would contain device-independent settings like
host name, SSH keys, ADSL connection settings, LAN interface
name. etc.. `board/` contains specific settings for the board we're
targeting, e.g. which physical interfaces make up the LAN and WAN
interface. `postproc/` is processed last and allows the user to
override any settings before they're applied.