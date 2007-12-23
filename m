From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/2] ide: add ide_dump_identify() debug helper
Date: Sun, 23 Dec 2007 22:43:36 +0100
Message-ID: <200712232243.36838.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:7285 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757518AbXLWXHt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Dec 2007 18:07:49 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1018705ugc.16
        for <linux-ide@vger.kernel.org>; Sun, 23 Dec 2007 15:07:48 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


* Add ide_dump_identify() debug helper for dumping raw identify data in
  the hdparm friendly format (== the identify data can be extracted from
  dmesg output and passed to hdparm --Istdin).

* Dump identify data in ide-probe.c::do_identify() if DEBUG is enabled.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |    4 ++++
 include/linux/ide.h     |    5 +++++
 2 files changed, 9 insertions(+)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -129,6 +129,10 @@ static inline void do_identify (ide_driv
 
 	drive->id_read = 1;
 	local_irq_enable();
+#ifdef DEBUG
+	printk(KERN_INFO "%s: dumping identify data\n", drive->name);
+	ide_dump_identify((u8 *)id);
+#endif
 	ide_fix_driveid(id);
 
 #if defined (CONFIG_SCSI_EATA_PIO) || defined (CONFIG_SCSI_EATA)
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1291,6 +1291,11 @@ extern struct bus_type ide_bus_type;
 #define ide_id_has_flush_cache_ext(id)	\
 	(((id)->cfs_enable_2 & 0x2400) == 0x2400)
 
+static inline void ide_dump_identify(u8 *id)
+{
+	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, 16, 2, id, 512, 0);
+}
+
 static inline int hwif_to_node(ide_hwif_t *hwif)
 {
 	struct pci_dev *dev = hwif->pci_dev;
