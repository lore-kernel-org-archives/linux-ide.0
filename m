From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCHv3 0/5] Support for Marvell AHCI interface on Armada 38x
Date: Tue, 15 Apr 2014 17:00:01 +0200
Message-ID: <1397574006-5868-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:41239 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750999AbaDOPAJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Apr 2014 11:00:09 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hello,

The Marvell Armada 38x ARM processors use an AHCI compatible interface
for SATA (in replacement of the Marvell-specific SATA interface,
handled by the sata_mv driver). However, like all DMA-capable Marvell
interfaces, some specific MBus window configuration must be done, so a
small specific glue layer is needed, which relies on the recently
introduced libahci_platform.c.

Changes since v2:

 * Added Acked-by from Andrew Lunn <andrew@lunn.ch> on the first
   patch.

 * Added comment in the code to explain why we don't have
   suspend/resume support for now. Suggested by Bartlomiej
   Zolnierkiewicz.

 * Added a ahci_mvebu_regret_option() function which enables the
   vendor-specific regret bit, which allows to solve a potential
   deadlock situation in the AHCI interface.

Changes since v1:

 * Rebased on top of v3.15-rc1

 * Added a preliminary patch that orders alphabetically the list of
   compatible strings in the DT binding document
   ahci-platform.txt. Suggested by Andrew Lunn.

 * Made the availability of MBus DRAM window informations
   mandatory. Suggested by Andrew Lunn.

 * Fixed the module alias name. Suggested by Bartlomiej
   Zolnierkiewicz.

Details of the patches:

 * The first patch is a DT binding documentation cleanup. I believe it
   should be taken by the ATA maintainer, because the second patch
   (driver patch) depends on it.

 * The second patch of this series contains the driver itself, which
   is fairly straight-forward. It should be taken by Tejun Heo as the
   ATA maintainer.

 * The last three patches add the Device Tree and defconfig
   changes. They should be taken by the respective ARM maintainers
   (mvebu maintainers for the DT and mvebu_v7_defconfig, and arm-soc
   maintainers for the multi_v7_defconfig change).

Thanks!

Thomas

Thomas Petazzoni (5):
  Documentation: dt-bindings: reformat and order list of ahci-platform
    compatibles
  ata: ahci_mvebu: new driver for Marvell Armada 380 AHCI interfaces
  ARM: mvebu: add Device Tree description of AHCI interfaces on Armada
    38x
  ARM: configs: add ahci_mvebu to mvebu_v7_defconfig
  ARM: configs: add ahci_mvebu to multi_v7_defconfig

 .../devicetree/bindings/ata/ahci-platform.txt      |  13 ++-
 arch/arm/boot/dts/armada-385-db.dts                |   8 ++
 arch/arm/boot/dts/armada-38x.dtsi                  |  16 +++
 arch/arm/configs/multi_v7_defconfig                |   1 +
 arch/arm/configs/mvebu_v7_defconfig                |   1 +
 drivers/ata/Kconfig                                |   9 ++
 drivers/ata/Makefile                               |   1 +
 drivers/ata/ahci_mvebu.c                           | 127 +++++++++++++++++++++
 8 files changed, 172 insertions(+), 4 deletions(-)
 create mode 100644 drivers/ata/ahci_mvebu.c

-- 
1.9.2

