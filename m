From: Grant Grundler <grundler@parisc-linux.org>
Subject: [PATCH] PA-RISC update to 87415
Date: Wed, 3 Nov 2004 13:00:59 -0700
Message-ID: <20041103200059.GC17672@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from colo.lackof.org ([198.49.126.79]:7901 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261843AbUKCUBD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Nov 2004 15:01:03 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: matthew@wil.cx, linux-ide@vger.kernel.org

Bartlomiej,
Here's a "final" patch to cleanup the exporting of IDE data
to suckyio support. I sent this before but it wasn't "verified"
at the time:
http://marc.theaimsgroup.com/?l=linux-ide&m=109587104530498&w=2

It's verified now to work and should be applied.

Changelog comment should read:
	Move Superio (NatSem 87560) IDE hacks into the ns87415 driver
	instead of exporting IDE data structures.
	To date, only PA-RISC port is known to use the 87560 chip.

thanks,
grant

----- Forwarded message from Matthew Wilcox <matthew@wil.cx> -----

tp://cvs.parisc-linux.org/linux-2.6/arch/parisc/kernel/drivers.c.diff?cvsroot=&r1=1.15&r2=1.16
http://cvs.parisc-linux.org/linux-2.6/include/asm-parisc/io.h.diff?cvsroot=&r1=1.11&r2=1.12

: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: <willy@www.linux.org.uk>
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lackof.org
X-Spam-Checker-Version: SpamAssassin 2.64 (2004-01-11) on colo.lackof.org
X-Spam-Status: No, hits=-2.7 required=5.0 tests=BAYES_00,DOMAIN_BODY 
	autolearn=no version=2.64
X-Spam-Level: 
Status: O
Content-Length: 4519
Lines: 136


Can I have a better description for this patch than "Superio
cleanup"?  And if you'd like to send it to Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> yourself, that's more than fine by me ;-)

diff -urpNX dontdiff linux-2.6.10-rc1-bk13/drivers/ide/pci/ns87415.c parisc-2.6-bk/drivers/ide/pci/ns87415.c
--- linux-2.6.10-rc1-bk13/drivers/ide/pci/ns87415.c	Fri Oct 22 15:39:07 2004
+++ parisc-2.6-bk/drivers/ide/pci/ns87415.c	Wed Nov  3 06:19:00 2004
@@ -4,6 +4,7 @@
  * Copyright (C) 1997-1998	Mark Lord <mlord@pobox.com>
  * Copyright (C) 1998		Eddie C. Dost <ecd@skynet.be>
  * Copyright (C) 1999-2000	Andre Hedrick <andre@linux-ide.org>
+ * Copyright (C) 2004		Grant Grundler <grundler at parisc-linux.org>
  *
  * Inspired by an earlier effort from David S. Miller <davem@redhat.com>
  */
@@ -25,6 +26,75 @@
 
 #include <asm/io.h>
 
+#ifdef CONFIG_SUPERIO
+/* SUPERIO 87560 is a PoS chip that NatSem denies exists.
+ * Unfortunately, it's built-in on all Astro-based PA-RISC workstations
+ * which use the integrated NS87514 cell for CD-ROM support.
+ * i.e we have to support for CD-ROM installs.
+ * See drivers/parisc/superio.c for more gory details.
+ */
+#include <asm/superio.h>
+
+static unsigned long superio_ide_status[2];
+static unsigned long superio_ide_select[2];
+static unsigned long superio_ide_dma_status[2];
+
+#define SUPERIO_IDE_MAX_RETRIES 25
+
+/* Because of a defect in Super I/O, all reads of the PCI DMA status 
+ * registers, IDE status register and the IDE select register need to be 
+ * retried
+ */
+static u8 superio_ide_inb (unsigned long port)
+{
+	if (port == superio_ide_status[0] ||
+	    port == superio_ide_status[1] ||
+	    port == superio_ide_select[0] ||
+	    port == superio_ide_select[1] ||
+	    port == superio_ide_dma_status[0] ||
+	    port == superio_ide_dma_status[1]) {
+		u8 tmp;
+		int retries = SUPERIO_IDE_MAX_RETRIES;
+
+		/* printk(" [ reading port 0x%x with retry ] ", port); */
+
+		do {
+			tmp = inb(port);
+			if (tmp == 0)
+				udelay(50);
+		} while (tmp == 0 && retries-- > 0);
+
+		return tmp;
+	}
+
+	return inb(port);
+}
+
+static void __devinit superio_ide_init_iops (struct hwif_s *hwif)
+{
+	u32 base, dmabase;
+	u8 tmp;
+	struct pci_dev *pdev = hwif->pci_dev;
+	u8 port = hwif->channel;
+
+	base = pci_resource_start(pdev, port * 2) & ~3;
+	dmabase = pci_resource_start(pdev, 4) & ~3;
+
+	superio_ide_status[port] = base + IDE_STATUS_OFFSET;
+	superio_ide_select[port] = base + IDE_SELECT_OFFSET;
+	superio_ide_dma_status[port] = dmabase + (!port ? 2 : 0xa);
+	
+	/* Clear error/interrupt, enable dma */
+	tmp = superio_ide_inb(superio_ide_dma_status[port]);
+	outb(tmp | 0x66, superio_ide_dma_status[port]);
+
+	/* We need to override inb to workaround a SuperIO errata */
+	hwif->INB = superio_ide_inb;
+}
+#else
+static void __devinit superio_ide_init_iops (struct hwif_s *hwif) {}
+#endif
+
 static unsigned int ns87415_count = 0, ns87415_control[MAX_HWIFS] = { 0 };
 
 /*
@@ -119,6 +189,16 @@ static int ns87415_ide_dma_check (ide_dr
 	return __ide_dma_check(drive);
 }
 
+static void __init init_iops_ns87415(ide_hwif_t *hwif)
+{
+#ifdef CONFIG_PARISC
+	if (PCI_SLOT(hwif->pci_dev->devfn) == 0xE) {
+		/* Built-in - assume it's under superio. */
+		superio_ide_init_iops(hwif);
+	}
+#endif
+}
+
 static void __init init_hwif_ns87415 (ide_hwif_t *hwif)
 {
 	struct pci_dev *dev = hwif->pci_dev;
@@ -132,10 +212,6 @@ static void __init init_hwif_ns87415 (id
 	hwif->autodma = 0;
 	hwif->selectproc = &ns87415_selectproc;
 
-	/* Set a good latency timer and cache line size value. */
-	(void) pci_write_config_byte(dev, PCI_LATENCY_TIMER, 64);
-	/* FIXME: use pci_set_master() to ensure good latency timer value */
-
 	/*
 	 * We cannot probe for IRQ: both ports share common IRQ on INTA.
 	 * Also, leave IRQ masked during drive probing, to prevent infinite
@@ -205,6 +281,7 @@ static void __init init_hwif_ns87415 (id
 
 static ide_pci_device_t ns87415_chipset __devinitdata = {
 	.name		= "NS87415",
+	.init_iops	= init_iops_ns87415,
 	.init_hwif	= init_hwif_ns87415,
 	.channels	= 2,
 	.autodma	= AUTODMA,

-- 
"Next the s
----- End forwarded message -----
