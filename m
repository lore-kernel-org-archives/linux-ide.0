From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 1/4] ide: rename IDE_TFLAG_IN_[HOB_]FEATURE
Date: Wed, 18 Mar 2009 21:40:22 +0400
Message-ID: <200903182040.22335.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:38074 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752937AbZCRRjk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Mar 2009 13:39:40 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

The feature register has never been readable -- when its location is read, one
gets the error register value; hence rename IDE_TFLAG_IN_[HOB_]FEATURE into
IDE_TFLAG_IN_[HOB_]ERROR and introduce the 'hob_error' field into the 'struct
ide_taskfile' (despite the error register not really depending on the HOB bit).

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch is atop of the latest pata-2.6 series...

 drivers/ide/at91_ide.c   |   16 ++++++++--------
 drivers/ide/ide-h8300.c  |   16 ++++++++--------
 drivers/ide/ide-io-std.c |   16 ++++++++--------
 drivers/ide/ide-iops.c   |    2 +-
 drivers/ide/ns87415.c    |   16 ++++++++--------
 drivers/ide/scc_pata.c   |   16 ++++++++--------
 drivers/ide/tx4938ide.c  |   17 ++++++++---------
 drivers/ide/tx4939ide.c  |   17 ++++++++---------
 include/linux/ide.h      |   12 ++++++++----
 9 files changed, 65 insertions(+), 63 deletions(-)

Index: linux-2.6/drivers/ide/at91_ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/at91_ide.c
+++ linux-2.6/drivers/ide/at91_ide.c
@@ -244,8 +244,8 @@ static void at91_ide_tf_read(ide_drive_t
 	/* be sure we're looking at the low order bits */
 	ide_mm_outb(ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
-	if (cmd->tf_flags & IDE_TFLAG_IN_FEATURE)
-		tf->feature = ide_mm_inb(io_ports->feature_addr);
+	if (cmd->tf_flags & IDE_TFLAG_IN_ERROR)
+		tf->error  = ide_mm_inb(io_ports->feature_addr);
 	if (cmd->tf_flags & IDE_TFLAG_IN_NSECT)
 		tf->nsect  = ide_mm_inb(io_ports->nsect_addr);
 	if (cmd->tf_flags & IDE_TFLAG_IN_LBAL)
@@ -260,16 +260,16 @@ static void at91_ide_tf_read(ide_drive_t
 	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
 		ide_mm_outb(ATA_HOB | ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_FEATURE)
-			tf->hob_feature = ide_mm_inb(io_ports->feature_addr);
+		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_ERROR)
+			tf->hob_error = ide_mm_inb(io_ports->feature_addr);
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_NSECT)
-			tf->hob_nsect   = ide_mm_inb(io_ports->nsect_addr);
+			tf->hob_nsect = ide_mm_inb(io_ports->nsect_addr);
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAL)
-			tf->hob_lbal    = ide_mm_inb(io_ports->lbal_addr);
+			tf->hob_lbal  = ide_mm_inb(io_ports->lbal_addr);
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAM)
-			tf->hob_lbam    = ide_mm_inb(io_ports->lbam_addr);
+			tf->hob_lbam  = ide_mm_inb(io_ports->lbam_addr);
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAH)
-			tf->hob_lbah    = ide_mm_inb(io_ports->lbah_addr);
+			tf->hob_lbah  = ide_mm_inb(io_ports->lbah_addr);
 	}
 }
 
Index: linux-2.6/drivers/ide/ide-h8300.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-h8300.c
+++ linux-2.6/drivers/ide/ide-h8300.c
@@ -100,8 +100,8 @@ static void h8300_tf_read(ide_drive_t *d
 	/* be sure we're looking at the low order bits */
 	outb(ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
-	if (cmd->tf_flags & IDE_TFLAG_IN_FEATURE)
-		tf->feature = inb(io_ports->feature_addr);
+	if (cmd->tf_flags & IDE_TFLAG_IN_ERROR)
+		tf->error  = inb(io_ports->feature_addr);
 	if (cmd->tf_flags & IDE_TFLAG_IN_NSECT)
 		tf->nsect  = inb(io_ports->nsect_addr);
 	if (cmd->tf_flags & IDE_TFLAG_IN_LBAL)
@@ -116,16 +116,16 @@ static void h8300_tf_read(ide_drive_t *d
 	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
 		outb(ATA_HOB | ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_FEATURE)
-			tf->hob_feature = inb(io_ports->feature_addr);
+		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_ERROR)
+			tf->hob_error = inb(io_ports->feature_addr);
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_NSECT)
-			tf->hob_nsect   = inb(io_ports->nsect_addr);
+			tf->hob_nsect = inb(io_ports->nsect_addr);
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAL)
-			tf->hob_lbal    = inb(io_ports->lbal_addr);
+			tf->hob_lbal  = inb(io_ports->lbal_addr);
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAM)
-			tf->hob_lbam    = inb(io_ports->lbam_addr);
+			tf->hob_lbam  = inb(io_ports->lbam_addr);
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAH)
-			tf->hob_lbah    = inb(io_ports->lbah_addr);
+			tf->hob_lbah  = inb(io_ports->lbah_addr);
 	}
 }
 
