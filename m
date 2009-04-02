From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 4/6] ide: call write_devctl() method from tf_read() method
Date: Thu, 2 Apr 2009 23:05:58 +0400
Message-ID: <200904022305.58026.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:12554 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752028AbZDBTF1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Apr 2009 15:05:27 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Use write_devctl() method to clear/set the HOB bit in tf_read() method.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the current Linus' tree...

 drivers/ide/ide-io-std.c |   12 ++++--------
 drivers/ide/ns87415.c    |    4 ++--
 drivers/ide/scc_pata.c   |    4 ++--
 drivers/ide/tx4938ide.c  |    4 ++--
 drivers/ide/tx4939ide.c  |    4 ++--
 5 files changed, 12 insertions(+), 16 deletions(-)

Index: linux-2.6/drivers/ide/ide-io-std.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-io-std.c
+++ linux-2.6/drivers/ide/ide-io-std.c
@@ -133,21 +133,17 @@ void ide_tf_read(ide_drive_t *drive, str
 	ide_hwif_t *hwif = drive->hwif;
 	struct ide_io_ports *io_ports = &hwif->io_ports;
 	struct ide_taskfile *tf = &cmd->tf;
-	void (*tf_outb)(u8 addr, unsigned long port);
 	u8 (*tf_inb)(unsigned long port);
 	u8 valid = cmd->valid.in.tf;
 	u8 mmio = (hwif->host_flags & IDE_HFLAG_MMIO) ? 1 : 0;
 
-	if (mmio) {
-		tf_outb = ide_mm_outb;
+	if (mmio)
 		tf_inb  = ide_mm_inb;
-	} else {
-		tf_outb = ide_outb;
+	else
 		tf_inb  = ide_inb;
-	}
 
 	/* be sure we're looking at the low order bits */
-	tf_outb(ATA_DEVCTL_OBS, io_ports->ctl_addr);
+	hwif->tp_ops->write_devctl(hwif, ATA_DEVCTL_OBS);
 
 	if (valid & IDE_VALID_ERROR)
 		tf->error  = tf_inb(io_ports->feature_addr);
@@ -163,7 +159,7 @@ void ide_tf_read(ide_drive_t *drive, str
 		tf->device = tf_inb(io_ports->device_addr);
 
 	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
-		tf_outb(ATA_HOB | ATA_DEVCTL_OBS, io_ports->ctl_addr);
+		hwif->tp_ops->write_devctl(hwif, ATA_HOB | ATA_DEVCTL_OBS);
 
 		tf = &cmd->hob;
 		valid = cmd->valid.in.hob;
Index: linux-2.6/drivers/ide/ns87415.c
===================================================================
--- linux-2.6.orig/drivers/ide/ns87415.c
+++ linux-2.6/drivers/ide/ns87415.c
@@ -68,7 +68,7 @@ static void superio_tf_read(ide_drive_t 
 	u8 valid = cmd->valid.in.tf;
 
 	/* be sure we're looking at the low order bits */
-	outb(ATA_DEVCTL_OBS, io_ports->ctl_addr);
+	ide_write_devctl(hwif, ATA_DEVCTL_OBS);
 
 	if (valid & IDE_VALID_ERROR)
 		tf->error  = inb(io_ports->feature_addr);
@@ -84,7 +84,7 @@ static void superio_tf_read(ide_drive_t 
 		tf->device = superio_ide_inb(io_ports->device_addr);
 
 	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
-		outb(ATA_HOB | ATA_DEVCTL_OBS, io_ports->ctl_addr);
+		ide_write_devctl(hwif, ATA_HOB | ATA_DEVCTL_OBS);
 
 		tf = &cmd->hob;
 		valid = cmd->valid.in.hob;
Index: linux-2.6/drivers/ide/scc_pata.c
===================================================================
--- linux-2.6.orig/drivers/ide/scc_pata.c
+++ linux-2.6/drivers/ide/scc_pata.c
@@ -688,7 +688,7 @@ static void scc_tf_read(ide_drive_t *dri
 	u8 valid = cmd->valid.in.tf;
 
 	/* be sure we're looking at the low order bits */
-	scc_ide_outb(ATA_DEVCTL_OBS, io_ports->ctl_addr);
+	scc_write_devctl(hwif, ATA_DEVCTL_OBS);
 
 	if (valid & IDE_VALID_ERROR)
 		tf->error  = scc_ide_inb(io_ports->feature_addr);
@@ -704,7 +704,7 @@ static void scc_tf_read(ide_drive_t *dri
 		tf->device = scc_ide_inb(io_ports->device_addr);
 
 	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
-		scc_ide_outb(ATA_HOB | ATA_DEVCTL_OBS, io_ports->ctl_addr);
+		scc_write_devctl(hwif, ATA_HOB | ATA_DEVCTL_OBS);
 
 		tf = &cmd->hob;
 		valid = cmd->valid.in.hob;
Index: linux-2.6/drivers/ide/tx4938ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/tx4938ide.c
+++ linux-2.6/drivers/ide/tx4938ide.c
@@ -125,7 +125,7 @@ static void tx4938ide_tf_read(ide_drive_
 	u8 valid = cmd->valid.in.tf;
 
 	/* be sure we're looking at the low order bits */
-	tx4938ide_outb(ATA_DEVCTL_OBS, io_ports->ctl_addr);
+	ide_write_devctl(hwif, ATA_DEVCTL_OBS);
 
 	if (valid & IDE_VALID_ERROR)
 		tf->error  = tx4938ide_inb(io_ports->feature_addr);
@@ -141,7 +141,7 @@ static void tx4938ide_tf_read(ide_drive_
 		tf->device = tx4938ide_inb(io_ports->device_addr);
 
 	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
-		tx4938ide_outb(ATA_HOB | ATA_DEVCTL_OBS, io_ports->ctl_addr);
+		ide_write_devctl(hwif, ATA_HOB | ATA_DEVCTL_OBS);
 
 		tf = &cmd->hob;
 		valid = cmd->valid.in.hob;
Index: linux-2.6/drivers/ide/tx4939ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/tx4939ide.c
+++ linux-2.6/drivers/ide/tx4939ide.c
@@ -492,7 +492,7 @@ static void tx4939ide_tf_read(ide_drive_
 	u8 valid = cmd->valid.in.tf;
 
 	/* be sure we're looking at the low order bits */
-	tx4939ide_outb(ATA_DEVCTL_OBS, io_ports->ctl_addr);
+	ide_write_devctl(hwif, ATA_DEVCTL_OBS);
 
 	if (valid & IDE_VALID_ERROR)
 		tf->error  = tx4939ide_inb(io_ports->feature_addr);
@@ -508,7 +508,7 @@ static void tx4939ide_tf_read(ide_drive_
 		tf->device = tx4939ide_inb(io_ports->device_addr);
 
 	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
-		tx4939ide_outb(ATA_HOB | ATA_DEVCTL_OBS, io_ports->ctl_addr);
+		ide_write_devctl(hwif, ATA_HOB | ATA_DEVCTL_OBS);
 
 		tf = &cmd->hob;
 		valid = cmd->valid.in.hob;

