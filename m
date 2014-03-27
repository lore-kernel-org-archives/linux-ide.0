From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v3] ata: fix Marvell SATA driver dependencies
Date: Thu, 27 Mar 2014 13:23:39 +0100
Message-ID: <1668037.2oe7J2B7N4@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:42804 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263AbaC0MYB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Mar 2014 08:24:01 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Make sata_mv host driver depend on PCI || ARCH_DOVE || ARCH_KIRKWOOD ||
ARCH_MV78XX0 || ARCH_MVEBU || ARCH_ORION5X config options as Marvell
SATA support covers both Marvell PCI devices and Marvell Dove, Kirkwood,
MV78xx0, Armada 370/XP and Orion5x SoCs (for non-PCI devices the driver
to work requires suitable device tree node to be defined).  Additionally
allow the driver build if COMPILE_TEST config option is set.

Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v3:
- added dependencies for Marvel Dove and MV78xx0 
v2:
- resynced patch with libata/for-3.15 branch (previous patch was against
  libata/for-next branch and SATA_MV selects GENERIC_PHY in that branch)

 drivers/ata/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

Index: b/drivers/ata/Kconfig
===================================================================
--- a/drivers/ata/Kconfig	2014-03-26 17:59:35.000000000 +0100
+++ b/drivers/ata/Kconfig	2014-03-27 13:14:24.097787880 +0100
@@ -281,6 +281,8 @@ config SATA_HIGHBANK
 
 config SATA_MV
 	tristate "Marvell SATA support"
+	depends on PCI || ARCH_DOVE || ARCH_KIRKWOOD || ARCH_MV78XX0 || \
+		   ARCH_MVEBU || ARCH_ORION5X || COMPILE_TEST
 	help
 	  This option enables support for the Marvell Serial ATA family.
 	  Currently supports 88SX[56]0[48][01] PCI(-X) chips,

