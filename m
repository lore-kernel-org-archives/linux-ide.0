From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH] pata_mpc52xx: driver needs BMDMA
Date: Tue, 14 Dec 2010 23:32:47 +0100
Message-ID: <1292365967-14867-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57165 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758902Ab0LNWdR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Dec 2010 17:33:17 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linuxppc-dev@ozlabs.org
Cc: Wolfram Sang <w.sang@pengutronix.de>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Found by this build-error:

drivers/ata/pata_mpc52xx.c: In function 'mpc52xx_ata_init_one':
drivers/ata/pata_mpc52xx.c:662: error: 'ata_bmdma_interrupt' undeclared (first use in this function)

So, move the Kconfig entry to the proper location.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/ata/Kconfig  |   20 ++++++++++----------
 drivers/ata/Makefile |    2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 11ec911..85756b8 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -128,16 +128,6 @@ config PDC_ADMA
 
 	  If unsure, say N.
 
-config PATA_MPC52xx
-	tristate "Freescale MPC52xx SoC internal IDE"
-	depends on PPC_MPC52xx && PPC_BESTCOMM
-	select PPC_BESTCOMM_ATA
-	help
-	  This option enables support for integrated IDE controller
-	  of the Freescale MPC52xx SoC.
-
-	  If unsure, say N.
-
 config PATA_OCTEON_CF
 	tristate "OCTEON Boot Bus Compact Flash support"
 	depends on CPU_CAVIUM_OCTEON
@@ -491,6 +481,16 @@ config PATA_MARVELL
 
 	  If unsure, say N.
 
+config PATA_MPC52xx
+	tristate "Freescale MPC52xx SoC internal IDE"
+	depends on PPC_MPC52xx && PPC_BESTCOMM
+	select PPC_BESTCOMM_ATA
+	help
+	  This option enables support for integrated IDE controller
+	  of the Freescale MPC52xx SoC.
+
+	  If unsure, say N.
+
 config PATA_NETCELL
 	tristate "NETCELL Revolution RAID support"
 	depends on PCI
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index c501af5..2b67c90 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -11,7 +11,6 @@ obj-$(CONFIG_SATA_DWC)		+= sata_dwc_460ex.o
 
 # SFF w/ custom DMA
 obj-$(CONFIG_PDC_ADMA)		+= pdc_adma.o
-obj-$(CONFIG_PATA_MPC52xx)	+= pata_mpc52xx.o
 obj-$(CONFIG_PATA_OCTEON_CF)	+= pata_octeon_cf.o
 obj-$(CONFIG_SATA_QSTOR)	+= sata_qstor.o
 obj-$(CONFIG_SATA_SX4)		+= sata_sx4.o
@@ -52,6 +51,7 @@ obj-$(CONFIG_PATA_IT821X)	+= pata_it821x.o
 obj-$(CONFIG_PATA_JMICRON)	+= pata_jmicron.o
 obj-$(CONFIG_PATA_MACIO)	+= pata_macio.o
 obj-$(CONFIG_PATA_MARVELL)	+= pata_marvell.o
+obj-$(CONFIG_PATA_MPC52xx)	+= pata_mpc52xx.o
 obj-$(CONFIG_PATA_NETCELL)	+= pata_netcell.o
 obj-$(CONFIG_PATA_NINJA32)	+= pata_ninja32.o
 obj-$(CONFIG_PATA_NS87415)	+= pata_ns87415.o
-- 
1.7.2.3

