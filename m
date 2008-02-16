From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 09/12] ide: move default IDE ports setup to ide_generic host driver
Date: Sat, 16 Feb 2008 17:39:53 +0100
Message-ID: <20080216163953.10174.29472.sendpatchset@localhost.localdomain>
References: <20080216163856.10174.72546.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:14693 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273AbYBPQZW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Feb 2008 11:25:22 -0500
Received: by fg-out-1718.google.com with SMTP id e21so842257fga.17
        for <linux-ide@vger.kernel.org>; Sat, 16 Feb 2008 08:25:21 -0800 (PST)
In-Reply-To: <20080216163856.10174.72546.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

* Make CONFIG_IDE_GENERIC depended on CONFIG_IDE_ARCH_OBSOLETE_DEFAULTS.

* Move default IDE ports setup from init_ide_data() to ide_generic
  host driver (remembering to not break "idex=noprobe" parameter).

* Use ide_init_port_hw() in ide_generic host driver.

* Remove no longer needed CONFIG_IDE_ARCH_OBSOLETE_DEFAULTS.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/Kconfig       |    4 +---
 drivers/ide/ide-generic.c |   16 +++++++++++++---
 drivers/ide/ide.c         |   18 ------------------
 3 files changed, 14 insertions(+), 24 deletions(-)

Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -307,6 +307,7 @@ comment "IDE chipset support/bugfixes"
 
 config IDE_GENERIC
 	tristate "generic/default IDE chipset support"
+	depends on ALPHA || X86 || IA64 || M32R || MIPS || PPC32
 	help
 	  If unsure, say N.
 
@@ -1096,9 +1097,6 @@ config BLK_DEV_IDEDMA
 	def_bool BLK_DEV_IDEDMA_SFF || BLK_DEV_IDEDMA_PMAC || \
 		 BLK_DEV_IDEDMA_ICS || BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
 
-config IDE_ARCH_OBSOLETE_DEFAULTS
-	def_bool ALPHA || X86 || IA64 || M32R || MIPS || PPC32
-
 endif
 
 config BLK_DEV_HD_ONLY
Index: b/drivers/ide/ide-generic.c
===================================================================
--- a/drivers/ide/ide-generic.c
+++ b/drivers/ide/ide-generic.c
@@ -94,11 +94,21 @@ static int __init ide_generic_init(void)
 
 	for (i = 0; i < MAX_HWIFS; i++) {
 		ide_hwif_t *hwif = &ide_hwifs[i];
+		unsigned long io_addr = ide_default_io_base(i);
+		hw_regs_t hw;
+
+		if (hwif->chipset == ide_unknown && io_addr) {
+			u8 oldnoprobe = hwif->noprobe;
+
+			memset(&hw, 0, sizeof(hw));
+			ide_std_init_ports(&hw, io_addr, io_addr + 0x206);
+			hw.irq = ide_init_default_irq(io_addr);
+			ide_init_port_hw(hwif, &hw);
+
+			hwif->noprobe = oldnoprobe;
 
-		if (hwif->io_ports[IDE_DATA_OFFSET] &&
-		    hwif->chipset == ide_unknown)
 			idx[i] = i;
-		else
+		} else
 			idx[i] = 0xff;
 	}
 
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -167,12 +167,6 @@ static void ide_port_init_devices_data(i
 	}
 }
 
-#ifndef CONFIG_IDE_ARCH_OBSOLETE_DEFAULTS
-# define ide_default_io_base(index)	(0)
-# define ide_default_irq(base)		(0)
-# define ide_init_default_irq(base)	(0)
-#endif
-
 /*
  * init_ide_data() sets reasonable default values into all fields
  * of all instances of the hwifs and drives, but only on the first call.
@@ -195,7 +189,6 @@ static void __init init_ide_data (void)
 {
 	unsigned int index;
 	static unsigned long magic_cookie = MAGIC_COOKIE;
-	hw_regs_t hw;
 
 	if (magic_cookie != MAGIC_COOKIE)
 		return;		/* already initialized */
@@ -204,19 +197,8 @@ static void __init init_ide_data (void)
 	/* Initialise all interface structures */
 	for (index = 0; index < MAX_HWIFS; ++index) {
 		ide_hwif_t *hwif = &ide_hwifs[index];
-		unsigned long io_addr = ide_default_io_base(index);
-		unsigned long ctl_addr = io_addr + 0x206;
 
 		ide_init_port_data(hwif, index);
-
-#ifdef CONFIG_IDE_ARCH_OBSOLETE_DEFAULTS
-		memset(&hw, 0, sizeof(hw));
-		ide_std_init_ports(&hw, io_addr, ctl_addr);
-		memcpy(hwif->io_ports, hw.io_ports, sizeof(hw.io_ports));
-		hwif->noprobe = !hwif->io_ports[IDE_DATA_OFFSET];
-		hwif->irq =
-			ide_init_default_irq(hwif->io_ports[IDE_DATA_OFFSET]);
-#endif
 	}
 }
 
