From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 0/4] Support for Marvell AHCI interface on Armada 38x
Date: Mon,  7 Apr 2014 16:57:40 +0200
Message-ID: <1396882664-19297-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:48375 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755472AbaDGO5r (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Apr 2014 10:57:47 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org

Hello,

The Marvell Armada 38x ARM processors use an AHCI compatible interface
for SATA (in replacement of the Marvell-specific SATA interface,
handled by the sata_mv driver). However, like all DMA-capable Marvell
interfaces, some specific MBus window configuration must be done, so a
small specific glue layer is needed, which relies on the recently
introduced libahci_platform.c.

The first patch of this series contains the driver itself, which is
fairly straight-forward. It should be taken by Tejun Heo as the ATA
maintainer.

The last three patches add the Device Tree and defconfig changes. They
should be taken by the respective ARM maintainers (mvebu maintainers
for the DT and mvebu_v7_defconfig, and arm-soc maintainers for the
multi_v7_defconfig change).

This series is currently based on linux-next. If this is a problem for
merging, I'll resend a new version once 3.15-rc1 lands.

Thanks!

Thomas

Thomas Petazzoni (4):
  ata: ahci_mvebu: new driver for Marvell Armada 380 AHCI interfaces
  ARM: mvebu: add Device Tree description of AHCI interfaces on Armada
    38x
  ARM: configs: add ahci_mvebu to mvebu_v7_defconfig
  ARM: configs: add ahci_mvebu to multi_v7_defconfig

 .../devicetree/bindings/ata/ahci-platform.txt      |   3 +-
 arch/arm/boot/dts/armada-385-db.dts                |   8 ++
 arch/arm/boot/dts/armada-38x.dtsi                  |  16 ++++
 arch/arm/configs/multi_v7_defconfig                |   1 +
 arch/arm/configs/mvebu_v7_defconfig                |   1 +
 drivers/ata/Kconfig                                |   9 ++
 drivers/ata/Makefile                               |   1 +
 drivers/ata/ahci_mvebu.c                           | 105 +++++++++++++++++++++
 8 files changed, 143 insertions(+), 1 deletion(-)
 create mode 100644 drivers/ata/ahci_mvebu.c

-- 
1.8.3.2

