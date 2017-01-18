From: Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 00/13] ARM: da850-lcdk: add SATA support
Date: Wed, 18 Jan 2017 14:19:48 +0100
Message-ID: <1484745601-4769-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

This series contains all the changes necessary to make SATA work on
the da850-lcdk board.

The first patch adds DT bindings for the ahci-da850 driver.

The second enables relevant modules in davinci_all_defconfig.

Patches 03/14-06/14 modify the way the clocks are handled regarding
SATA on the da850 platform. We modify the ahci driver to retrieve
the clock via con_id and model the external SATA oscillator as
a real clock.

Patches 07/14-11/14 extend the ahci-da850 driver. Add DT support,
implement workarounds necessary to make SATA work on the da850-lcdk
board and un-hardcode the external clock multiplier.

Last two patches add device tree changes required to probe the
driver.

v1 -> v2:
- dropped patch 04/10 - replaced with local changes in the
  ahci-da850 driver
- added comments explaining the workaround in ahci softreset
- s/0x218000/218000 in the sata DT node label
- added patches chaning the way clocks are handled in the da850 SATA
  code both in arch/ and in the ahci driver
- dropped the clock multiplier property in the DT bindings in favor
  of using struct clk to pass the refclk rate to the driver
- minor tweaks in commit messages

v2 -> v3:
- dropped the clocks property from the ahci-da850 DT binding
- dropped patch 12/14 (SATA pinmux settings)
- dropped an outdated fragment from the commit message in patch 14/14
- s/get_clk()/clk_get()/
- s/connector id/connection id/
- stopped using __div64_32() after noticing that it sometimes produces
  invalid results
- removed the default MPY value from ahci-da850
- registered SATA refclk for board file boot mode as well

Bartosz Golaszewski (13):
  devicetree: bindings: add bindings for ahci-da850
  ARM: davinci_all_defconfig: enable SATA modules
  ARM: davinci: add a clock lookup entry for the SATA clock
  sata: ahci-da850: get the sata clock using a connection id
  ARM: davinci: da850: add con_id for the SATA clock
  ARM: davinci: da850: model the SATA refclk
  sata: ahci-da850: add device tree match table
  sata: ahci-da850: implement a workaround for the softreset quirk
  sata: ahci: export ahci_do_hardreset() locally
  sata: ahci-da850: add a workaround for controller instability
  sata: ahci-da850: un-hardcode the MPY bits
  ARM: dts: da850: add the SATA node
  ARM: dts: da850-lcdk: enable the SATA node

 .../devicetree/bindings/ata/ahci-da850.txt         |  15 ++
 arch/arm/boot/dts/da850-lcdk.dts                   |   4 +
 arch/arm/boot/dts/da850.dtsi                       |   6 +
 arch/arm/configs/davinci_all_defconfig             |   2 +
 arch/arm/mach-davinci/da850.c                      |   2 +-
 arch/arm/mach-davinci/da8xx-dt.c                   |   9 ++
 arch/arm/mach-davinci/devices-da8xx.c              |  29 ++++
 arch/arm/mach-davinci/include/mach/da8xx.h         |   1 +
 drivers/ata/ahci.h                                 |   3 +
 drivers/ata/ahci_da850.c                           | 175 +++++++++++++++++++--
 drivers/ata/libahci.c                              |  18 ++-
 11 files changed, 241 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-da850.txt

-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
