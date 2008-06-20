From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 14/18] ide: use ->tf_read in ide_read_error()
Date: Fri, 20 Jun 2008 23:34:58 +0200
Message-ID: <20080620213458.13202.77992.sendpatchset@localhost.localdomain>
References: <20080620213323.13202.71450.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:22730 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761754AbYFTVdD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jun 2008 17:33:03 -0400
Received: by fg-out-1718.google.com with SMTP id 19so745092fgg.17
        for <linux-ide@vger.kernel.org>; Fri, 20 Jun 2008 14:33:01 -0700 (PDT)
In-Reply-To: <20080620213323.13202.71450.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

* Add IDE_TFLAG_IN_FEATURE taskfile flag for reading Feature
  register and handle it in ->tf_read.

* Convert ide_read_error() to use ->tf_read instead of ->INB,
  then uninline and export it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/h8300/ide-h8300.c |    2 ++
 drivers/ide/ide-iops.c        |   15 +++++++++++++++
 drivers/ide/pci/ns87415.c     |    2 ++
 drivers/ide/pci/scc_pata.c    |    2 ++
 include/linux/ide.h           |   10 +++-------
 5 files changed, 24 insertions(+), 7 deletions(-)

Index: b/drivers/ide/h8300/ide-h8300.c
===================================================================
--- a/drivers/ide/h8300/ide-h8300.c
+++ b/drivers/ide/h8300/ide-h8300.c
@@ -100,6 +100,8 @@ static void h8300_tf_read(ide_drive_t *d
 	/* be sure we're looking at the low order bits */
 	outb(ATA_DEVCTL_OBS & ~0x80, io_ports->ctl_addr);
 
+	if (task->tf_flags & IDE_TFLAG_IN_FEATURE)
+		tf->feature = inb(io_ports->feature_addr);
 	if (task->tf_flags & IDE_TFLAG_IN_NSECT)
 		tf->nsect  = inb(io_ports->nsect_addr);
 	if (task->tf_flags & IDE_TFLAG_IN_LBAL)
Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -241,6 +241,8 @@ static void ide_tf_read(ide_drive_t *dri
 	/* be sure we're looking at the low order bits */
 	tf_outb(ATA_DEVCTL_OBS & ~0x80, io_ports->ctl_addr);
 
+	if (task->tf_flags & IDE_TFLAG_IN_FEATURE)
+		tf->feature = tf_inb(io_ports->feature_addr);
 	if (task->tf_flags & IDE_TFLAG_IN_NSECT)
 		tf->nsect  = tf_inb(io_ports->nsect_addr);
 	if (task->tf_flags & IDE_TFLAG_IN_LBAL)
@@ -390,6 +392,19 @@ void default_hwif_transport(ide_hwif_t *
 	hwif->output_data = ata_output_data;
 }
 
+u8 ide_read_error(ide_drive_t *drive)
+{
+	ide_task_t task;
+
+	memset(&task, 0, sizeof(task));
+	task.tf_flags = IDE_TFLAG_IN_FEATURE;
+
+	drive->hwif->tf_read(drive, &task);
+
+	return task.tf.error;
+}
+EXPORT_SYMBOL_GPL(ide_read_error);
+
 void ide_fix_driveid (struct hd_driveid *id)
 {
 #ifndef __LITTLE_ENDIAN
Index: b/drivers/ide/pci/ns87415.c
===================================================================
--- a/drivers/ide/pci/ns87415.c
+++ b/drivers/ide/pci/ns87415.c
@@ -88,6 +88,8 @@ static void superio_tf_read(ide_drive_t 
 	/* be sure we're looking at the low order bits */
 	outb(ATA_DEVCTL_OBS & ~0x80, io_ports->ctl_addr);
 
+	if (task->tf_flags & IDE_TFLAG_IN_FEATURE)
+		tf->feature = inb(io_ports->feature_addr);
 	if (task->tf_flags & IDE_TFLAG_IN_NSECT)
 		tf->nsect  = inb(io_ports->nsect_addr);
 	if (task->tf_flags & IDE_TFLAG_IN_LBAL)
Index: b/drivers/ide/pci/scc_pata.c
===================================================================
--- a/drivers/ide/pci/scc_pata.c
+++ b/drivers/ide/pci/scc_pata.c
@@ -742,6 +742,8 @@ static void scc_tf_read(ide_drive_t *dri
 	/* be sure we're looking at the low order bits */
 	scc_ide_outb(ATA_DEVCTL_OBS & ~0x80, io_ports->ctl_addr);
 
+	if (task->tf_flags & IDE_TFLAG_IN_FEATURE)
+		tf->feature = scc_ide_inb(io_ports->feature_addr);
 	if (task->tf_flags & IDE_TFLAG_IN_NSECT)
 		tf->nsect  = scc_ide_inb(io_ports->nsect_addr);
 	if (task->tf_flags & IDE_TFLAG_IN_LBAL)
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -875,6 +875,7 @@ enum {
 	IDE_TFLAG_IN_HOB		= IDE_TFLAG_IN_HOB_FEATURE |
 					  IDE_TFLAG_IN_HOB_NSECT |
 					  IDE_TFLAG_IN_HOB_LBA,
+	IDE_TFLAG_IN_FEATURE		= (1 << 1),
 	IDE_TFLAG_IN_NSECT		= (1 << 25),
 	IDE_TFLAG_IN_LBAL		= (1 << 26),
 	IDE_TFLAG_IN_LBAM		= (1 << 27),
@@ -942,6 +943,8 @@ void ide_tf_dump(const char *, struct id
 extern void SELECT_DRIVE(ide_drive_t *);
 void SELECT_MASK(ide_drive_t *, int);
 
+u8 ide_read_error(ide_drive_t *);
+
 extern int drive_is_ready(ide_drive_t *);
 
 void ide_pktcmd_tf_load(ide_drive_t *, u32, u16, u8);
@@ -1343,11 +1346,4 @@ static inline ide_drive_t *ide_get_paire
 
 	return &hwif->drives[(drive->dn ^ 1) & 1];
 }
-
-static inline u8 ide_read_error(ide_drive_t *drive)
-{
-	ide_hwif_t *hwif = drive->hwif;
-
-	return hwif->INB(hwif->io_ports.error_addr);
-}
 #endif /* _IDE_H */