Index: linux-2.6/drivers/ide/ide-io-std.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-io-std.c
+++ linux-2.6/drivers/ide/ide-io-std.c
@@ -168,8 +168,8 @@ void ide_tf_read(ide_drive_t *drive, str
 	/* be sure we're looking at the low order bits */
 	tf_outb(ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
-	if (cmd->tf_flags & IDE_TFLAG_IN_FEATURE)
-		tf->feature = tf_inb(io_ports->feature_addr);
+	if (cmd->tf_flags & IDE_TFLAG_IN_ERROR)
+		tf->error  = tf_inb(io_ports->feature_addr);
 	if (cmd->tf_flags & IDE_TFLAG_IN_NSECT)
 		tf->nsect  = tf_inb(io_ports->nsect_addr);
 	if (cmd->tf_flags & IDE_TFLAG_IN_LBAL)
@@ -184,16 +184,16 @@ void ide_tf_read(ide_drive_t *drive, str
 	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
 		tf_outb(ATA_HOB | ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_FEATURE)
-			tf->hob_feature = tf_inb(io_ports->feature_addr);
+		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_ERROR)
+			tf->hob_error = tf_inb(io_ports->feature_addr);
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_NSECT)
-			tf->hob_nsect   = tf_inb(io_ports->nsect_addr);
+			tf->hob_nsect = tf_inb(io_ports->nsect_addr);
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAL)
-			tf->hob_lbal    = tf_inb(io_ports->lbal_addr);
+			tf->hob_lbal  = tf_inb(io_ports->lbal_addr);
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAM)
-			tf->hob_lbam    = tf_inb(io_ports->lbam_addr);
+			tf->hob_lbam  = tf_inb(io_ports->lbam_addr);
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAH)
-			tf->hob_lbah    = tf_inb(io_ports->lbah_addr);
+			tf->hob_lbah  = tf_inb(io_ports->lbah_addr);
 	}
 }
 EXPORT_SYMBOL_GPL(ide_tf_read);
Index: linux-2.6/drivers/ide/ide-iops.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-iops.c
+++ linux-2.6/drivers/ide/ide-iops.c
@@ -55,7 +55,7 @@ u8 ide_read_error(ide_drive_t *drive)
 	struct ide_cmd cmd;
 
 	memset(&cmd, 0, sizeof(cmd));
-	cmd.tf_flags = IDE_TFLAG_IN_FEATURE;
+	cmd.tf_flags = IDE_TFLAG_IN_ERROR;
 
 	drive->hwif->tp_ops->tf_read(drive, &cmd);
 
Index: linux-2.6/drivers/ide/ns87415.c
===================================================================
--- linux-2.6.orig/drivers/ide/ns87415.c
+++ linux-2.6/drivers/ide/ns87415.c
@@ -76,8 +76,8 @@ static void superio_tf_read(ide_drive_t 
 	/* be sure we're looking at the low order bits */
 	outb(ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
-	if (cmd->tf_flags & IDE_TFLAG_IN_FEATURE)
-		tf->feature = inb(io_ports->feature_addr);
+	if (cmd->tf_flags & IDE_TFLAG_IN_ERROR)
+		tf->error  = inb(io_ports->feature_addr);
 	if (cmd->tf_flags & IDE_TFLAG_IN_NSECT)
 		tf->nsect  = inb(io_ports->nsect_addr);
 	if (cmd->tf_flags & IDE_TFLAG_IN_LBAL)
@@ -92,16 +92,16 @@ static void superio_tf_read(ide_drive_t 
 	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
 		outb(ATA_HOB | ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_FEATURE)
-			tf->hob_feature = inb(io_ports->feature_addr);
+		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_ERROR)
+			tf->hob_error = inb(io_ports->feature_addr);
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_NSECT)
-			tf->hob_nsect   = inb(io_ports->nsect_addr);
+			tf->hob_nsect = inb(io_ports->nsect_addr);
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAL)
-			tf->hob_lbal    = inb(io_ports->lbal_addr);
+			tf->hob_lbal  = inb(io_ports->lbal_addr);
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAM)
-			tf->hob_lbam    = inb(io_ports->lbam_addr);
+			tf->hob_lbam  = inb(io_ports->lbam_addr);
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAH)
-			tf->hob_lbah    = inb(io_ports->lbah_addr);
+			tf->hob_lbah  = inb(io_ports->lbah_addr);
 	}
 }
 
