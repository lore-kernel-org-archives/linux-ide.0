From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] at91_ide: remove custom tf_{read|load}() methods (take 2)
Date: Tue, 7 Apr 2009 21:07:33 +0400
Message-ID: <200904072107.33324.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:41477 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753437AbZDGRGy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Apr 2009 13:06:54 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, stf_xl@wp.pl

Since tf_{read|load}() methods of this driver have now become identical to their
standard counterparts using MMIO accesses, there's no need to override those
anymore...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>

---
Remove ide_mm_{inb|outb}() that somehow fell out of my attention...
This incorporates the patch posted by Stanislaw Gruszka today.

 drivers/ide/at91_ide.c |   88 +------------------------------------------------
 1 files changed, 2 insertions(+), 86 deletions(-)

Index: linux-2.6/drivers/ide/at91_ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/at91_ide.c
+++ linux-2.6/drivers/ide/at91_ide.c
@@ -175,90 +175,6 @@ static void at91_ide_output_data(ide_dri
 	leave_16bit(chipselect, mode);
 }
 
-static u8 ide_mm_inb(unsigned long port)
-{
-	return readb((void __iomem *) port);
-}
-
-static void ide_mm_outb(u8 value, unsigned long port)
-{
-	writeb(value, (void __iomem *) port);
-}
-
-static void at91_ide_tf_load(ide_drive_t *drive, struct ide_cmd *cmd)
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
-		ide_mm_outb(tf->hob_feature, io_ports->feature_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_NSECT)
-		ide_mm_outb(tf->hob_nsect, io_ports->nsect_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_LBAL)
-		ide_mm_outb(tf->hob_lbal, io_ports->lbal_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_LBAM)
-		ide_mm_outb(tf->hob_lbam, io_ports->lbam_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_HOB_LBAH)
-		ide_mm_outb(tf->hob_lbah, io_ports->lbah_addr);
-
-	if (cmd->tf_flags & IDE_TFLAG_OUT_FEATURE)
-		ide_mm_outb(tf->feature, io_ports->feature_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_NSECT)
-		ide_mm_outb(tf->nsect, io_ports->nsect_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_LBAL)
-		ide_mm_outb(tf->lbal, io_ports->lbal_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_LBAM)
-		ide_mm_outb(tf->lbam, io_ports->lbam_addr);
-	if (cmd->tf_flags & IDE_TFLAG_OUT_LBAH)
-		ide_mm_outb(tf->lbah, io_ports->lbah_addr);
-
-	if (cmd->tf_flags & IDE_TFLAG_OUT_DEVICE)
-		ide_mm_outb((tf->device & HIHI) | drive->select, io_ports->device_addr);
-}
-
-static void at91_ide_tf_read(ide_drive_t *drive, struct ide_cmd *cmd)
-{
-	ide_hwif_t *hwif = drive->hwif;
-	struct ide_io_ports *io_ports = &hwif->io_ports;
-	struct ide_taskfile *tf = &cmd->tf;
-
-	/* be sure we're looking at the low order bits */
-	ide_mm_outb(ATA_DEVCTL_OBS, io_ports->ctl_addr);
-
-	if (cmd->tf_flags & IDE_TFLAG_IN_ERROR)
-		tf->error  = ide_mm_inb(io_ports->feature_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_NSECT)
-		tf->nsect  = ide_mm_inb(io_ports->nsect_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_LBAL)
-		tf->lbal   = ide_mm_inb(io_ports->lbal_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_LBAM)
-		tf->lbam   = ide_mm_inb(io_ports->lbam_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_LBAH)
-		tf->lbah   = ide_mm_inb(io_ports->lbah_addr);
-	if (cmd->tf_flags & IDE_TFLAG_IN_DEVICE)
-		tf->device = ide_mm_inb(io_ports->device_addr);
-
-	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
-		ide_mm_outb(ATA_HOB | ATA_DEVCTL_OBS, io_ports->ctl_addr);
-
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_ERROR)
-			tf->hob_error = ide_mm_inb(io_ports->feature_addr);
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_NSECT)
-			tf->hob_nsect = ide_mm_inb(io_ports->nsect_addr);
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAL)
-			tf->hob_lbal  = ide_mm_inb(io_ports->lbal_addr);
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAM)
-			tf->hob_lbam  = ide_mm_inb(io_ports->lbam_addr);
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAH)
-			tf->hob_lbah  = ide_mm_inb(io_ports->lbah_addr);
-	}
-}
-
 static void at91_ide_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	struct ide_timing *timing;
@@ -284,8 +200,8 @@ static const struct ide_tp_ops at91_ide_
 	.write_devctl	= ide_write_devctl,
 
 	.dev_select	= ide_dev_select,
-	.tf_load	= at91_ide_tf_load,
-	.tf_read	= at91_ide_tf_read,
+	.tf_load	= ide_tf_load,
+	.tf_read	= ide_tf_read,
 
 	.input_data	= at91_ide_input_data,
 	.output_data	= at91_ide_output_data,

