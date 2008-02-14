From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/2] ide: remove CONFIG_IDE_ARCH_OBSOLETE_INIT
Date: Thu, 14 Feb 2008 21:56:19 +0100
Message-ID: <200802142156.19997.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.233]:58912 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbYBNUmm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 15:42:42 -0500
Received: by hu-out-0506.google.com with SMTP id 19so10252117hue.21
        for <linux-ide@vger.kernel.org>; Thu, 14 Feb 2008 12:42:41 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

* Use CONFIG_IDE_ARCH_OBSOLETE_DEFAULTS instead of
  CONFIG_IDE_ARCH_OBSOLETE_INIT in init_ide_data().

* Remove no longer needed CONFIG_IDE_ARCH_OBSOLETE_INIT.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/Kconfig |    3 ---
 drivers/ide/ide.c   |    4 ++--
 2 files changed, 2 insertions(+), 5 deletions(-)

Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -1096,9 +1096,6 @@ config BLK_DEV_IDEDMA
 	def_bool BLK_DEV_IDEDMA_SFF || BLK_DEV_IDEDMA_PMAC || \
 		 BLK_DEV_IDEDMA_ICS || BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
 
-config IDE_ARCH_OBSOLETE_INIT
-	def_bool ALPHA || (ARM && !ARCH_L7200) || BLACKFIN || X86 || IA64 || M32R || MIPS || PARISC || PPC || (SUPERH64 && BLK_DEV_IDEPCI) || SPARC
-
 config IDE_ARCH_OBSOLETE_DEFAULTS
 	def_bool ALPHA || X86 || IA64 || M32R || MIPS || PPC32
 
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -209,16 +209,16 @@ static void __init init_ide_data (void)
 
 		ide_init_port_data(hwif, index);
 
-#ifdef CONFIG_IDE_ARCH_OBSOLETE_INIT
+#ifdef CONFIG_IDE_ARCH_OBSOLETE_DEFAULTS
 		memset(&hw, 0, sizeof(hw));
 		ide_std_init_ports(&hw, io_addr, ctl_addr);
 		memcpy(hwif->io_ports, hw.io_ports, sizeof(hw.io_ports));
-#endif
 		hwif->noprobe = !hwif->io_ports[IDE_DATA_OFFSET];
 #if !defined(CONFIG_PPC32) || defined(CONFIG_PPLUS) || !defined(CONFIG_PCI)
 		hwif->irq =
 			ide_init_default_irq(hwif->io_ports[IDE_DATA_OFFSET]);
 #endif
+#endif
 	}
 }
 