Index: linux-2.6/drivers/ide/scc_pata.c
===================================================================
--- linux-2.6.orig/drivers/ide/scc_pata.c
+++ linux-2.6/drivers/ide/scc_pata.c
@@ -711,8 +711,8 @@ static void scc_tf_read(ide_drive_t *dri
 	/* be sure we're looking at the low order bits */
 	scc_ide_outb(ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
-	if (cmd->tf_flags & IDE_TFLAG_IN_FEATURE)
-		tf->feature = scc_ide_inb(io_ports->feature_addr);
+	if (cmd->tf_flags & IDE_TFLAG_IN_ERROR)
+		tf->error  = scc_ide_inb(io_ports->feature_addr);
 	if (cmd->tf_flags & IDE_TFLAG_IN_NSECT)
 		tf->nsect  = scc_ide_inb(io_ports->nsect_addr);
 	if (cmd->tf_flags & IDE_TFLAG_IN_LBAL)
@@ -727,16 +727,16 @@ static void scc_tf_read(ide_drive_t *dri
 	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
 		scc_ide_outb(ATA_HOB | ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_FEATURE)
-			tf->hob_feature = scc_ide_inb(io_ports->feature_addr);
+		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_ERROR)
+			tf->hob_error = scc_ide_inb(io_ports->feature_addr);
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_NSECT)
-			tf->hob_nsect   = scc_ide_inb(io_ports->nsect_addr);
+			tf->hob_nsect = scc_ide_inb(io_ports->nsect_addr);
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAL)
-			tf->hob_lbal    = scc_ide_inb(io_ports->lbal_addr);
+			tf->hob_lbal  = scc_ide_inb(io_ports->lbal_addr);
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAM)
-			tf->hob_lbam    = scc_ide_inb(io_ports->lbam_addr);
+			tf->hob_lbam  = scc_ide_inb(io_ports->lbam_addr);
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAH)
-			tf->hob_lbah    = scc_ide_inb(io_ports->lbah_addr);
+			tf->hob_lbah  = scc_ide_inb(io_ports->lbah_addr);
 	}
 }
 
Index: linux-2.6/drivers/ide/tx4938ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/tx4938ide.c
+++ linux-2.6/drivers/ide/tx4938ide.c
@@ -144,8 +144,8 @@ static void tx4938ide_tf_read(ide_drive_
 	/* be sure we're looking at the low order bits */
 	tx4938ide_outb(ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
-	if (cmd->tf_flags & IDE_TFLAG_IN_FEATURE)
-		tf->feature = tx4938ide_inb(io_ports->feature_addr);
+	if (cmd->tf_flags & IDE_TFLAG_IN_ERROR)
+		tf->error  = tx4938ide_inb(io_ports->feature_addr);
 	if (cmd->tf_flags & IDE_TFLAG_IN_NSECT)
 		tf->nsect  = tx4938ide_inb(io_ports->nsect_addr);
 	if (cmd->tf_flags & IDE_TFLAG_IN_LBAL)
@@ -160,17 +160,16 @@ static void tx4938ide_tf_read(ide_drive_
 	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
 		tx4938ide_outb(ATA_HOB | ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_FEATURE)
-			tf->hob_feature =
-				tx4938ide_inb(io_ports->feature_addr);
+		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_ERROR)
+			tf->hob_error = tx4938ide_inb(io_ports->feature_addr);
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_NSECT)
-			tf->hob_nsect   = tx4938ide_inb(io_ports->nsect_addr);
+			tf->hob_nsect = tx4938ide_inb(io_ports->nsect_addr);
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAL)
-			tf->hob_lbal    = tx4938ide_inb(io_ports->lbal_addr);
+			tf->hob_lbal  = tx4938ide_inb(io_ports->lbal_addr);
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAM)
-			tf->hob_lbam    = tx4938ide_inb(io_ports->lbam_addr);
+			tf->hob_lbam  = tx4938ide_inb(io_ports->lbam_addr);
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAH)
-			tf->hob_lbah    = tx4938ide_inb(io_ports->lbah_addr);
+			tf->hob_lbah  = tx4938ide_inb(io_ports->lbah_addr);
 	}
 }
 
