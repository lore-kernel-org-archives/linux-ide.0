From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 2/2] ide: use ATA_HOB
Date: Mon, 16 Mar 2009 19:34:31 +0400
Message-ID: <200903161834.31142.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:40968 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753322AbZCPPdr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Mar 2009 11:33:47 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Make use of ATA_HOB instead of hard-coded value in the tf_read() method.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch is atop of the latest pata-2.6 series...

 drivers/ide/at91_ide.c   |    4 ++--
 drivers/ide/ide-h8300.c  |    4 ++--
 drivers/ide/ide-io-std.c |    4 ++--
 drivers/ide/ns87415.c    |    4 ++--
 drivers/ide/scc_pata.c   |    4 ++--
 drivers/ide/tx4938ide.c  |    4 ++--
 drivers/ide/tx4939ide.c  |    4 ++--
 7 files changed, 14 insertions(+), 14 deletions(-)

Index: linux-2.6/drivers/ide/ide-h8300.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-h8300.c
+++ linux-2.6/drivers/ide/ide-h8300.c
@@ -98,7 +98,7 @@ static void h8300_tf_read(ide_drive_t *d
 	}
 
 	/* be sure we're looking at the low order bits */
-	outb(ATA_DEVCTL_OBS & ~0x80, io_ports->ctl_addr);
+	outb(ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
 	if (cmd->tf_flags & IDE_TFLAG_IN_FEATURE)
 		tf->feature = inb(io_ports->feature_addr);
@@ -114,7 +114,7 @@ static void h8300_tf_read(ide_drive_t *d
 		tf->device = inb(io_ports->device_addr);
 
 	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
-		outb(ATA_DEVCTL_OBS | 0x80, io_ports->ctl_addr);
+		outb(ATA_HOB | ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_FEATURE)
 			tf->hob_feature = inb(io_ports->feature_addr);
Index: linux-2.6/drivers/ide/ide-io-std.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-io-std.c
+++ linux-2.6/drivers/ide/ide-io-std.c
@@ -166,7 +166,7 @@ void ide_tf_read(ide_drive_t *drive, str
 	}
 
 	/* be sure we're looking at the low order bits */
-	tf_outb(ATA_DEVCTL_OBS & ~0x80, io_ports->ctl_addr);
+	tf_outb(ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
 	if (cmd->tf_flags & IDE_TFLAG_IN_FEATURE)
 		tf->feature = tf_inb(io_ports->feature_addr);
@@ -182,7 +182,7 @@ void ide_tf_read(ide_drive_t *drive, str
 		tf->device = tf_inb(io_ports->device_addr);
 
 	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
-		tf_outb(ATA_DEVCTL_OBS | 0x80, io_ports->ctl_addr);
+		tf_outb(ATA_HOB | ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_FEATURE)
 			tf->hob_feature = tf_inb(io_ports->feature_addr);
Index: linux-2.6/drivers/ide/ns87415.c
===================================================================
--- linux-2.6.orig/drivers/ide/ns87415.c
+++ linux-2.6/drivers/ide/ns87415.c
@@ -74,7 +74,7 @@ static void superio_tf_read(ide_drive_t 
 	}
 
 	/* be sure we're looking at the low order bits */
-	outb(ATA_DEVCTL_OBS & ~0x80, io_ports->ctl_addr);
+	outb(ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
 	if (cmd->tf_flags & IDE_TFLAG_IN_FEATURE)
 		tf->feature = inb(io_ports->feature_addr);
@@ -90,7 +90,7 @@ static void superio_tf_read(ide_drive_t 
 		tf->device = superio_ide_inb(io_ports->device_addr);
 
 	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
-		outb(ATA_DEVCTL_OBS | 0x80, io_ports->ctl_addr);
+		outb(ATA_HOB | ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_FEATURE)
 			tf->hob_feature = inb(io_ports->feature_addr);
Index: linux-2.6/drivers/ide/scc_pata.c
===================================================================
--- linux-2.6.orig/drivers/ide/scc_pata.c
+++ linux-2.6/drivers/ide/scc_pata.c
@@ -709,7 +709,7 @@ static void scc_tf_read(ide_drive_t *dri
 	}
 
 	/* be sure we're looking at the low order bits */
-	scc_ide_outb(ATA_DEVCTL_OBS & ~0x80, io_ports->ctl_addr);
+	scc_ide_outb(ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
 	if (cmd->tf_flags & IDE_TFLAG_IN_FEATURE)
 		tf->feature = scc_ide_inb(io_ports->feature_addr);
@@ -725,7 +725,7 @@ static void scc_tf_read(ide_drive_t *dri
 		tf->device = scc_ide_inb(io_ports->device_addr);
 
 	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
-		scc_ide_outb(ATA_DEVCTL_OBS | 0x80, io_ports->ctl_addr);
+		scc_ide_outb(ATA_HOB | ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_FEATURE)
 			tf->hob_feature = scc_ide_inb(io_ports->feature_addr);
Index: linux-2.6/drivers/ide/tx4938ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/tx4938ide.c
+++ linux-2.6/drivers/ide/tx4938ide.c
@@ -142,7 +142,7 @@ static void tx4938ide_tf_read(ide_drive_
 	}
 
 	/* be sure we're looking at the low order bits */
-	tx4938ide_outb(ATA_DEVCTL_OBS & ~0x80, io_ports->ctl_addr);
+	tx4938ide_outb(ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
 	if (cmd->tf_flags & IDE_TFLAG_IN_FEATURE)
 		tf->feature = tx4938ide_inb(io_ports->feature_addr);
@@ -158,7 +158,7 @@ static void tx4938ide_tf_read(ide_drive_
 		tf->device = tx4938ide_inb(io_ports->device_addr);
 
 	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
-		tx4938ide_outb(ATA_DEVCTL_OBS | 0x80, io_ports->ctl_addr);
+		tx4938ide_outb(ATA_HOB | ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_FEATURE)
 			tf->hob_feature =
Index: linux-2.6/drivers/ide/tx4939ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/tx4939ide.c
+++ linux-2.6/drivers/ide/tx4939ide.c
@@ -509,7 +509,7 @@ static void tx4939ide_tf_read(ide_drive_
 	}
 
 	/* be sure we're looking at the low order bits */
-	tx4939ide_outb(ATA_DEVCTL_OBS & ~0x80, io_ports->ctl_addr);
+	tx4939ide_outb(ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
 	if (cmd->tf_flags & IDE_TFLAG_IN_FEATURE)
 		tf->feature = tx4939ide_inb(io_ports->feature_addr);
@@ -525,7 +525,7 @@ static void tx4939ide_tf_read(ide_drive_
 		tf->device = tx4939ide_inb(io_ports->device_addr);
 
 	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
-		tx4939ide_outb(ATA_DEVCTL_OBS | 0x80, io_ports->ctl_addr);
+		tx4939ide_outb(ATA_HOB | ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_FEATURE)
 			tf->hob_feature =
Index: linux-2.6/drivers/ide/at91_ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/at91_ide.c
+++ linux-2.6/drivers/ide/at91_ide.c
@@ -242,7 +242,7 @@ static void at91_ide_tf_read(ide_drive_t
 	}
 
 	/* be sure we're looking at the low order bits */
-	ide_mm_outb(ATA_DEVCTL_OBS & ~0x80, io_ports->ctl_addr);
+	ide_mm_outb(ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
 	if (cmd->tf_flags & IDE_TFLAG_IN_FEATURE)
 		tf->feature = ide_mm_inb(io_ports->feature_addr);
@@ -258,7 +258,7 @@ static void at91_ide_tf_read(ide_drive_t
 		tf->device = ide_mm_inb(io_ports->device_addr);
 
 	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
-		ide_mm_outb(ATA_DEVCTL_OBS | 0x80, io_ports->ctl_addr);
+		ide_mm_outb(ATA_HOB | ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_FEATURE)
 			tf->hob_feature = ide_mm_inb(io_ports->feature_addr);

