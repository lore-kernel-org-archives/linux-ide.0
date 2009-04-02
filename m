From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 3/6] ide: move common code out of tf_load() method
Date: Thu, 2 Apr 2009 23:01:14 +0400
Message-ID: <200904022301.14906.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:12486 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755698AbZDBTAo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Apr 2009 15:00:44 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Move device register masking (and setting drive->select) out of tf_load() method
and into the only function that needs to use this code, do_rw_taskfile()...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the current Linus' tree...

 drivers/ide/ide-io-std.c   |    8 +-------
 drivers/ide/ide-taskfile.c |   10 ++++++++++
 drivers/ide/scc_pata.c     |    8 +-------
 drivers/ide/tx4938ide.c    |    8 +-------
 drivers/ide/tx4939ide.c    |    8 +-------
 5 files changed, 14 insertions(+), 28 deletions(-)

Index: linux-2.6/drivers/ide/ide-io-std.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-io-std.c
+++ linux-2.6/drivers/ide/ide-io-std.c
@@ -93,16 +93,12 @@ void ide_tf_load(ide_drive_t *drive, str
 	void (*tf_outb)(u8 addr, unsigned long port);
 	u8 valid = cmd->valid.out.hob;
 	u8 mmio = (hwif->host_flags & IDE_HFLAG_MMIO) ? 1 : 0;
-	u8 HIHI = (cmd->tf_flags & IDE_TFLAG_LBA48) ? 0xE0 : 0xEF;
 
 	if (mmio)
 		tf_outb = ide_mm_outb;
 	else
 		tf_outb = ide_outb;
 
-	if (cmd->ftf_flags & IDE_FTFLAG_FLAGGED)
-		HIHI = 0xFF;
-
 	if (valid & IDE_VALID_FEATURE)
 		tf_outb(tf->feature, io_ports->feature_addr);
 	if (valid & IDE_VALID_NSECT)
@@ -127,10 +123,8 @@ void ide_tf_load(ide_drive_t *drive, str
 		tf_outb(tf->lbam, io_ports->lbam_addr);
 	if (valid & IDE_VALID_LBAH)
 		tf_outb(tf->lbah, io_ports->lbah_addr);
-
 	if (valid & IDE_VALID_DEVICE)
-		tf_outb((tf->device & HIHI) | drive->select,
-			 io_ports->device_addr);
+		tf_outb(tf->device, io_ports->device_addr);
 }
 EXPORT_SYMBOL_GPL(ide_tf_load);
 
Index: linux-2.6/drivers/ide/ide-taskfile.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-taskfile.c
+++ linux-2.6/drivers/ide/ide-taskfile.c
@@ -88,6 +88,16 @@ ide_startstop_t do_rw_taskfile(ide_drive
 
 			tp_ops->output_data(drive, cmd, data, 2);
 		}
+
+		if (cmd->valid.out.tf & IDE_VALID_DEVICE) {
+		 	u8 HIHI = (cmd->tf_flags & IDE_TFLAG_LBA48) ?
+				  0xE0 : 0xEF;
+
+			if (!(cmd->ftf_flags & IDE_FTFLAG_FLAGGED))
+				cmd->tf.device &= HIHI;
+			cmd->tf.device |= drive->select;
+		}
+
 		tp_ops->tf_load(drive, cmd);
 	}
 
