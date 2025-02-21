# Sway 1.10 on Ubuntu 24.04

Sway 1.10 with recent [wlroots](https://gitlab.freedesktop.org/wlroots/wlroots/-/merge_requests/4715/diffs) added explicit synchronization which reduces (but not completely removes) screen tearing on _native nvidia drivers_.

Recommended driver is 560.35.03

In combination with some custom patches it is possible to run sway on nvidia without crashes and scree tearing.

Unfortunately, sway 1.10 is not available on Ubuntu 24.04, not even through backports. So, we have to build our own version. But the recent sway requires recent wlroots, wayland and libinput libraries. So we have to (a) include those into the build or build it separately.

## Build & install

### Build & install libinput

```shell
./libinput-rebuild.sh
./libinput-install.sh
```

### Build & install sway

The script checks out sway and related subprojects from their repositories and applies a few patches.

```shell
./sway-rebuild.sh
./sway-install.sh
```

### Start sway

Make sure sway is not installed from apt.

```shell
sway
```

## Future development

In case you want to change something in the sway project. Just edit it in the `sway/` directory and then run the following script which will update patch files in the `patch/` directory. The patch then gets applied during future rebuilds.

```shell
./sway-create-patch.sh
```
