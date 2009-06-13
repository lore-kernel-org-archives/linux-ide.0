From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/3] ide: don't enable IORDY at a probe time
Date: Sat, 13 Jun 2009 18:23:15 +0200
Message-ID: <200906131823.15906.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:43383 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760413AbZFMQd1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Jun 2009 12:33:27 -0400
Received: by bwz9 with SMTP id 9so2594790bwz.37
        for <linux-ide@vger.kernel.org>; Sat, 13 Jun 2009 09:33:28 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

* Add 'unsigned long port_flags' field to ide_hwif_t.

* Add IDE_PFLAG_PROBING port flag and keep it set during probing.

* Fix ide_pio_need_iordy() to not enable IORDY at a probe time
  (IORDY may lead to controller lock up on certain controllers
   if the port is not occupied).

Loosely based on the recent libata's fix by Tejun, thanks to Alan
for the hint that IDE may also need it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c     |   16 +++++++++++++++-
 drivers/ide/ide-xfer-mode.c |    6 ++++++
 include/linux/ide.h         |    6 ++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1378,6 +1378,9 @@ int ide_host_register(struct ide_host *h
 
 		ide_init_port(hwif, i & 1, d);
 		ide_port_cable_detect(hwif);
+
+		hwif->port_flags |= IDE_PFLAG_PROBING;
+
 		ide_port_init_devices(hwif);
 	}
 
@@ -1388,6 +1391,8 @@ int ide_host_register(struct ide_host *h
 		if (ide_probe_port(hwif) == 0)
 			hwif->present = 1;
 
+		hwif->port_flags &= ~IDE_PFLAG_PROBING;
+
 		if ((hwif->host_flags & IDE_HFLAG_4DRIVES) == 0 ||
 		    hwif->mate == NULL || hwif->mate->present == 0) {
 			if (ide_register_port(hwif)) {
@@ -1569,11 +1574,20 @@ EXPORT_SYMBOL_GPL(ide_host_remove);
 
 void ide_port_scan(ide_hwif_t *hwif)
 {
+	int rc;
+
 	ide_port_apply_params(hwif);
 	ide_port_cable_detect(hwif);
+
+	hwif->port_flags |= IDE_PFLAG_PROBING;
+
 	ide_port_init_devices(hwif);
 
-	if (ide_probe_port(hwif) < 0)
+	rc = ide_probe_port(hwif);
+
+	hwif->port_flags &= ~IDE_PFLAG_PROBING;
+
+	if (rc < 0)
 		return;
 
 	hwif->present = 1;
Index: b/drivers/ide/ide-xfer-mode.c
===================================================================
--- a/drivers/ide/ide-xfer-mode.c
+++ b/drivers/ide/ide-xfer-mode.c
@@ -109,6 +109,12 @@ EXPORT_SYMBOL_GPL(ide_get_best_pio_mode)
 
 int ide_pio_need_iordy(ide_drive_t *drive, const u8 pio)
 {
+	/*
+	 * IORDY may lead to controller lock up on certain controllers
+	 * if the port is not occupied.
+	 */
+	if (pio == 0 && (drive->hwif->port_flags & IDE_PFLAG_PROBING))
+		return 0;
 	return ata_id_pio_need_iordy(drive->id, pio);
 }
 EXPORT_SYMBOL_GPL(ide_pio_need_iordy);
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -674,6 +674,10 @@ struct ide_dma_ops {
 	u8	(*dma_sff_read_status)(struct hwif_s *);
 };
 
+enum {
+	IDE_PFLAG_PROBING		= (1 << 0),
+};
+
 struct ide_host;
 
 typedef struct hwif_s {
@@ -690,6 +694,8 @@ typedef struct hwif_s {
 
 	ide_drive_t	*devices[MAX_DRIVES + 1];
 
+	unsigned long	port_flags;
+
 	u8 major;	/* our major number */
 	u8 index;	/* 0 for ide0; 1 for ide1; ... */
 	u8 channel;	/* for dual-port chips: 0=primary, 1=secondary */
