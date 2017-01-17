From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 00/14] ARM: da850-lcdk: add SATA support
Date: Tue, 17 Jan 2017 13:26:02 +0100
Message-ID: <1484655976-25382-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38876 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbdAQM0k (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jan 2017 07:26:40 -0500
Received: by mail-wm0-f51.google.com with SMTP id r144so219851074wme.1
        for <linux-ide@vger.kernel.org>; Tue, 17 Jan 2017 04:26:39 -0800 (PST)
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

Last three patches add device tree changes required to probe the
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

Bartosz Golaszewski (14):
  devicetree: bindings: add bindings for ahci-da850
  ARM: davinci_all_defconfig: enable SATA modules
  ARM: davinci: add a clock lookup entry for the SATA clock
  sata: ahci-da850: get the sata clock using a connector id
  ARM: davinci: da850: add con_id for the SATA clock
  ARM: davinci: da850: model the SATA refclk
  sata: ahci-da850: add device tree match table
  sata: ahci-da850: implement a workaround for the softreset quirk
  sata: ahci: export ahci_do_hardreset() locally
  sata: ahci-da850: add a workaround for controller instability
  sata: ahci-da850: un-hardcode the MPY bits
  ARM: dts: da850: add pinmux settings for the SATA controller
  ARM: dts: da850: add the SATA node
  ARM: dts: da850-lcdk: enable the SATA node

 .../devicetree/bindings/ata/ahci-da850.txt         |  18 +++
 arch/arm/boot/dts/da850-lcdk.dts                   |   4 +
 arch/arm/boot/dts/da850.dtsi                       |  30 ++++
 arch/arm/configs/davinci_all_defconfig             |   2 +
 arch/arm/mach-davinci/da850.c                      |   2 +-
 arch/arm/mach-davinci/da8xx-dt.c                   |   9 ++
 arch/arm/mach-davinci/devices-da8xx.c              |  23 +++
 arch/arm/mach-davinci/include/mach/da8xx.h         |   1 +
 drivers/ata/ahci.h                                 |   3 +
 drivers/ata/ahci_da850.c                           | 172 +++++++++++++++++++--
 drivers/ata/libahci.c                              |  18 ++-
 11 files changed, 262 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-da850.txt

-- 
2.9.3

