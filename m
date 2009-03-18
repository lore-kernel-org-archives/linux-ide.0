From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 4/4] ide: move data register access out of tf_{read|load}() methods
Date: Wed, 18 Mar 2009 21:46:03 +0400
Message-ID: <200903182046.03205.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:38167 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752085AbZCRRpU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Mar 2009 13:45:20 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Move IDE_FTFLAG_{IN|OUT}_DATA flag handling out of tf_{read|load}() methods
into the only two functions where these flags actually need to be handled:
do_rw_taskfile() and ide_complete_cmd()...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch is atop of the latest pata-2.6 series...

 drivers/ide/at91_ide.c     |   15 ---------------
 drivers/ide/ide-h8300.c    |   15 ---------------
 drivers/ide/ide-io-std.c   |   15 ---------------
 drivers/ide/ide-io.c       |   12 +++++++++++-
 drivers/ide/ide-taskfile.c |    6 ++++++
 drivers/ide/ns87415.c      |    9 ---------
 drivers/ide/scc_pata.c     |   15 ---------------
 drivers/ide/tx4938ide.c    |   15 ---------------
 drivers/ide/tx4939ide.c    |   15 ---------------
 9 files changed, 17 insertions(+), 100 deletions(-)

Index: linux-2.6/drivers/ide/at91_ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/at91_ide.c
+++ linux-2.6/drivers/ide/at91_ide.c
@@ -195,12 +195,6 @@ static void at91_ide_tf_load(ide_drive_t
 	if (cmd->tf_flags & IDE_FTFLAG_FLAGGED)
 		HIHI = 0xFF;
 
-	if (cmd->tf_flags & IDE_FTFLAG_OUT_DATA) {
-		u8 data[2] = { tf->data, tf->hob_data };
-
-		at91_ide_output_data(drive, cmd, data, 2);
-	}
-
 	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_FEATURE)
 		ide_mm_outb(tf->hob_feature, io_ports->feature_addr);
 	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_NSECT)