Index: linux-2.6/drivers/ide/tx4939ide.c
===================================================================
--- linux-2.6.orig/drivers/ide/tx4939ide.c
+++ linux-2.6/drivers/ide/tx4939ide.c
@@ -511,8 +511,8 @@ static void tx4939ide_tf_read(ide_drive_
 	/* be sure we're looking at the low order bits */
 	tx4939ide_outb(ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
-	if (cmd->tf_flags & IDE_TFLAG_IN_FEATURE)
-		tf->feature = tx4939ide_inb(io_ports->feature_addr);
+	if (cmd->tf_flags & IDE_TFLAG_IN_ERROR)
+		tf->error  = tx4939ide_inb(io_ports->feature_addr);
 	if (cmd->tf_flags & IDE_TFLAG_IN_NSECT)
 		tf->nsect  = tx4939ide_inb(io_ports->nsect_addr);
 	if (cmd->tf_flags & IDE_TFLAG_IN_LBAL)
@@ -527,17 +527,16 @@ static void tx4939ide_tf_read(ide_drive_
 	if (cmd->tf_flags & IDE_TFLAG_LBA48) {
 		tx4939ide_outb(ATA_HOB | ATA_DEVCTL_OBS, io_ports->ctl_addr);
 
-		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_FEATURE)
-			tf->hob_feature =
-				tx4939ide_inb(io_ports->feature_addr);
+		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_ERROR)
+			tf->hob_error =	tx4939ide_inb(io_ports->feature_addr);
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_NSECT)
-			tf->hob_nsect   = tx4939ide_inb(io_ports->nsect_addr);
+			tf->hob_nsect = tx4939ide_inb(io_ports->nsect_addr);
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAL)
-			tf->hob_lbal    = tx4939ide_inb(io_ports->lbal_addr);
+			tf->hob_lbal  = tx4939ide_inb(io_ports->lbal_addr);
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAM)
-			tf->hob_lbam    = tx4939ide_inb(io_ports->lbam_addr);
+			tf->hob_lbam  = tx4939ide_inb(io_ports->lbam_addr);
 		if (cmd->tf_flags & IDE_TFLAG_IN_HOB_LBAH)
-			tf->hob_lbah    = tx4939ide_inb(io_ports->lbah_addr);
+			tf->hob_lbah  = tx4939ide_inb(io_ports->lbah_addr);
 	}
 }
 
Index: linux-2.6/include/linux/ide.h
===================================================================
--- linux-2.6.orig/include/linux/ide.h
+++ linux-2.6/include/linux/ide.h
@@ -265,7 +265,7 @@ enum {
 	IDE_TFLAG_WRITE			= (1 << 12),
 	IDE_TFLAG_CUSTOM_HANDLER	= (1 << 13),
 	IDE_TFLAG_DMA_PIO_FALLBACK	= (1 << 14),
-	IDE_TFLAG_IN_HOB_FEATURE	= (1 << 15),
+	IDE_TFLAG_IN_HOB_ERROR		= (1 << 15),
 	IDE_TFLAG_IN_HOB_NSECT		= (1 << 16),
 	IDE_TFLAG_IN_HOB_LBAL		= (1 << 17),
 	IDE_TFLAG_IN_HOB_LBAM		= (1 << 18),
@@ -273,10 +273,10 @@ enum {
 	IDE_TFLAG_IN_HOB_LBA		= IDE_TFLAG_IN_HOB_LBAL |
 					  IDE_TFLAG_IN_HOB_LBAM |
 					  IDE_TFLAG_IN_HOB_LBAH,
-	IDE_TFLAG_IN_HOB		= IDE_TFLAG_IN_HOB_FEATURE |
+	IDE_TFLAG_IN_HOB		= IDE_TFLAG_IN_HOB_ERROR |
 					  IDE_TFLAG_IN_HOB_NSECT |
 					  IDE_TFLAG_IN_HOB_LBA,
-	IDE_TFLAG_IN_FEATURE		= (1 << 20),
+	IDE_TFLAG_IN_ERROR		= (1 << 20),
 	IDE_TFLAG_IN_NSECT		= (1 << 21),
 	IDE_TFLAG_IN_LBAL		= (1 << 22),
 	IDE_TFLAG_IN_LBAM		= (1 << 23),
@@ -310,8 +310,12 @@ enum {
 
 struct ide_taskfile {
 	u8	hob_data;	/*  0: high data byte (for TASKFILE IOCTL) */
+				/*  1-5: additional data to support LBA48 */
+	union {
+		u8 hob_error;	/*   read: error */
+		u8 hob_feature;	/*  write: feature */
+	};
 
-	u8	hob_feature;	/*  1-5: additional data to support LBA48 */
 	u8	hob_nsect;
 	u8	hob_lbal;
 	u8	hob_lbam;

