# RA Saturn lightgun input does not work with X-GUNNER / Virtua Gun

## Summary

The RetroAchievements Saturn core release `poc` appears to predate the upstream MiSTer Saturn lightgun reset fix. With an X-GUNNER LCD lightgun, the same mappings work in an older normal Saturn core, but the RA Saturn core does not show a crosshair and does not pass trigger/lightgun input in-game.

## Tested Behavior

- Normal `Saturn_20251003.rbf`: Virtua Cop 2 lightgun input works.
- Normal `Saturn_20260713.rbf`: lightgun input fails.
- RA `Saturn.rbf` from `odelot/Saturn_MiSTer` release `poc`: lightgun input fails.
- Patched `MiSTer_RA` launcher now recognizes the X-GUNNER like the normal patched `MiSTer` launcher, so the remaining RA Saturn failure appears to be core-side.

Core `.rbf` files are not included in this repository.

## Evidence

The current RA Saturn source has both lightgun modules wired as:

```systemverilog
.RESET(~rst_sys),
```

Upstream MiSTer Saturn commit `526332d4c06291e4b402ace3c753a4baf08f5074` changed both lightgun module instances to:

```systemverilog
.RESET(rst_sys),
```

Commit:

https://github.com/MiSTer-devel/Saturn_MiSTer/commit/526332d4c06291e4b402ace3c753a4baf08f5074

## Requested Fix

Please rebuild/publish the RA Saturn core with the upstream lightgun reset fix cherry-picked.

Minimal patch:

```diff
diff --git a/Saturn.sv b/Saturn.sv
index 1451bbe..edaa33e 100644
--- a/Saturn.sv
+++ b/Saturn.sv
@@ -1240 +1240 @@ module emu
-		.RESET(~rst_sys),
+		.RESET(rst_sys),
@@ -1297 +1297 @@ module emu
-		.RESET(~rst_sys),
+		.RESET(rst_sys),
```