Index: linux-2.6/drivers/ide/scc_pata.c
===================================================================
--- linux-2.6.orig/drivers/ide/scc_pata.c
+++ linux-2.6/drivers/ide/scc_pata.c
@@ -652,10 +652,6 @@ static void scc_tf_load(ide_drive_t *dri
 	struct ide_io_ports *io_ports = &drive->hwif->io_ports;
 	struct ide_taskfile *tf = &cmd->hob;
 	u8 valid = cmd->valid.out.hob;
-	u8 HIHI = (cmd->tf_flags & IDE_TFLAG_LBA48) ? 0xE0 : 0xEF;
-
-	if (cmd->ftf_flags & IDE_FTFLAG_FLAGGED)
-		HIHI = 0xFF;
 
 	if (valid & IDE_VALID_FEATURE)
 		scc_ide_outb(tf->feature, io_ports->feature_addr);
@@ -681,10 +677,8 @@ static void scc_tf_load(ide_drive_t *dri
 		scc_ide_outb(tf->lbam, io_ports->lbam_addr);
 	if (valid & IDE_VALID_LBAH)
 		scc_ide_outb(tf->lbah, io_ports->lbah_addr);
-
 	if (valid & IDE_VALID_DEVICE)
-		scc_ide_outb((tf->device & HIHI) | drive->select,
-			     io_ports->device_addr);
+		scc_ide_outb(tf->device, io_ports->device_addr);
 }
 
 static void scc_tf_read(ide_drive_t *drive, struct ide_cmd *cmd)
Index: linux-2.6/drivers/ide/tx4938ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/tx4938ide.c
+++ linux-2.6/drivers/ide/tx4938ide.c
@@ -88,10 +88,6 @@ static void tx4938ide_tf_load(ide_drive_
 	struct ide_io_ports *io_ports = &hwif->io_ports;
 	struct ide_taskfile *tf = &cmd->hob;
 	u8 valid = cmd->valid.out.hob;
-	u8 HIHI = cmd->tf_flags & IDE_TFLAG_LBA48 ? 0xE0 : 0xEF;
-
-	if (cmd->ftf_flags & IDE_FTFLAG_FLAGGED)
-		HIHI = 0xFF;
 
 	if (valid & IDE_VALID_FEATURE)
 		tx4938ide_outb(tf->feature, io_ports->feature_addr);
@@ -117,10 +113,8 @@ static void tx4938ide_tf_load(ide_drive_
 		tx4938ide_outb(tf->lbam, io_ports->lbam_addr);
 	if (valid & IDE_VALID_LBAH)
 		tx4938ide_outb(tf->lbah, io_ports->lbah_addr);
-
 	if (valid & IDE_VALID_DEVICE)
-		tx4938ide_outb((tf->device & HIHI) | drive->select,
-			       io_ports->device_addr);
+		tx4938ide_outb(tf->device, io_ports->device_addr);
 }
 
 static void tx4938ide_tf_read(ide_drive_t *drive, struct ide_cmd *cmd)
Index: linux-2.6/drivers/ide/tx4939ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/tx4939ide.c
+++ linux-2.6/drivers/ide/tx4939ide.c
@@ -453,10 +453,6 @@ static void tx4939ide_tf_load(ide_drive_
 	struct ide_io_ports *io_ports = &hwif->io_ports;
 	struct ide_taskfile *tf = &cmd->hob;
 	u8 valid = cmd->valid.out.hob;
-	u8 HIHI = cmd->tf_flags & IDE_TFLAG_LBA48 ? 0xE0 : 0xEF;
-
-	if (cmd->ftf_flags & IDE_FTFLAG_FLAGGED)
-		HIHI = 0xFF;
 
 	if (valid & IDE_VALID_FEATURE)
 		tx4939ide_outb(tf->feature, io_ports->feature_addr);
@@ -482,10 +478,8 @@ static void tx4939ide_tf_load(ide_drive_
 		tx4939ide_outb(tf->lbam, io_ports->lbam_addr);
 	if (valid & IDE_VALID_LBAH)
 		tx4939ide_outb(tf->lbah, io_ports->lbah_addr);
-
 	if (valid & IDE_VALID_DEVICE) {
-		tx4939ide_outb((tf->device & HIHI) | drive->select,
-			       io_ports->device_addr);
+		tx4939ide_outb(tf->device, io_ports->device_addr);
 		tx4939ide_tf_load_fixup(drive);
 	}
 }