@@ -233,15 +227,6 @@ static void at91_ide_tf_read(ide_drive_t
 	struct ide_io_ports *io_ports = &hwif->io_ports;
 	struct ide_taskfile *tf = &cmd->tf;
 
-	if (cmd->tf_flags & IDE_FTFLAG_IN_DATA) {
-		u8 data[2];
-
-		at91_ide_input_data(drive, cmd, data, 2);
-
-		tf->data = data[0];
-		tf->hob_data = data[1];
-	}
-
 	/* be sure we're looking at the low order bits */
 	ide_mm_outb(ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
Index: linux-2.6/drivers/ide/ide-h8300.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-h8300.c
+++ linux-2.6/drivers/ide/ide-h8300.c
@@ -54,12 +54,6 @@ static void h8300_tf_load(ide_drive_t *d
 	if (cmd->ftf_flags & IDE_FTFLAG_FLAGGED)
 		HIHI = 0xFF;
 
-	if (cmd->ftf_flags & IDE_FTFLAG_OUT_DATA) {
-		u8 data[2] = { tf->data, tf->hob_data };
-
-		h8300_output_data(drive, cmd, data, 2);
-	}
-
 	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_FEATURE)
 		outb(tf->hob_feature, io_ports->feature_addr);
 	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_NSECT)
@@ -93,15 +87,6 @@ static void h8300_tf_read(ide_drive_t *d
 	struct ide_io_ports *io_ports = &hwif->io_ports;
 	struct ide_taskfile *tf = &cmd->tf;
 
-	if (cmd->ftf_flags & IDE_FTFLAG_IN_DATA) {
-		u8 data[2];
-
-		h8300_input_data(drive, cmd, data, 2);
-
-		tf->data = data[0];
-		tf->hob_data = data[1];
-	}
-
 	/* be sure we're looking at the low order bits */
 	outb(ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
Index: linux-2.6/drivers/ide/ide-io-std.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-io-std.c
+++ linux-2.6/drivers/ide/ide-io-std.c
@@ -90,12 +90,6 @@ void ide_tf_load(ide_drive_t *drive, str
 	if (cmd->ftf_flags & IDE_FTFLAG_FLAGGED)
 		HIHI = 0xFF;
 
-	if (cmd->ftf_flags & IDE_FTFLAG_OUT_DATA) {
-		u8 data[2] = { tf->data, tf->hob_data };
-
-		ide_output_data(drive, cmd, data, 2);
-	}
-
 	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_FEATURE)
 		tf_outb(tf->hob_feature, io_ports->feature_addr);
 	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_NSECT)
@@ -141,15 +135,6 @@ void ide_tf_read(ide_drive_t *drive, str
 		tf_inb  = ide_inb;
 	}
 
-	if (cmd->ftf_flags & IDE_FTFLAG_IN_DATA) {
-		u8 data[2];
-
-		ide_input_data(drive, cmd, data, 2);
-
-		tf->data = data[0];
-		tf->hob_data = data[1];
-	}
-
 	/* be sure we're looking at the low order bits */
 	tf_outb(ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
Index: linux-2.6/drivers/ide/ide-io.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-io.c
+++ linux-2.6/drivers/ide/ide-io.c
@@ -73,6 +73,7 @@ EXPORT_SYMBOL_GPL(ide_end_rq);
 
 void ide_complete_cmd(ide_drive_t *drive, struct ide_cmd *cmd, u8 stat, u8 err)
 {
+	const struct ide_tp_ops *tp_ops = drive->hwif->tp_ops;
 	struct ide_taskfile *tf = &cmd->tf;
 	struct request *rq = cmd->rq;
 	u8 tf_cmd = tf->command;
@@ -80,7 +81,16 @@ void ide_complete_cmd(ide_drive_t *drive
 	tf->error = err;
 	tf->status = stat;
 
-	drive->hwif->tp_ops->tf_read(drive, cmd);
+	if (cmd->ftf_flags & IDE_FTFLAG_IN_DATA) {
+		u8 data[2];
+
+		tp_ops->input_data(drive, cmd, data, 2);
+
+		tf->data = data[0];
+		tf->hob_data = data[1];
+	}
+
+	tp_ops->tf_read(drive, cmd);
 
 	if ((cmd->tf_flags & IDE_TFLAG_CUSTOM_HANDLER) &&
 	    tf_cmd == ATA_CMD_IDLEIMMEDIATE) {
Index: linux-2.6/drivers/ide/ide-taskfile.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-taskfile.c
+++ linux-2.6/drivers/ide/ide-taskfile.c
@@ -82,6 +82,12 @@ ide_startstop_t do_rw_taskfile(ide_drive
 		ide_tf_dump(drive->name, tf);
 		tp_ops->write_devctl(hwif, ATA_DEVCTL_OBS);
 		SELECT_MASK(drive, 0);
+
+		if (cmd->ftf_flags & IDE_FTFLAG_OUT_DATA) {
+			u8 data[2] = { tf->data, tf->hob_data };
+
+			tp_ops->output_data(drive, cmd, data, 2);
+		}
 		tp_ops->tf_load(drive, cmd);
 	}
 
Index: linux-2.6/drivers/ide/ns87415.c
===================================================================
--- linux-2.6.orig/drivers/ide/ns87415.c
+++ linux-2.6/drivers/ide/ns87415.c
@@ -66,15 +66,6 @@ static void superio_tf_read(ide_drive_t 
 	struct ide_io_ports *io_ports = &drive->hwif->io_ports;
 	struct ide_taskfile *tf = &cmd->tf;
 
-	if (cmd->ftf_flags & IDE_FTFLAG_IN_DATA) {
-		u8 data[2];
-
-		ide_input_data(drive, cmd, data, 2);
-
-		tf->data = data[0];
-		tf->hob_data = data[1];
-	}
-
 	/* be sure we're looking at the low order bits */
 	outb(ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
Index: linux-2.6/drivers/ide/scc_pata.c
===================================================================
--- linux-2.6.orig/drivers/ide/scc_pata.c
+++ linux-2.6/drivers/ide/scc_pata.c
@@ -656,12 +656,6 @@ static void scc_tf_load(ide_drive_t *dri
 	if (cmd->ftf_flags & IDE_FTFLAG_FLAGGED)
 		HIHI = 0xFF;
 
-	if (cmd->ftf_flags & IDE_FTFLAG_OUT_DATA) {
-		u8 data[2] = { tf->data, tf->hob_data };
-
-		scc_output_data(drive, NULL, data, 2);
-	}
-
 	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_FEATURE)
 		scc_ide_outb(tf->hob_feature, io_ports->feature_addr);
 	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_NSECT)
@@ -694,15 +688,6 @@ static void scc_tf_read(ide_drive_t *dri
 	struct ide_io_ports *io_ports = &drive->hwif->io_ports;
 	struct ide_taskfile *tf = &cmd->tf;
 
-	if (cmd->ftf_flags & IDE_FTFLAG_IN_DATA) {
-		u8 data[2];
-
-		ide_input_data(drive, cmd, data, 2);
-
-		tf->data = data[0];
-		tf->hob_data = data[1];
-	}
-
 	/* be sure we're looking at the low order bits */
 	scc_ide_outb(ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
Index: linux-2.6/drivers/ide/tx4938ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/tx4938ide.c
+++ linux-2.6/drivers/ide/tx4938ide.c
@@ -92,12 +92,6 @@ static void tx4938ide_tf_load(ide_drive_
 	if (cmd->ftf_flags & IDE_FTFLAG_FLAGGED)
 		HIHI = 0xFF;
 
-	if (cmd->ftf_flags & IDE_FTFLAG_OUT_DATA) {
-		u8 data[2] = { tf->data, tf->hob_data };
-
-		hwif->tp_ops->output_data(drive, cmd, data, 2);
-	}
-
 	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_FEATURE)
 		tx4938ide_outb(tf->hob_feature, io_ports->feature_addr);
 	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_NSECT)
@@ -131,15 +125,6 @@ static void tx4938ide_tf_read(ide_drive_
 	struct ide_io_ports *io_ports = &hwif->io_ports;
 	struct ide_taskfile *tf = &cmd->tf;
 
-	if (cmd->ftf_flags & IDE_FTFLAG_IN_DATA) {
-		u8 data[2];
-
-		hwif->tp_ops->input_data(drive, cmd, data, 2);
-
-		tf->data = data[0];
-		tf->hob_data = data[1];
-	}
-
 	/* be sure we're looking at the low order bits */
 	tx4938ide_outb(ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
Index: linux-2.6/drivers/ide/tx4939ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/tx4939ide.c
+++ linux-2.6/drivers/ide/tx4939ide.c
@@ -457,12 +457,6 @@ static void tx4939ide_tf_load(ide_drive_
 	if (cmd->ftf_flags & IDE_FTFLAG_FLAGGED)
 		HIHI = 0xFF;
 
-	if (cmd->ftf_flags & IDE_FTFLAG_OUT_DATA) {
-		u8 data[2] = { tf->data, tf->hob_data };
-
-		hwif->tp_ops->output_data(drive, cmd, data, 2);
-	}
-
 	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_FEATURE)
 		tx4939ide_outb(tf->hob_feature, io_ports->feature_addr);
 	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_NSECT)
@@ -498,15 +492,6 @@ static void tx4939ide_tf_read(ide_drive_
 	struct ide_io_ports *io_ports = &hwif->io_ports;
 	struct ide_taskfile *tf = &cmd->tf;
 
-	if (cmd->ftf_flags & IDE_FTFLAG_IN_DATA) {
-		u8 data[2];
-
-		hwif->tp_ops->input_data(drive, cmd, data, 2);
-
-		tf->data = data[0];
-		tf->hob_data = data[1];
-	}
-
 	/* be sure we're looking at the low order bits */
 	tx4939ide_outb(ATA_DEVCTL_OBS, io_ports->ctl_addr);
 

