From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: [PATCH] libata DMADIR support
Date: 16 May 2004 08:19:06 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084717146.3576.3.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:43402 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S263612AbUEPOT1
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 May 2004 10:19:27 -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff G:

I've now slowly and awkwardly synced as the following tty log of patch
and a #define patch of my own show.  Therefore I ask:

Have you considered an include/linux/libata.h approach like:

+ #undef ATA_FORCE_DMADIR /* give Si DMADIR to all SATA ATAPI DMA */

+ #include <linux/ata.h>
+ #ifdef ATA_FORCE_DMADIR
+ #undef ata_id_use_dmadir
+ #define ata_id_use_dmadir(dev) 1
+ #endif

I'll save time in the end if I volunteer to write such a patch, after
you reply to say you would consider such a patch, if in fact you would.

Pat LaVarre

$ cd linux-2.6.6-bk3/
$
$ patch --dry-run -p1 <~/patch.2.1
patching file drivers/scsi/libata-core.c
patching file drivers/scsi/libata-scsi.c
$ patch --dry-run -p1 <~/patch.dmadir
patching file drivers/scsi/libata-core.c
patching file drivers/scsi/libata-scsi.c
patching file include/linux/ata.h
patching file include/linux/libata.h
$
$ patch -p1 <~/patch.2.1
patching file drivers/scsi/libata-core.c
patching file drivers/scsi/libata-scsi.c
$ patch -p1 <~/patch.dmadir
patching file drivers/scsi/libata-core.c
patching file drivers/scsi/libata-scsi.c
Hunk #1 succeeded at 927 (offset 7 lines).
patching file include/linux/ata.h
patching file include/linux/libata.h
$

diff -Nurp o/include/linux/ata.h linux-2.6.6-bk3-pel/include/linux/ata.h
--- o/include/linux/ata.h	2004-05-16 08:06:04.000000000 -0600
+++ linux-2.6.6-bk3-pel/include/linux/ata.h	2004-05-16
08:09:04.473768304 -0600
@@ -205,7 +205,7 @@ struct ata_taskfile {
 #define ata_id_has_wcache(dev)	((dev)->id[82] & (1 << 5))
 #define ata_id_has_lba(dev)	((dev)->id[49] & (1 << 8))
 #define ata_id_has_dma(dev)	((dev)->id[49] & (1 << 9))
-#define ata_id_use_dmadir(dev)	((dev)->id[62] & (1 << 15))
+#define ata_id_use_dmadir(dev)	1 /* ((dev)->id[62] & (1 << 15)) */
 #define ata_id_u32(dev,n)	\
 	(((u32) (dev)->id[(n) + 1] << 16) | ((u32) (dev)->id[(n)]))
 #define ata_id_u64(dev,n)	\
diff -Nurp o/include/linux/libata.h
linux-2.6.6-bk3-pel/include/linux/libata.h
--- o/include/linux/libata.h	2004-05-16 08:06:23.000000000 -0600
+++ linux-2.6.6-bk3-pel/include/linux/libata.h	2004-05-16
08:09:22.811980472 -0600
@@ -33,11 +33,11 @@
  * compile-time options
  */
 #undef ATA_FORCE_PIO		/* do not configure or use DMA */
-#undef ATA_DEBUG		/* debugging output */
-#undef ATA_VERBOSE_DEBUG	/* yet more debugging output */
+#define ATA_DEBUG		/* debugging output */
+#define ATA_VERBOSE_DEBUG	/* yet more debugging output */
 #undef ATA_IRQ_TRAP		/* define to ack screaming irqs */
 #undef ATA_NDEBUG		/* define to disable quick runtime checks */
-#undef ATA_ENABLE_ATAPI		/* define to enable ATAPI support */
+#define ATA_ENABLE_ATAPI		/* define to enable ATAPI support */
 #undef ATA_ENABLE_PATA		/* define to enable PATA support in some
 				 * low-level drivers */
 
diff -Nurp o/drivers/scsi/libata-core.c
linux-2.6.6-bk3-pel/drivers/scsi/libata-core.c
diff -Nurp o/drivers/scsi/libata-scsi.c
linux-2.6.6-bk3-pel/drivers/scsi/libata-scsi.c


