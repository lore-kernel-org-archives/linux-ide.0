From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PATCH: Use the fixup layer to fix the various SI3112 hangs
Date: Fri, 05 Nov 2004 16:42:33 +0000
Message-ID: <1099672950.5630.59.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:14277 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262740AbUKERpZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Nov 2004 12:45:25 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org

The current driver looks at fields before it is safe too, we move the
mod15rm bug handler to be a fixup and this ensures the probe has been
completed before we use the ident data.

diff --exclude-from /usr/src/exclude -u --new-file --recursive
linux.vanilla-2.6.10rc1/drivers/ide/pci/siimage.c
linux-2.6.10rc1/drivers/ide/pci/siimage.c
--- linux.vanilla-2.6.10rc1/drivers/ide/pci/siimage.c	2004-11-05
15:34:47.000000000 +0000
+++ linux-2.6.10rc1/drivers/ide/pci/siimage.c	2004-11-05
16:08:46.000000000 +0000
@@ -988,6 +988,21 @@
 }
 
 /**
+ *	siimage_fixup		-	post probe fixups
+ *	@hwif: interface to fix up
+ *
+ *	Called after drive probe we use this to decide whether the
+ *	Seagate fixup must be applied. This used otbe in init_iops but
+ *	that can occur before we know what drives are present.
+ */
+ 
+static void siimage_fixup(ide_hwif_t *hwif) {
+	/* Try and raise the rqsize */
+	if (!is_sata(hwif) || !is_dev_seagate_sata(&hwif->drives[0]))
+		hwif->rqsize = 128;
+}
+
+/**
  *	init_iops_siimage	-	set up iops
  *	@hwif: interface to set up
  *
@@ -1007,9 +1022,8 @@
 	
 	hwif->hwif_data = NULL;
 
-	hwif->rqsize = 128;
-	if (is_sata(hwif) && is_dev_seagate_sata(&hwif->drives[0]))
-		hwif->rqsize = 15;
+	/* Pessimal until we finish probing */
+	hwif->rqsize = 15;
 
 	if (pci_get_drvdata(dev) == NULL)
 		return;
@@ -1101,6 +1115,7 @@
 		.channels	= 2,			\
 		.autodma	= AUTODMA,		\
 		.bootable	= ON_BOARD,		\
+		.fixup		= siimage_fixup		\
 	}
 
 static ide_pci_device_t siimage_chipsets[] __devinitdata = {

