From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 2/4] ide-io-std: shorten ide_{in|out}put_data()
Date: Wed, 18 Mar 2009 21:42:07 +0400
Message-ID: <200903182042.07966.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:38096 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752466AbZCRRlY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Mar 2009 13:41:24 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

ide_{in|out|put_data() can be somewhat shortened by merging the paths doing
16-bit I/O...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch is atop of the latest pata-2.6 series...

 drivers/ide/ide-io-std.c |   60 +++++++++++++++++++++--------------------------
 1 files changed, 28 insertions(+), 32 deletions(-)

Index: linux-2.6/drivers/ide/ide-io-std.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-io-std.c
+++ linux-2.6/drivers/ide/ide-io-std.c
@@ -225,11 +225,10 @@ void ide_input_data(ide_drive_t *drive, 
 	ide_hwif_t *hwif = drive->hwif;
 	struct ide_io_ports *io_ports = &hwif->io_ports;
 	unsigned long data_addr = io_ports->data_addr;
+	unsigned int words = (len + 1) >> 1;
 	u8 io_32bit = drive->io_32bit;
 	u8 mmio = (hwif->host_flags & IDE_HFLAG_MMIO) ? 1 : 0;
 
-	len++;
-
 	if (io_32bit) {
 		unsigned long uninitialized_var(flags);
 
@@ -238,27 +237,26 @@ void ide_input_data(ide_drive_t *drive, 
 			ata_vlb_sync(io_ports->nsect_addr);
 		}
 
+		words >>= 1;
 		if (mmio)
-			__ide_mm_insl((void __iomem *)data_addr, buf, len / 4);
+			__ide_mm_insl((void __iomem *)data_addr, buf, words);
 		else
-			insl(data_addr, buf, len / 4);
+			insl(data_addr, buf, words);
 
 		if ((io_32bit & 2) && !mmio)
 			local_irq_restore(flags);
 
-		if ((len & 3) >= 2) {
-			if (mmio)
-				__ide_mm_insw((void __iomem *)data_addr,
-						(u8 *)buf + (len & ~3), 1);
-			else
-				insw(data_addr, (u8 *)buf + (len & ~3), 1);
-		}
-	} else {
-		if (mmio)
-			__ide_mm_insw((void __iomem *)data_addr, buf, len / 2);
-		else
-			insw(data_addr, buf, len / 2);
+		if (((len + 1) & 3) < 2)
+			return;
+
+		buf += len & ~3;
+		words = 1;
 	}
+
+	if (mmio)
+		__ide_mm_insw((void __iomem *)data_addr, buf, words);
+	else
+		insw(data_addr, buf, words);
 }
 EXPORT_SYMBOL_GPL(ide_input_data);
 
@@ -271,11 +269,10 @@ void ide_output_data(ide_drive_t *drive,
 	ide_hwif_t *hwif = drive->hwif;
 	struct ide_io_ports *io_ports = &hwif->io_ports;
 	unsigned long data_addr = io_ports->data_addr;
+	unsigned int words = (len + 1) >> 1;
 	u8 io_32bit = drive->io_32bit;
 	u8 mmio = (hwif->host_flags & IDE_HFLAG_MMIO) ? 1 : 0;
 
-	len++;
-
 	if (io_32bit) {
 		unsigned long uninitialized_var(flags);
 
@@ -284,27 +281,26 @@ void ide_output_data(ide_drive_t *drive,
 			ata_vlb_sync(io_ports->nsect_addr);
 		}
 
+		words >>= 1;
 		if (mmio)
-			__ide_mm_outsl((void __iomem *)data_addr, buf, len / 4);
+			__ide_mm_outsl((void __iomem *)data_addr, buf, words);
 		else
-			outsl(data_addr, buf, len / 4);
+			outsl(data_addr, buf, words);
 
 		if ((io_32bit & 2) && !mmio)
 			local_irq_restore(flags);
 
-		if ((len & 3) >= 2) {
-			if (mmio)
-				__ide_mm_outsw((void __iomem *)data_addr,
-						 (u8 *)buf + (len & ~3), 1);
-			else
-				outsw(data_addr, (u8 *)buf + (len & ~3), 1);
-		}
-	} else {
-		if (mmio)
-			__ide_mm_outsw((void __iomem *)data_addr, buf, len / 2);
-		else
-			outsw(data_addr, buf, len / 2);
+		if (((len + 1) & 3) < 2)
+			return;
+
+		buf += len & ~3;
+		words = 1;
 	}
+
+	if (mmio)
+		__ide_mm_outsw((void __iomem *)data_addr, buf, words);
+	else
+		outsw(data_addr, buf, words);
 }
 EXPORT_SYMBOL_GPL(ide_output_data);
 

