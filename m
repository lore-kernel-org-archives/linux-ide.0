From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 2/2] ide-h8300: remove custom tf_{ead|load}() methods
Date: Wed, 1 Apr 2009 23:18:49 +0400
Message-ID: <200904012318.49325.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:51291 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756258AbZDATSS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Apr 2009 15:18:18 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Since tf_{read|load}() methods of this driver have now become identical to their
standard counterparts using I/O port accesses, there's no need to override those
anymore...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the current Linus' tree...

 drivers/ide/ide-h8300.c |   79 +-----------------------------------------------
 1 files changed, 2 insertions(+), 77 deletions(-)

Index: linux-2.6/drivers/ide/ide-h8300.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-h8300.c
+++ linux-2.6/drivers/ide/ide-h8300.c
@@ -22,81 +22,6 @@
 	(r);				\
 })
 
-static void h8300_tf_load(ide_drive_t *drive, struct ide_cmd *cmd)
-{
-	ide_hwif_t *hwif = drive->hwif;
-	struct ide_io_ports *io_ports = &hwif->io_ports;
-	struct ide_taskfile *tf = &cmd->tf;
-	u8 HIHI = (cmd->tf_flags & IDE_TFLAG_LBA48) ? 0xE0 : 0xEF;
-
-	if (cmd->ftf_flags & IDE_FTFLAG_FLAGGED)
-		HIHI = 0xFF;
-
-	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_FEATURE)
-		outb(tf->hob_feature, io_ports->feature_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_NSECT)
-		outb(tf->hob_nsect, io_ports->nsect_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_LBAL)
-		outb(tf->hob_lbal, io_ports->lbal_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_LBAM)
-		outb(tf->hob_lbam, io_ports->lbam_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_LBAH)
-		outb(tf->hob_lbah, io_ports->lbah_addr);
-
-	if (cmd->tf_flags & IDE_TFLAG_OUT_FEATURE)
-		outb(tf->feature, io_ports->feature_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_NSECT)
-		outb(tf->nsect, io_ports->nsect_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_LBAL)
-		outb(tf->lbal, io_ports->lbal_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_LBAM)
-		outb(tf->lbam, io_ports->lbam_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_LBAH)
-		outb(tf->lbah, io_ports->lbah_addr);
-
-	if (cmd->tf_flags & IDE_TFLAG_OUT_DEVICE)
-		outb((tf->device & HIHI) | drive->select,
-		     io_ports->device_addr);
-}
-
-static void h8300_tf_read(ide_drive_t *drive, struct ide_cmd *cmd)
-{
-	ide_hwif_t *hwif = drive->hwif;
-	struct ide_io_ports *io_ports = &hwif->io_ports;
-	struct ide_taskfile *tf = &cmd->tf;
-
-	/* be sure we're looking at the low order bits */
-	outb(ATA_DEVCTL_OBS, io_ports->ctl_addr);
-
-	if (cmd->tf_flags & IDE_TFLAG_IN_ERROR)
-		tf->error  = inb(io_ports->feature_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_NSECT)
-		tf->nsect  = inb(io_ports->nsect_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_LBAL)
-		tf->lbal   = inb(io_ports->lbal_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_LBAM)
-		tf->lbam   = inb(io_ports->lbam_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_LBAH)
-		tf->lbah   = inb(io_ports->lbah_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_DEVICE)
-		tf->device = inb(io_ports->device_addr);
-
-	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
-		outb(ATA_HOB | ATA_DEVCTL_OBS, io_ports->ctl_addr);
-
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_ERROR)
-			tf->hob_error = inb(io_ports->feature_addr);
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_NSECT)
-			tf->hob_nsect = inb(io_ports->nsect_addr);
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAL)
-			tf->hob_lbal  = inb(io_ports->lbal_addr);
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAM)
-			tf->hob_lbam  = inb(io_ports->lbam_addr);
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAH)
-			tf->hob_lbah  = inb(io_ports->lbah_addr);
-	}
-}
-
 static void mm_outsw(unsigned long addr, void *buf, u32 len)
 {
 	unsigned short *bp = (unsigned short *)buf;
@@ -130,8 +55,8 @@ static const struct ide_tp_ops h8300_tp_
 	.write_devctl		= ide_write_devctl,
 
 	.dev_select		= ide_dev_select,
-	.tf_load		= h8300_tf_load,
-	.tf_read		= h8300_tf_read,
+	.tf_load		= ide_tf_load,
+	.tf_read		= ide_tf_read,
 
 	.input_data		= h8300_input_data,
 	.output_data		= h8300_output_data,

