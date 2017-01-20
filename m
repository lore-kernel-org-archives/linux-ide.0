From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 00/14] ARM: da850-lcdk: add SATA support
Date: Fri, 20 Jan 2017 12:21:51 +0100
Message-ID: <1484911325-23425-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36346 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751658AbdATLWK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jan 2017 06:22:10 -0500
Received: by mail-wm0-f42.google.com with SMTP id c85so32863834wmi.1
        for <linux-ide@vger.kernel.org>; Fri, 20 Jan 2017 03:22:09 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, David Lechner <david@lechnology.com>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

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

Patch 12/14 removes a no longer needed BUG_ON.

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

v3 -> v4:
- added a patch removing the no longer needed BUG_ON() from
  da850_register_sata()
- fixed indents

v4 ->v5:
- renamed the DT node for the SATA controller from 'ahci' to 'sata',
  while keeping the label as 'sata'
- renamed the SATA node in the DT example as well
- instead of calling the refclk clock 'dummy', called it 'fixed rate'

Bartosz Golaszewski (14):
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
  ARM: davinci: remove BUG_ON() from da850_register_sata()
  ARM: dts: da850: add the SATA node
  ARM: dts: da850-lcdk: enable the SATA node

 .../devicetree/bindings/ata/ahci-da850.txt         |  15 ++
 arch/arm/boot/dts/da850-lcdk.dts                   |   4 +
 arch/arm/boot/dts/da850.dtsi                       |   6 +
 arch/arm/configs/davinci_all_defconfig             |   2 +
 arch/arm/mach-davinci/da850.c                      |   2 +-
 arch/arm/mach-davinci/da8xx-dt.c                   |   9 ++
 arch/arm/mach-davinci/devices-da8xx.c              |  30 +++-
 arch/arm/mach-davinci/include/mach/da8xx.h         |   1 +
 drivers/ata/ahci.h                                 |   3 +
 drivers/ata/ahci_da850.c                           | 175 +++++++++++++++++++--
 drivers/ata/libahci.c                              |  18 ++-
 11 files changed, 240 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-da850.txt

-- 
2.9.3

