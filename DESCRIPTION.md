
---

### [choco://crushee.portable](choco://crushee.portable)

To use choco:// protocol URLs, install [(unofficial) choco:// Protocol support](https://community.chocolatey.org/packages/choco-protocol-support)

---

## Crushee

Crushee is an image compression tool, powered by Electron and Node.js. You can carefully tune your images locally to meet your needs, without having to re-upload to a web service, or restart an application every time.

![Screenshot](https://cdn.jsdelivr.net/gh/brogers5/chocolatey-package-crushee.portable@7ac62b45f3ff28d01ab6bf6921c48f86a86c289b/Screenshot.png)

### Features

* Input several different image file formats (e.g. JPEG, PNG, GIF, SVG, WebP, AVIF, HEIC)
* Optionally convert to select image file formats (e.g. JPEG, PNG, WebP, AVIF)
* Resize images - define an exact size, or upscale/downscale while preserving the original aspect ratio
* Batch processing - analyze, crush and save multiple images at once!
* Quality Level sliders - experiment and find the perfect balance between picture quality and file size!
* Advanced format-specific options, such as Chroma Subsampling Level and Color Count
* Light/Dark Mode app theme

## Package Parameters

* `/NoShim` - Opt out of creating a GUI shim.
* `/NoDesktopShortcut` - Opt out of creating a Desktop shortcut.
* `/NoProgramsShortcut` - Opt out of creating a Programs shortcut in your Start Menu.
* `/Start` - Automatically start Crushee after installation completes.

## Package Notes

This package may create a [shim](https://docs.chocolatey.org/en-us/features/shim) for `Crushee.exe`, as is typical for a portable application package. However, `shimgen` will create a GUI shim, which will not wait for the underlying process to exit by default. This may cause issues with displaying console output when viewing debug messages. Users requiring this functionality should pass the `--shimgen-waitforexit` switch to ensure the shim behaves correctly.

---

When using the `/Start` package parameter, you may see a large `CLIXML` block logged to `stderr`. This is [a known issue](https://github.com/chocolatey/choco/issues/1016) with Chocolatey's `Start-ChocolateyProcessAsAdmin` cmdlet, and is not necessarily indicative of an error condition. Until this is addressed, you should ensure the `failOnStandardError` feature is disabled while installing/upgrading this package.

---

For future upgrade operations, consider opting into Chocolatey's `useRememberedArgumentsForUpgrades` feature to avoid having to pass the same arguments with each upgrade:

```shell
choco feature enable --name=useRememberedArgumentsForUpgrades
```
